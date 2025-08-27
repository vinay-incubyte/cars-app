import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:dio/dio.dart';

abstract class CarsRemoteDataSource {
  Future<List<CarModel>> fetchCars();
}

const String GET_CARS = "/products";

class CarsRemoteDataSourceImpl implements CarsRemoteDataSource {
  final Dio dio;
  const CarsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CarModel>> fetchCars() async {
    // TODO: implement fetchCars
    throw UnimplementedError();
  }
}
