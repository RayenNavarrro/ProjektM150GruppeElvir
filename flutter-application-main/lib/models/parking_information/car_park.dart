import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

import 'availability.dart';
import 'price.dart';

@MappableClass()
class CarPark extends Equatable {
  final String id;
  final int plsId;
  final String name;
  final Availability currentAvailability;
  final List<String> paymentOptions;
  final List<String> openingHours;
  final List<Price> prices;

  @override
  List<Object?> get props => [id];

  const CarPark({
    required this.id,
    required this.plsId,
    required this.name,
    required this.currentAvailability,
    required this.paymentOptions,
    required this.openingHours,
    required this.prices,
  });
}
