import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

@MappableClass()
class NutritionalValue extends Equatable {
  final String id;
  final String title;
  final String value;
  final int rowIndex;

  const NutritionalValue({
    required this.id,
    required this.title,
    required this.value,
    required this.rowIndex,
  });

  @override
  List<Object?> get props => [id];
}
