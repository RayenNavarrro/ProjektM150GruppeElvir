import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';
import 'package:gibz_mobileapp/models/students_manual/attachment.dart';
import 'package:gibz_mobileapp/models/students_manual/tag.dart';

@MappableClass()
class Article extends Equatable {
  final String id;
  final String title;
  final String content;
  final int viewCounter;
  final List<Attachment> attachments;
  final List<Tag> tags;

  @override
  List<Object?> get props => [id];

  const Article({
    required this.id,
    required this.title,
    required this.content,
    this.viewCounter = 0,
    this.tags = const [],
    this.attachments = const [],
  });
}
