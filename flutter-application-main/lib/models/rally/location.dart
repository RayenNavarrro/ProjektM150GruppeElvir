import 'package:dart_mappable/dart_mappable.dart';

import 'location_marker.dart';

@MappableClass()
class Location {
  final String id;
  final String title;
  final List<LocationMarker> locationMarkers;

  Location({
    required this.id,
    required this.title,
    required this.locationMarkers,
  });
}
