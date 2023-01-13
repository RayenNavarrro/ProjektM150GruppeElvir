import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:gibz_mobileapp/navigation/navigation_stack.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/rally/rally_models.dart';

abstract class RallyState extends Equatable {
  final NavigationStack stack;
  final RallyState? previousState;

  List<Page> get pages => stack.pages;

  @override
  List<Object?> get props => [];

  const RallyState(this.stack, {this.previousState});
}

class PoppedPage extends RallyState {
  const PoppedPage(NavigationStack stack) : super(stack);
}

class UninitializedSetupState extends RallyState {
  const UninitializedSetupState(NavigationStack stack) : super(stack);
}

class PendingInitializationState extends RallyState {
  final PermissionStatus bluetoothStatus;
  final PermissionStatus bluetoothScanStatus;
  final PermissionStatus locationStatus;

  const PendingInitializationState(
    NavigationStack stack, {
    required this.bluetoothStatus,
    required this.bluetoothScanStatus,
    required this.locationStatus,
  }) : super(stack);

  @override
  List<Object?> get props => [
        bluetoothStatus,
        bluetoothScanStatus,
        locationStatus,
      ];
}

class NotStartedState extends RallyState {
  final String? errorMessage;

  const NotStartedState(NavigationStack stack, {this.errorMessage})
      : super(stack);

  @override
  List<Object?> get props => [errorMessage];
}

class PendingParticipatingPartyCompletion extends RallyState {
  final int? indexOfMemberToDelete;

  const PendingParticipatingPartyCompletion(
    NavigationStack stack, {
    this.indexOfMemberToDelete,
  }) : super(stack);

  @override
  List<Object?> get props => [indexOfMemberToDelete];
}

class PendingStageArrival extends RallyState {
  final Stage stage;
  final RangingResult? rangingResult;

  const PendingStageArrival(
    NavigationStack stack, {
    required this.stage,
    this.rangingResult,
  }) : super(stack);

  @override
  List<Object?> get props => [rangingResult];
}

class VisitingStage extends RallyState {
  const VisitingStage(NavigationStack stack) : super(stack);
}

class PendingChallenge extends RallyState {
  final List<String?>? answers;
  const PendingChallenge(
    NavigationStack stack, {
    this.answers,
  }) : super(stack);

  @override
  List<Object?> get props => [answers];
}

class DisplayingPoints extends RallyState {
  final int latestPoints;
  final int totalPoints;

  const DisplayingPoints(
    NavigationStack stack, {
    required this.latestPoints,
    required this.totalPoints,
  }) : super(stack);

  @override
  List<Object?> get props => [latestPoints, totalPoints];
}

class FinishedRally extends RallyState {
  const FinishedRally(NavigationStack stack) : super(stack);
}
