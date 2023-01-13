import 'package:dart_mappable/dart_mappable.dart';

@MappableClass()
class RallyStage {
  final String id;
  final String rallyId;
  final String stageId;

  RallyStage({
    required this.id,
    required this.rallyId,
    required this.stageId,
  });
}
