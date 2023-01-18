import 'package:dart_mappable/dart_mappable.dart';

@MappableClass()
class StageActivityResultCreationRequestDto {
  final List<String?> answers;
  final String participatingPartyId;
  final String? stageActivityId;

  StageActivityResultCreationRequestDto({
    required this.answers,
    required this.participatingPartyId,
    required this.stageActivityId,
  });
}
