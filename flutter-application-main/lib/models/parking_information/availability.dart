import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

@MappableClass()
class Availability extends Equatable {
  final String id;
  final String status;
  final int free;
  final DateTime moment;

  @override
  List<Object?> get props => [id];

  const Availability({
    required this.id,
    required this.status,
    required this.free,
    required this.moment,
  });
}
