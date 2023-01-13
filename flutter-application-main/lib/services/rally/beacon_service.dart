import 'package:flutter_beacon/flutter_beacon.dart';

import '../../models/rally/rally_models.dart';

class BeaconService {
  late Stream<RangingResult> rangingStream;
  late Stream<MonitoringResult> monitoringStream;

  Future<bool> startRanging(Stage stage) async {
    List<Region> regions = _getIBeaconRegions(stage);

    if (regions.isEmpty) {
      return false;
    }

    await flutterBeacon.initializeScanning;

    rangingStream = flutterBeacon.ranging(regions).where((rangingResult) =>
        rangingResult.beacons.isNotEmpty &&
        rangingResult.beacons.any((beacon) => beacon.accuracy >= 0));

    return true;
  }

  List<Region> _getIBeaconRegions(Stage stage) {
    List<IBeaconLocationMarker> iBeaconLocationMarkers = [];

    for (var location in stage.locations) {
      iBeaconLocationMarkers.addAll(
          location.locationMarkers.whereType<IBeaconLocationMarker>().toList());
    }

    if (iBeaconLocationMarkers.isEmpty) {
      return <Region>[];
    }

    return iBeaconLocationMarkers
        .map((marker) => Region(
              identifier: marker.id,
              proximityUUID: marker.uuid,
              major: marker.major,
              minor: marker.minor,
            ))
        .toList();
  }
}
