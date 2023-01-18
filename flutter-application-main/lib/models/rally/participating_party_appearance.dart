import 'package:dart_mappable/dart_mappable.dart';
import 'package:gibz_mobileapp/models/rally/rally_models.dart';

@MappableClass()
class ParticipatingPartyAppearance {
  final String id;
  final ParticipatingParty participatingParty;
  final LocationMarker locationMarker;

  ParticipatingPartyAppearance({
    required this.id,
    required this.participatingParty,
    required this.locationMarker,
  });
}
