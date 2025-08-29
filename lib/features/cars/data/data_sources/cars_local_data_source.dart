import 'package:cars_app/core/expections.dart';
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
  Future<List<CarModel>> getCache() async {
    final carsJsonList = await db.query(CARS_TABLE);
    if (carsJsonList.isNotEmpty) {
      return carsJsonList.map(CarModel.fromJson).toList();
    }
    throw CacheException();
  }

  @override
  Future<bool> setCache(List<CarModel> cars) {
    // TODO: implement setCache
    throw UnimplementedError();
  }
}
