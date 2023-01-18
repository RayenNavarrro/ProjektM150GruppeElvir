import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

@MappableClass()
class Price extends Equatable {
  final String parkingDuration;
  final double amount;

  @override
  List<Object?> get props => [parkingDuration, amount];

  const Price({
    required this.parkingDuration,
    required this.amount,
  });
}
