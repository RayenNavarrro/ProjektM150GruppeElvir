import 'package:dart_mappable/dart_mappable.dart';

import 'stage_activity_answer.dart';

@MappableClass(discriminatorKey: "type")
abstract class StageActivity {
  final String id;
  final String title;
  final String task;
  final int maxPoints;

  StageActivity({
    required this.id,
    required this.title,
    required this.task,
    required this.maxPoints,
  });
}

abstract class ClosedQuestionActivity extends StageActivity {
  final List<StageActivityAnswer> answers;

  ClosedQuestionActivity({
    required String id,
    required String title,
    required String task,
    required int maxPoints,
    required this.answers,
  }) : super(id: id, title: title, task: task, maxPoints: maxPoints);
}

@MappableClass(discriminatorValue: "singleChoice")
class SingleChoiceActivity extends ClosedQuestionActivity {
  SingleChoiceActivity({
    required String id,
    required String title,
    required String task,
    required int maxPoints,
    required List<StageActivityAnswer> answers,
  }) : super(
          id: id,
          title: title,
          task: task,
          maxPoints: maxPoints,
          answers: answers,
        );
}

@MappableClass(discriminatorValue: "multipleChoice")
class MultipleChoiceActivity extends ClosedQuestionActivity {
  MultipleChoiceActivity({
    required String id,
    required String title,
    required String task,
    required int maxPoints,
    required List<StageActivityAnswer> answers,
  }) : super(
          id: id,
          title: title,
          task: task,
          maxPoints: maxPoints,
          answers: answers,
        );
}

@MappableClass(discriminatorValue: "textInput")
class TextInputActivity extends StageActivity {
  TextInputActivity(
      {required String id,
      required String title,
      required String task,
      required int maxPoints})
      : super(id: id, title: title, task: task, maxPoints: maxPoints);
}
