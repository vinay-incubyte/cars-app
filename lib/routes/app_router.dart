import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:cars_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:cars_app/features/cars/presentation/view/cars_view.dart';
import 'package:cars_app/features/cars/presentation/view/car_details_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.cars:
        return MaterialPageRoute(builder: (_) => CarsView());

      case AppRoutes.carDetails:
        final args = settings.arguments as CarEntity;
        return MaterialPageRoute(
          builder: (_) => CarDetailsView(car: args),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Unknown route')),
          ),
        );
    }
  }
}
