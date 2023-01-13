import 'package:dart_mappable/dart_mappable.dart';
import 'package:gibz_mobileapp/models/rally/rally_models.dart';

@MappableClass()
class Stage {
  final String id;
  final String title;
  final StageInformation preArrivalInformation;
  final StageInformation information;
  final List<Location> locations;
  final StageActivity stageActivity;

  Stage({
    required this.id,
    required this.title,
    required this.preArrivalInformation,
    required this.information,
    required this.locations,
    required this.stageActivity,
  });
}
