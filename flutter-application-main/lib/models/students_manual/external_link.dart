import 'package:dart_mappable/dart_mappable.dart';

import 'attachment.dart';

@MappableClass(discriminatorValue: "link")
class ExternalLink extends Attachment {
  const ExternalLink({required id, required title, required url})
      : super(id: id, title: title, url: url);
}
