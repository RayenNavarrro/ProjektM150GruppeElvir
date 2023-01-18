import 'package:dart_mappable/dart_mappable.dart';

@MappableClass(discriminatorKey: "type")
abstract class LocationMarker {
  final String id;

  LocationMarker(this.id);
}

@MappableClass(discriminatorValue: "IBeaconLocationMarker")
class IBeaconLocationMarker extends LocationMarker {
  final String uuid;
  final int? major;
  final int? minor;

  IBeaconLocationMarker(
    String id, {
    required this.uuid,
    required this.major,
    required this.minor,
  }) : super(id);
}

@MappableClass(discriminatorValue: "QRCodeLocationMarker")
class QRCodeLocationMarker extends LocationMarker {
  final String content;

  QRCodeLocationMarker(String id, {required this.content}) : super(id);
}
