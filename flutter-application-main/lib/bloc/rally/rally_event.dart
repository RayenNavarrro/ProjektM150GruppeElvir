import 'package:equatable/equatable.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:gibz_mobileapp/models/rally/stage.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class RallyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PoppedPageEvent extends RallyEvent {}

class PermissionsCheckInitiatedEvent extends RallyEvent {}

// class InitializationRequestedEvent extends RallyEvent {
//   @override
//   List<Object?> get props => [];
// }

class BluetoothPermissionChangedEvent extends RallyEvent {
  final PermissionStatus bluetoothPermissionStatus;

  BluetoothPermissionChangedEvent(this.bluetoothPermissionStatus);

  @override
  List<Object?> get props => [bluetoothPermissionStatus];
}

class BluetoothScanPermissionChangedEvent extends RallyEvent {
  final PermissionStatus bluetoothScanPermissionStatus;

  BluetoothScanPermissionChangedEvent(this.bluetoothScanPermissionStatus);

  @override
  List<Object?> get props => [bluetoothScanPermissionStatus];
}

class LocationPermissionChangedEvent extends RallyEvent {
  final PermissionStatus locationPermissionStatus;

  LocationPermissionChangedEvent(this.locationPermissionStatus);

  @override
  List<Object?> get props => [locationPermissionStatus];
}

class InitializationCompletedEvent extends RallyEvent {}

class RallyJoiningRequestedEvent extends RallyEvent {
  final int joiningCode;

  RallyJoiningRequestedEvent(this.joiningCode);

  @override
  List<Object?> get props => [joiningCode];
}

class InvalidJoiningCodeSubmittedEvent extends RallyEvent {
  final int joiningCode;

  InvalidJoiningCodeSubmittedEvent(this.joiningCode);

  @override
  List<Object?> get props => [joiningCode];
}

class TeamMemberDeletionRequestedEvent extends RallyEvent {
  final int indexOfMemberToDelete;

  TeamMemberDeletionRequestedEvent(this.indexOfMemberToDelete);

  @override
  List<Object?> get props => [indexOfMemberToDelete];
}

class ParticipatingPartyDetailsCompleteRequestEvent extends RallyEvent {
  final String participatingPartyId;
  final String title;
  final List<String> names;

  ParticipatingPartyDetailsCompleteRequestEvent({
    required this.participatingPartyId,
    required this.title,
    required this.names,
  });

  @override
  List<Object?> get props => [participatingPartyId, title, names];
}

class ReceivedBeaconRangingResultEvent extends RallyEvent {
  final RangingResult rangingResult;

  ReceivedBeaconRangingResultEvent(this.rangingResult);

  @override
  List<Object?> get props => [rangingResult];
}

class ArrivedAtLocationEvent extends RallyEvent {
  final Stage stage;
  final String? locationMarkerId;

  ArrivedAtLocationEvent(this.stage, {this.locationMarkerId});

  @override
  List<Object?> get props => [stage];
}

class ChallengeRequestedEvent extends RallyEvent {
  final Stage stage;

  ChallengeRequestedEvent(this.stage);

  @override
  List<Object?> get props => [stage];
}

class ActivityAnswerUpdatedEvent extends RallyEvent {
  final List<String?> answers;

  ActivityAnswerUpdatedEvent(this.answers);

  @override
  List<Object?> get props => [answers];
}

class AnswerSubmissionRequestedEvent extends RallyEvent {
  final String stageActivityId;
  final List<String?> answers;

  AnswerSubmissionRequestedEvent(this.stageActivityId, this.answers);

  @override
  List<Object?> get props => [answers];
}

class NextStageRequestedEvent extends RallyEvent {}

class StageActivityResultReceivedEvent extends RallyEvent {
  final int latestPoints;
  final int totalPoints;

  StageActivityResultReceivedEvent({
    required this.latestPoints,
    required this.totalPoints,
  });

  @override
  List<Object?> get props => [latestPoints, totalPoints];
}

class RestartRequestedEvent extends RallyEvent {}

class ResumeRequestedEvent extends RallyEvent {}

class StageSkipRequestedEvent extends RallyEvent {}
