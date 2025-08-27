import 'dart:convert';

import 'package:cars_app/features/cars/data/data_sources/cars_remote_data_source.dart';
import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:cars_app/features/cars/data/repositories/cars_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import 'cars_repository_impl_test.mocks.dart';

@GenerateMocks([CarsRemoteDataSource])
void main() {
  late CarsRemoteDataSource carsRemoteDataSource;
  late CarsRepositoryImpl carsRepositoryImpl;

  setUp(() {
    carsRemoteDataSource = MockCarsRemoteDataSource();
    carsRepositoryImpl = CarsRepositoryImpl(
      carsRemoteDataSource: carsRemoteDataSource,
    );
  });

  group('Verify cars repository', () {
    test('Verify when fetch cars successful', () async {
      // arrange
      final jsonData = jsonDecode(await Fixture.load('car_fixture.json'));
      final car = CarModel.fromJson(jsonData);
      final carsList = [car];
      when(carsRemoteDataSource.fetchCars()).thenAnswer((_) async => carsList);
      // act
      final response = await carsRepositoryImpl.fetchCars();
      // assert
      expect(response, (Right(carsList)));
    });
  });
}
