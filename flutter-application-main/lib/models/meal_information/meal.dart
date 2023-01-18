import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

import 'meal_icon.dart';
import 'nutritional_value.dart';

@MappableClass()
class Meal extends Equatable {
  final String id;
  final String title;
  final double priceInternal;
  final double priceExternal;
  final List<String> menuComponents;
  final List<String> allergenes;
  final String? balance;
  final String? environmentalImpact;
  final List<String> additionalInformation;
  final List<NutritionalValue> nutritionalValues;
  final List<MealIcon> icons;

  const Meal({
    required this.id,
    required this.title,
    this.priceInternal = 0.0,
    this.priceExternal = 0.0,
    required this.menuComponents,
    required this.allergenes,
    this.balance,
    this.environmentalImpact,
    this.additionalInformation = const <String>[],
    required this.nutritionalValues,
    this.icons = const <MealIcon>[],
  });

  @override
  List<Object?> get props => [id];
}
