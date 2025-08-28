import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CarListItem extends StatelessWidget {
  const CarListItem({super.key, required this.car, this.cacheManager});
  final CarEntity car;
  final CacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          spacing: 20,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(5),
              child: CachedNetworkImage(
                cacheManager: cacheManager,
                imageUrl: car.image,
                fit: BoxFit.contain,
                height: 200,
                width: 200,
                memCacheWidth: 200,
              ),
            ),
            Flexible(
              child: Text(
                car.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
