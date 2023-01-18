import 'package:dart_mappable/dart_mappable.dart';

import 'attachment.dart';

@MappableClass(discriminatorValue: "video")
class Video extends Attachment {
  const Video({required id, required title, required url})
      : super(id: id, title: title, url: url);
}
