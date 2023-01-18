import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';
import 'package:gibz_mobileapp/models/students_manual/students_manual.mapper.g.dart';

@MappableClass(discriminatorKey: "type")
abstract class Attachment extends Equatable with Mappable {
  final String id;
  final String title;
  final String url;

  @override
  List<Object?> get props => [id];

  const Attachment({required this.id, required this.title, required this.url});
}
