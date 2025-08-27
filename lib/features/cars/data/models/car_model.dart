import 'package:cars_app/features/cars/domain/entities/car_entity.dart';

class CarModel extends CarEntity {
  const CarModel({
    required super.id,
    required super.name,
    required super.manufacturer,
    required super.model,
    required super.fuel,
    required super.type,
    required super.image,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] as String,
      name: json['vehicle'] ?? "",
      manufacturer: json['manufacturer'] ?? "",
      model: json['model'] ?? "",
      fuel: json['fuel'] ?? "",
      type: json['type'] ?? "",
      image: json['image'] ?? "",
    );
  }
}
