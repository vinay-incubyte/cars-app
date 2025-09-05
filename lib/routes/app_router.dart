import 'package:cars_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:cars_app/features/cars/presentation/view/cars_view.dart';
import 'package:cars_app/features/cars/presentation/view/car_details_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? "/");

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'carDetails') {
      final carId = uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;
      if (carId != null) {
        return MaterialPageRoute(
          builder: (_) {
            return CarDetailsView(args: CarDetailsArgs(deepLinkId: carId));
          },
          settings: settings,
        );
      }
    }

    switch (settings.name) {
      case AppRoutes.cars:
        return MaterialPageRoute(builder: (_) => CarsView());

      case AppRoutes.carDetails:
        final args = settings.arguments as CarDetailsArgs;
        return MaterialPageRoute(builder: (_) => CarDetailsView(args: args));

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Unknown route'))),
        );
    }
  }
}
