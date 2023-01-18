import 'package:dart_mappable/dart_mappable.dart';

@MappableClass()
class StageActivityAnswer {
  final String id;
  final String answerText;

  StageActivityAnswer({required this.id, required this.answerText});
}
