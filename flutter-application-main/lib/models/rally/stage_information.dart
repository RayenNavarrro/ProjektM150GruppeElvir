import 'package:dart_mappable/dart_mappable.dart';

import 'attachment.dart';

@MappableClass()
class StageInformation {
  final String id;
  final String title;
  final String content;
  final List<Attachment> attachments;

  StageInformation({
    required this.id,
    required this.title,
    required this.content,
    required this.attachments,
  });
}
