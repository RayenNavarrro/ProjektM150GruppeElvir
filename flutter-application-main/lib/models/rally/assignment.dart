import 'package:dart_mappable/dart_mappable.dart';

import 'audience.dart';

@MappableClass()
class Assignment {
  final String id;
  final int joiningCode;
  final Audience audience;

  Assignment({
    required this.id,
    required this.joiningCode,
    required this.audience,
  });
}
