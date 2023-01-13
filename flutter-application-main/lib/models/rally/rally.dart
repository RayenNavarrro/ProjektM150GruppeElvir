import 'package:dart_mappable/dart_mappable.dart';

import 'assignment.dart';
import 'rally_stage.dart';

@MappableClass()
class Rally {
  final String id;
  final String title;
  final List<RallyStage> rallyStages;
  final List<Assignment> assignments;

  Rally({
    required this.id,
    required this.title,
    required this.rallyStages,
    required this.assignments,
  });
}
