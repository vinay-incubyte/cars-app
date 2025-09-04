// ignore_for_file: constant_identifier_names

import 'dart:isolate';

import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class CarsRemoteDataSource {
  Future<List<CarModel>> fetchCars();
  Future<CarModel> fetchById(String id);
}

const String GET_CARS = "/products";

@LazySingleton(as: CarsRemoteDataSource)
class CarsRemoteDataSourceImpl implements CarsRemoteDataSource {
  final Dio dio;
  const CarsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CarModel>> fetchCars() async {
    return await Isolate.run(() async {
      final response = await dio.get(GET_CARS);
      final List data = response.data;
      final cars = data.map((e) => CarModel.fromJson(e)).toList();
      return cars;
    });
  }
  
  @override
  Future<CarModel> fetchById(String id) {
    // TODO: implement fetchById
    throw UnimplementedError();
  }
}
