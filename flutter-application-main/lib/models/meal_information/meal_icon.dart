import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

@MappableClass()
class MealIcon extends Equatable {
  final String id;
  final String sourceUri;
  final String altText;

  const MealIcon({
    required this.id,
    required this.sourceUri,
    required this.altText,
  });

  @override
  List<Object?> get props => [id];
}
