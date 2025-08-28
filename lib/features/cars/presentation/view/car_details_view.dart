import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:flutter/material.dart';

class CarDetailsView extends StatelessWidget {
  const CarDetailsView({super.key, required this.car});
  final CarEntity car;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          car.name,
          style: TextStyle(fontSize: 24),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: car.image,
            fit: BoxFit.fitWidth,
            height: 250,
          ),
          Text(car.name, style: TextStyle(fontSize: 22)),
          Text("Manufacturer: ${car.manufacturer}"),
          Text("Model: ${car.model}"),
          Text("Type: ${car.type}"),
          Text("Fuel type: ${car.fuel}"),
        ],
      ),
    );
  }
}
