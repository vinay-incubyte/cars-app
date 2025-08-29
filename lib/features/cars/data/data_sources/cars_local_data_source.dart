import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class CarsLocalDataSource {
  Future<List<CarModel>> getCache();
  Future<bool> setCache(List<CarModel> cars);
}

// ignore: constant_identifier_names
const String CARS_TABLE = 'cars';

class CarsLocalDataSourceImpl implements CarsLocalDataSource {
  final Database db;
  const CarsLocalDataSourceImpl({required this.db});

  @override
  Future<List<CarModel>> getCache() {
    // TODO: implement getCache
    throw UnimplementedError();
  }

  @override
  Future<bool> setCache(List<CarModel> cars) {
    // TODO: implement setCache
    throw UnimplementedError();
  }
}
