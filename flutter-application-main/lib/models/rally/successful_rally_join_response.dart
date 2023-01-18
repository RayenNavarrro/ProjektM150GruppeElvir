import 'package:dart_mappable/dart_mappable.dart';
import 'package:gibz_mobileapp/models/rally/participating_party.dart';
import 'package:gibz_mobileapp/models/rally/rally.dart';

@MappableClass()
class SuccessfulRallyJoinResponse {
  final ParticipatingParty participatingParty;
  final Rally rally;

  SuccessfulRallyJoinResponse({
    required this.participatingParty,
    required this.rally,
  });
}
