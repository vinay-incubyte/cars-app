import 'package:cars_app/features/cars/data/models/car_model.dart';

abstract class CarsLocalDataSource {
  Future<List<CarModel>> getCache();
  Future<bool> setCache(List<CarModel> cars);
}