// ignore_for_file: constant_identifier_names

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
    final response = await dio.get(GET_CARS);
    final List data = response.data;
    final cars = data.map((e) => CarModel.fromJson(e)).toList();
    return cars;
  }
}
