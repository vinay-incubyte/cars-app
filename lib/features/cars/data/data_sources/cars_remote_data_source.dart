import 'package:cars_app/features/cars/data/models/car_model.dart';

abstract class CarsRemoteDataSource {
  Future<List<CarModel>> fetchCars();
}