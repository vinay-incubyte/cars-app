import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:flutter/material.dart';

class CarDetailsView extends StatelessWidget {
  const CarDetailsView({super.key, required this.car});
  final CarEntity car;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: car.id,
              transitionOnUserGestures: true,
              child: CachedNetworkImage(
                imageUrl: car.image,
                fit: BoxFit.fitWidth,
                height: 250,
                width: double.infinity,
                errorWidget: (context, url, error) => Material(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 100),
                      Text(
                        'Unable to load image',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            car.name,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text("Manufacturer : ${car.manufacturer}", style: _textStyle),
          Text("Model : ${car.model}", style: _textStyle),
          Text("Type : ${car.type}", style: _textStyle),
          Text("Fuel type : ${car.fuel}", style: _textStyle),
        ],
      ),
    );
  }

  TextStyle get _textStyle {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
  }
}
