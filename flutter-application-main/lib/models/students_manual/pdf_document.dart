import 'package:dart_mappable/dart_mappable.dart';

import 'attachment.dart';

@MappableClass(discriminatorValue: "pdf")
class PdfDocument extends Attachment {
  const PdfDocument({required id, required title, required url})
      : super(id: id, title: title, url: url);
}
