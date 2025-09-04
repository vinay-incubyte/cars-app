import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/core/extensions/navigation_extensions.dart';
import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:cars_app/features/cars/presentation/view/car_details_view.dart';
import 'package:cars_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CarListItem extends StatelessWidget {
  const CarListItem({super.key, required this.car, this.cacheManager});
  final CarEntity car;
  final CacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushRoute(AppRoutes.carDetails, arguments: CarDetailsArgs(car: car));
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 20,
            children: [
              Hero(
                tag: car.id,
                transitionOnUserGestures: true,
                child: CachedNetworkImage(
                  cacheManager: cacheManager,
                  imageUrl: car.image,
                  fit: BoxFit.fitWidth,
                  height: 150,
                  width: 200,
                  memCacheWidth: 200,
                  errorWidget: (context, url, error) => Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 40),
                        Text('Unable to load image'),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  car.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
