import 'package:dart_mappable/dart_mappable.dart';

@MappableClass()
class ParticipatingPartyUpdateRequestDto {
  final String id;
  final String title;
  final List<String> names;

  ParticipatingPartyUpdateRequestDto({
    required this.id,
    required this.title,
    required this.names,
  });
}

