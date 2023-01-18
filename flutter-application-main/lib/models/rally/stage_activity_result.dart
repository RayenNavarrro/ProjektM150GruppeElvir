import 'package:dart_mappable/dart_mappable.dart';
import 'package:gibz_mobileapp/models/rally/rally_models.dart';

@MappableClass()
class StageActivityResult {
  final String id;
  final List<ParticipatingPartyAnswer> answers;
  final int awardedPoints;
  final int totalPoints;
  final DateTime momentOfCompletion;

  StageActivityResult({
    required this.id,
    required this.answers,
    required this.awardedPoints,
    required this.totalPoints,
    required this.momentOfCompletion,
  });
}

@MappableClass(discriminatorKey: "type")
abstract class ParticipatingPartyAnswer {
  final String id;
  final bool isCorrect;

  ParticipatingPartyAnswer({
    required this.id,
    required this.isCorrect,
  });
}

@MappableClass(discriminatorValue: "closedQuestionAnswer")
class ClosedQuestionAnswer extends ParticipatingPartyAnswer {
  final StageActivityAnswer answer;

  ClosedQuestionAnswer({
    required String id,
    required bool isCorrect,
    required this.answer,
  }) : super(id: id, isCorrect: isCorrect);
}

@MappableClass(discriminatorValue: "openQuestionAnswer")
class OpenQuestionAnswer extends ParticipatingPartyAnswer {
  final String answerText;

  OpenQuestionAnswer({
    required String id,
    required bool isCorrect,
    required this.answerText,
  }) : super(id: id, isCorrect: isCorrect);
}
