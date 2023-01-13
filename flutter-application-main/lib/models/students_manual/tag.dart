import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

@MappableClass()
class Tag extends Equatable {
  final String id;
  final String title;

  @override
  List<Object> get props => [id];

  const Tag({required this.id, required this.title});
}
