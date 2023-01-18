import 'package:dart_mappable/dart_mappable.dart';
import 'package:gibz_mobileapp/models/rally/participating_party.dart';

@MappableClass()
class Audience {
  final String id;
  final String title;
  final List<ParticipatingParty> participatingParties;

  Audience({
    required this.id,
    required this.title,
    required this.participatingParties,
  });
}
