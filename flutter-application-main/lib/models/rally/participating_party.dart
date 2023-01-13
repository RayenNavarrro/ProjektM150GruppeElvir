import 'package:dart_mappable/dart_mappable.dart';

@MappableClass()
class ParticipatingParty {
  final String id;
  final String? title;

  ParticipatingParty({required this.id, required this.title});
}
