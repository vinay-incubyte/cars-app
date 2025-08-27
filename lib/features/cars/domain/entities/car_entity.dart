import 'package:equatable/equatable.dart';

class CarEntity extends Equatable {
  final String id;
  final String name;
  final String manufacturer;
  final String model;
  final String fuel;
  final String type;
  final String image;
  const CarEntity({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.model,
    required this.fuel,
    required this.type,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, manufacturer, model, fuel, type, image];
}
