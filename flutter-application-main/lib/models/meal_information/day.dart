import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

import 'meal.dart';

@MappableClass()
class Day extends Equatable {
  final String id;
  final DateTime date;
  final List<Meal> menus;

  const Day({
    required this.id,
    required this.date,
    required this.menus,
  });

  @override
  List<Object?> get props => [id];
}
