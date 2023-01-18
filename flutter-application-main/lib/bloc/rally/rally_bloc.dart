import 'dart:io';

import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_event.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_state.dart';
import 'package:gibz_mobileapp/data/apis/rally/participating_party_api.dart';
import 'package:gibz_mobileapp/data/apis/rally/rally_stage_api.dart';
import 'package:gibz_mobileapp/data/apis/rally/stage_activity_result_api.dart';
import 'package:gibz_mobileapp/models/rally/rally_models.dart';
import 'package:gibz_mobileapp/navigation/page_configuration.dart';
import 'package:gibz_mobileapp/services/rally/beacon_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RallyBloc extends Bloc<RallyEvent, RallyState> {
  final BeaconService beaconService;
  final ParticipatingPartyApi participatingPartyApi;
  final StageActivityResultApi stageActivityResultApi;
  final RallyStageApi rallyStageApi;

  String? rallyId;
  String? stageId;
  String? participatingPartyId;

  RallyBloc({
    required RallyState initialState,
    required this.participatingPartyApi,
    required this.stageActivityResultApi,
    required this.rallyStageApi,
    required this.beaconService,
  }) : super(initialState) {
    if (Platform.isIOS) {
      // Set default permission (only relevant for iOS)
      flutterBeacon
          .setLocationAuthorizationTypeDefault(AuthorizationStatus.whenInUse);
    }

    on<PoppedPageEvent>(_onPoppedPage);

    on<PermissionsCheckInitiatedEvent>(_onPermissionsCheckInitiated);
    on<BluetoothPermissionChangedEvent>(_onBluetoothPermissionChanged);
    on<BluetoothScanPermissionChangedEvent>(_onBluetoothScanPermissionChanged);
    on<LocationPermissionChangedEvent>(_onLocationPermissionChanged);

    // on<InitializationRequestedEvent>(_onInitializationRequested);
    on<RallyJoiningRequestedEvent>(_onRallyJoiningRequested);
    on<InvalidJoiningCodeSubmittedEvent>(_onInvalidJoiningCodeSubmitted);
    on<TeamMemberDeletionRequestedEvent>(_onTeamMamberDeletionRequested);
    on<ParticipatingPartyDetailsCompleteRequestEvent>(
        _onParticipatingPartyDetailsComplete);
    on<ReceivedBeaconRangingResultEvent>(_onReceivedBeaconRangingResult);
    on<ArrivedAtLocationEvent>(_onArrivedAtLocation);
    on<ChallengeRequestedEvent>(_onChallengeRequested);
    on<ActivityAnswerUpdatedEvent>(_onActivityAnswerUpdated);
    on<AnswerSubmissionRequestedEvent>(_onAnswerSubmissionRequested);
    on<StageActivityResultReceivedEvent>(_onStageActivityResultReceived);
    on<NextStageRequestedEvent>(_onNextStageRequested);
    on<RestartRequestedEvent>(_onRestartRequested);
    on<ResumeRequestedEvent>(_onResumeRequested);
    on<StageSkipRequestedEvent>(_onStageSkipRequested);
  }

  void _onPoppedPage(PoppedPageEvent event, Emitter<RallyState> emit) {
    emit(PoppedPage(state.stack.pop()));
  }

  Future<void> _onPermissionsCheckInitiated(
    PermissionsCheckInitiatedEvent event,
    Emitter<RallyState> emit,
  ) async {
    PermissionStatus bluetooth = await Permission.bluetooth.status;
    PermissionStatus bluetoothScan = await Permission.bluetoothScan.status;
    PermissionStatus location = await Permission.locationWhenInUse.status;

    if (Platform.isIOS) {
      bluetoothScan = PermissionStatus.granted;
    }

    if (bluetooth.isGranted && location.isGranted) {
      if (Platform.isAndroid && bluetoothScan.isGranted || Platform.isIOS) {
        emit(
          NotStartedState(state.stack.push(const RallyHomePageConfiguration())),
        );
        return;
      }
    }

    emit(PendingInitializationState(
      state.stack.push(const RallyPermissionsPageConfiguration()),
      bluetoothStatus: bluetooth,
      bluetoothScanStatus: bluetoothScan,
      locationStatus: location,
    ));
  }

  void _onBluetoothPermissionChanged(
    BluetoothPermissionChangedEvent event,
    Emitter<RallyState> emit,
  ) {
    PermissionStatus bluetoothScanStatus = Platform.isIOS
        ? PermissionStatus.granted
        : state is PendingInitializationState
            ? (state as PendingInitializationState).bluetoothScanStatus
            : PermissionStatus.denied;

    PermissionStatus locationStatus = state is PendingInitializationState
        ? (state as PendingInitializationState).locationStatus
        : PermissionStatus.denied;

    emit(PendingInitializationState(
      state.stack,
      bluetoothStatus: event.bluetoothPermissionStatus,
      bluetoothScanStatus: bluetoothScanStatus,
      locationStatus: locationStatus,
    ));
  }

  void _onBluetoothScanPermissionChanged(
    BluetoothScanPermissionChangedEvent event,
    Emitter<RallyState> emit,
  ) {
    PermissionStatus bluetoothStatus = state is PendingInitializationState
        ? (state as PendingInitializationState).bluetoothStatus
        : PermissionStatus.denied;

    PermissionStatus locationStatus = state is PendingInitializationState
        ? (state as PendingInitializationState).locationStatus
        : PermissionStatus.denied;

    emit(PendingInitializationState(
      state.stack,
      bluetoothStatus: bluetoothStatus,
      bluetoothScanStatus: event.bluetoothScanPermissionStatus,
      locationStatus: locationStatus,
    ));
  }

  void _onLocationPermissionChanged(
    LocationPermissionChangedEvent event,
    Emitter<RallyState> emit,
  ) {
    if (event.locationPermissionStatus.isGranted) {
      emit(NotStartedState(state.stack
          .copyWith(stack: () => [const RallyHomePageConfiguration()])));
    }
  }

  Future<void> _onRallyJoiningRequested(
    RallyJoiningRequestedEvent event,
    Emitter<RallyState> emit,
  ) async {
    final successfulRallyJoinResponse =
        await participatingPartyApi.createParticipatingParty(event.joiningCode);

    if (successfulRallyJoinResponse == null) {
      add(InvalidJoiningCodeSubmittedEvent(event.joiningCode));
      return;
    }

    _setRallyId(successfulRallyJoinResponse.rally.id);
    _setParticipatingPartyId(successfulRallyJoinResponse.participatingParty.id);

    _writeSharedPreferencesString("rallyId", rallyId ?? "");
    _writeSharedPreferencesString(
        "participatingPartyId", participatingPartyId ?? "");

    emit(
      PendingParticipatingPartyCompletion(
        state.stack.copyWith(
            stack: () => [
                  ParticipatingPartyFormPageConfiguration(
                    rally: successfulRallyJoinResponse.rally,
                    participatingParty:
                        successfulRallyJoinResponse.participatingParty,
                  )
                ]),
      ),
    );
  }

  void _onInvalidJoiningCodeSubmitted(
    InvalidJoiningCodeSubmittedEvent event,
    Emitter<RallyState> emit,
  ) {
    const errorMessage = "Der eingegebene Code ist ungültig.";
    emit(NotStartedState(state.stack, errorMessage: errorMessage));
  }

  void _onParticipatingPartyDetailsComplete(
    ParticipatingPartyDetailsCompleteRequestEvent event,
    Emitter<RallyState> emit,
  ) async {
    await participatingPartyApi
        .updateParticipatingParty(
      id: event.participatingPartyId,
      title: event.title,
      names: event.names,
    )
        .then((stage) async {
      if (stage != null) {
        stageId = stage.id;
        emit(PendingStageArrival(
          state.stack.copyWith(
              stack: () => [PendingStageArrivalPageConfiguration(stage)]),
          stage: stage,
        ));

        await _startRanging(stage, emit);
      } else {
        _removeSharedPreferenceData();
        emit(FinishedRally(state.stack.copyWith(
          stack: () => [const RallyEndPageConfiguration()],
        )));
      }
    });
  }

  void _onTeamMamberDeletionRequested(
    TeamMemberDeletionRequestedEvent event,
    Emitter<RallyState> emit,
  ) {
    emit(PendingParticipatingPartyCompletion(state.stack,
        indexOfMemberToDelete: event.indexOfMemberToDelete));
  }

  void _onReceivedBeaconRangingResult(
    ReceivedBeaconRangingResultEvent event,
    Emitter<RallyState> emit,
  ) {
    if (event.rangingResult.beacons.any((beacon) => [
          Proximity.far,
          Proximity.near,
          Proximity.immediate,
        ].contains(beacon.proximity))) {
      // [Proximity.immediate].contains(beacon.proximity))) {
      flutterBeacon.close;
      return add(ArrivedAtLocationEvent(
        (state as PendingStageArrival).stage,
        locationMarkerId: event.rangingResult.region.identifier,
      ));
    }

    if (state is PendingStageArrival) {
      emit(PendingStageArrival(
        state.stack,
        stage: (state as PendingStageArrival).stage,
      ));
    }
  }

  Future<void> _onArrivedAtLocation(
    ArrivedAtLocationEvent event,
    Emitter<RallyState> emit,
  ) async {
    if (event.locationMarkerId != null &&
        rallyId != null &&
        stageId != null &&
        participatingPartyId != null) {
      await rallyStageApi.addParticipatingPartyAppearance(
        rallyId: rallyId!,
        stageId: stageId!,
        participatingPartyId: participatingPartyId!,
        locationMarkerId: event.locationMarkerId!,
      );
    }
    emit(VisitingStage(state.stack.copyWith(
      stack: () => [StagePageConfiguration(event.stage)],
    )));
  }

  void _onChallengeRequested(
    ChallengeRequestedEvent event,
    Emitter<RallyState> emit,
  ) {
    emit(PendingChallenge(state.stack.push(
      StageActivityPageConfiguration(event.stage),
    )));
  }

  void _onActivityAnswerUpdated(
    ActivityAnswerUpdatedEvent event,
    Emitter<RallyState> emit,
  ) {
    emit(PendingChallenge(state.stack, answers: event.answers));
  }

  Future<void> _onAnswerSubmissionRequested(
    AnswerSubmissionRequestedEvent event,
    Emitter<RallyState> emit,
  ) async {
    if (rallyId != null && stageId != null && participatingPartyId != null) {
      final StageActivityResult? stageActivityResult =
          await stageActivityResultApi.submitStageActivityResult(
        rallyId!,
        stageId!,
        StageActivityResultCreationRequestDto(
          answers: event.answers,
          participatingPartyId: participatingPartyId!,
          stageActivityId: event.stageActivityId,
        ),
      );

      if (stageActivityResult != null) {
        _setLastCompletedStageId(stageId!);

        add(StageActivityResultReceivedEvent(
          latestPoints: stageActivityResult.awardedPoints,
          totalPoints: stageActivityResult.totalPoints,
        ));

        return;
      }

      // TODO: Handle missing stage activity result (e.g. submission error)
    }
  }

  void _onStageActivityResultReceived(
    StageActivityResultReceivedEvent event,
    Emitter<RallyState> emit,
  ) {
    emit(DisplayingPoints(
      state.stack.copyWith(
        stack: () => [
          PointsDisplayPageConfiguration(
            latestPoints: event.latestPoints,
            totalPoints: event.totalPoints,
          )
        ],
      ),
      latestPoints: event.latestPoints,
      totalPoints: event.totalPoints,
    ));
  }

  Future<void> _onNextStageRequested(
    NextStageRequestedEvent event,
    Emitter<RallyState> emit,
  ) async {
    if (rallyId != null && stageId != null && participatingPartyId != null) {
      final nextStage = await rallyStageApi.getNext(
          rallyId!, stageId!, participatingPartyId!);

      if (nextStage != null) {
        stageId = nextStage.id;

        emit(PendingStageArrival(
          state.stack.copyWith(
              stack: () => [PendingStageArrivalPageConfiguration(nextStage)]),
          stage: nextStage,
        ));

        await _startRanging(nextStage, emit);
      } else {
        _removeSharedPreferenceData();
        emit(FinishedRally(state.stack.copyWith(
          stack: () => [const RallyEndPageConfiguration()],
        )));
      }
    }
  }

  void _onRestartRequested(
    RestartRequestedEvent event,
    Emitter<RallyState> emit,
  ) {
    emit(NotStartedState(state.stack.copyWith(
      stack: () => [const RallyHomePageConfiguration()],
    )));
  }

  Future<void> _onResumeRequested(
    ResumeRequestedEvent event,
    Emitter<RallyState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final rallyId = prefs.getString("rallyId");
    final participatingPartyId = prefs.getString("participatingPartyId");
    final stageId = prefs.getString("lastCompletedStageId");

    if (rallyId != null && stageId != null && participatingPartyId != null) {
      this.rallyId = rallyId;
      this.participatingPartyId = participatingPartyId;
      this.stageId = stageId;

      final nextStage = await rallyStageApi.getNext(
        rallyId,
        stageId,
        participatingPartyId,
      );

      if (nextStage != null) {
        this.stageId = nextStage.id;
        emit(PendingStageArrival(
          state.stack.copyWith(
              stack: () => [PendingStageArrivalPageConfiguration(nextStage)]),
          stage: nextStage,
        ));

        await _startRanging(nextStage, emit);
      } else {
        _removeSharedPreferenceData();
        emit(FinishedRally(state.stack.copyWith(
          stack: () => [const RallyEndPageConfiguration()],
        )));
      }
    }
  }

  Future<void> _onStageSkipRequested(
    StageSkipRequestedEvent event,
    Emitter<RallyState> emit,
  ) async {
    if (rallyId != null && stageId != null && participatingPartyId != null) {
      final StageActivityResult? stageActivityResult =
          await stageActivityResultApi.submitStageActivityResult(
        rallyId!,
        stageId!,
        StageActivityResultCreationRequestDto(
          answers: [],
          participatingPartyId: participatingPartyId!,
          stageActivityId: null,
        ),
      );

      if (stageActivityResult != null) {
        _setLastCompletedStageId(stageId!);

        add(StageActivityResultReceivedEvent(
          latestPoints: stageActivityResult.awardedPoints,
          totalPoints: stageActivityResult.totalPoints,
        ));

        return;
      }

      // TODO: Handle missing stage activity result (e.g. submission error)
    }
  }

  @override
  void onChange(Change<RallyState> change) {
    super.onChange(change);
  }

  Future<void> _startRanging(Stage stage, Emitter<RallyState> emit) async {
    if (await beaconService.startRanging(stage)) {
      await emit.forEach(
        beaconService.rangingStream,
        onData: (RangingResult rangingResult) {
          print(rangingResult);
          add(ReceivedBeaconRangingResultEvent(rangingResult));
          return state;
        },
      );
    }
  }

  Future<void> _setRallyId(String rallyId) async {
    this.rallyId = rallyId;
    _writeSharedPreferencesString("rallyId", rallyId);
  }

  Future<void> _setParticipatingPartyId(String participatingPartyId) async {
    this.participatingPartyId = participatingPartyId;
    _writeSharedPreferencesString("participatingPartyId", participatingPartyId);
  }

  Future<void> _setLastCompletedStageId(String stageId) async {
    _writeSharedPreferencesString("lastCompletedStageId", stageId);
  }

  Future<void> _writeSharedPreferencesString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> _removeSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('rallyId');
    await prefs.remove('participatingPartyId');
    await prefs.remove('stageId');
  }
}
