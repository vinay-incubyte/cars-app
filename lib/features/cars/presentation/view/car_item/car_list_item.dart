import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:flutter/material.dart';

class CarListItem extends StatelessWidget {
  const CarListItem({super.key, required this.car});
  final CarEntity car;

  @override
  Widget build(BuildContext context) {
    return Text(car.name);
  }
}