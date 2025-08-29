import 'package:cars_app/core/expections.dart';
import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

abstract class CarsLocalDataSource {
  Future<List<CarModel>> getCache();
  Future<void> setCache(List<CarModel> cars);
}

// ignore: constant_identifier_names
const String CARS_TABLE = 'cars';

@LazySingleton(as: CarsLocalDataSource)
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
  Future<void> setCache(List<CarModel> cars) async {
    final batch = db.batch();
    await db.delete(CARS_TABLE);
    for (final car in cars) {
      batch.insert(CARS_TABLE, car.toMap());
    }
    await batch.commit(noResult: true);
  }
}
