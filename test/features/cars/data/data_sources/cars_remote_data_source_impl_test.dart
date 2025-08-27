import 'dart:convert';

import 'package:cars_app/core/base_url.dart';
import 'package:cars_app/core/expections.dart';
import 'package:cars_app/features/cars/data/data_sources/cars_remote_data_source.dart';
import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/dio_mock.mocks.dart';
import '../../../../fixtures/fixture.dart';

void main() {
  late Dio dio;
  late CarsRemoteDataSourceImpl carsRemoteDataSourceImpl;

  setUp(() {
    dio = MockDio()..options = BaseOptions(baseUrl: BASE_URL);
    carsRemoteDataSourceImpl = CarsRemoteDataSourceImpl(dio: dio);
  });

  group('Verify cars remote data source', () {
    test('verify cars fetch successful', () async {
      // arrange
      final car = CarModel.fromJson(
        jsonDecode(await Fixture.load('car_fixture.json')),
      );
      final data = [car];
      final response = Response(
        requestOptions: RequestOptions(),
        data: [jsonDecode(await Fixture.load('car_fixture.json'))],
      );
      when(dio.get(GET_CARS)).thenAnswer((_) async => response);
      // act
      final actual = await carsRemoteDataSourceImpl.fetchCars();
      // assert
      expect(actual, data);
    });

    test('verify cars fetch throws Expection', () async {
      // arrange
      when(dio.get(GET_CARS)).thenThrow(ServerException());
      // act
      final call = carsRemoteDataSourceImpl.fetchCars();
      // assert
      expect(() async => await call, throwsA(TypeMatcher<ServerException>()));
    });
  });
}
