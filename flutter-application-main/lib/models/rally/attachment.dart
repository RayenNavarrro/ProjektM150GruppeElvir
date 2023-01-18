import 'package:dart_mappable/dart_mappable.dart';

@MappableClass(discriminatorKey: "type")
abstract class Attachment {
  final String id;
  final String title;
  final String url;

  Attachment({
    required this.id,
    required this.title,
    required this.url,
  });
}

@MappableClass(discriminatorValue: "video")
class VideoAttachment extends Attachment {
  VideoAttachment({
    required String id,
    required String title,
    required String url,
  }) : super(id: id, title: title, url: url);
}

@MappableClass(discriminatorValue: "link")
class ExternalLinkAttachment extends Attachment {
  ExternalLinkAttachment({
    required String id,
    required String title,
    required String url,
  }) : super(id: id, title: title, url: url);
}
