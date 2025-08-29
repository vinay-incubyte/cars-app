import 'dart:convert';

import 'package:cars_app/core/expections.dart';
import 'package:cars_app/core/failure.dart';
import 'package:cars_app/core/platforms/network_info.dart';
import 'package:cars_app/features/cars/data/data_sources/cars_local_data_source.dart';
import 'package:cars_app/features/cars/data/data_sources/cars_remote_data_source.dart';
import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:cars_app/features/cars/data/repositories/cars_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import 'cars_repository_impl_test.mocks.dart';

@GenerateMocks([CarsRemoteDataSource, CarsLocalDataSource, NetworkInfo])
void main() {
  late CarsRemoteDataSource carsRemoteDataSource;
  late CarsLocalDataSource carsLocalDataSource;
  late NetworkInfo networkInfo;
  late CarsRepositoryImpl carsRepositoryImpl;

  setUp(() {
    carsRemoteDataSource = MockCarsRemoteDataSource();
    carsLocalDataSource = MockCarsLocalDataSource();
    networkInfo = MockNetworkInfo();
    carsRepositoryImpl = CarsRepositoryImpl(
      carsRemoteDataSource: carsRemoteDataSource,
      carsLocalDataSource: carsLocalDataSource,
      networkInfo: networkInfo,
    );
  });

  void simulateNetwork(bool status) {
    when(networkInfo.isConnected()).thenAnswer((_) async => status);
  }

  group('Verify cars repository', () {
    test('verify call to network info', () async {
      // arrange
      when(carsRemoteDataSource.fetchCars()).thenAnswer((_) async => []);
      simulateNetwork(true);
      // act
      await carsRepositoryImpl.fetchCars();
      // assert
      verify(networkInfo.isConnected()).called(1);
    });

    group('verify Remote source fetch when connected to network', () {
      test('Verify when cars fetch when successful and cache data', () async {
        // arrange
        simulateNetwork(true);
        final jsonData = jsonDecode(await Fixture.load('car_fixture.json'));
        final car = CarModel.fromJson(jsonData);
        final carsList = [car];
        when(
          carsRemoteDataSource.fetchCars(),
        ).thenAnswer((_) async => carsList);
        // act
        final response = await carsRepositoryImpl.fetchCars();
        // assert
        expect(response, (Right(carsList)));
        verify(carsRemoteDataSource.fetchCars()).called(1);
        verify(carsLocalDataSource.setCache(carsList)).called(1);
      });

      test('Verify when fetch cars return Failure ', () async {
        // arrange
        simulateNetwork(true);
        when(carsRemoteDataSource.fetchCars()).thenThrow(ServerException());
        // act
        final response = await carsRepositoryImpl.fetchCars();
        // assert
        expect(response, Left(ServerFailure(msg: "Server issue")));
        verify(carsRemoteDataSource.fetchCars()).called(1);
        verifyZeroInteractions(carsLocalDataSource);
      });
    });

    group('verify Local source when no internet', () {
      test('verify fetch cars when exsist in local DB', () async {
        // arrange
        simulateNetwork(false);
        final jsonData = jsonDecode(await Fixture.load('car_fixture.json'));
        final cars = [CarModel.fromJson(jsonData)];
        when(carsLocalDataSource.getCache()).thenAnswer((_) async => cars);
        // act
        final actual = await carsRepositoryImpl.fetchCars();
        // assert
        expect(actual, cars);
        verify(carsLocalDataSource.getCache()).called(1);
        verifyZeroInteractions(carsRemoteDataSource);
      });
    });
  });
}
