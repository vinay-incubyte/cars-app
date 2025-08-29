import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:equatable/equatable.dart';

class CarResponseEntity extends Equatable {
  final bool isConnected;
  final List<CarEntity> cars;

  const CarResponseEntity({required this.isConnected, required this.cars});

  @override
  List<Object?> get props => [isConnected, cars];
}
