import 'dart:convert';

import 'package:cars_app/core/expections.dart';
import 'package:cars_app/core/failure.dart';
import 'package:cars_app/core/platforms/network_info.dart';
import 'package:cars_app/features/cars/data/data_sources/cars_local_data_source.dart';
import 'package:cars_app/features/cars/data/data_sources/cars_remote_data_source.dart';
import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:cars_app/features/cars/data/repositories/cars_repository_impl.dart';
import 'package:cars_app/features/cars/domain/entities/car_response_entity.dart';
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
        expect(response, (Right(CarResponseEntity(cars:carsList, isConnected: true))));
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
        expect(actual, (Right(CarResponseEntity(cars:cars, isConnected: false))));
        verify(carsLocalDataSource.getCache()).called(1);
        verifyZeroInteractions(carsRemoteDataSource);
      });

      test('verify Cache Failure when not Cache in db', () async {
        // arrange
        simulateNetwork(false);
        when(carsLocalDataSource.getCache()).thenThrow(CacheException());
        // act
        final actual = await carsRepositoryImpl.fetchCars();
        // assert
        expect(actual, Left(CacheFailure(msg: 'No Cache Data Available')));
        verify(carsLocalDataSource.getCache()).called(1);
        verifyZeroInteractions(carsRemoteDataSource);
      });
    });

    group('verify get Car by Id', () {
      test('verify Car by Id when success', () async {
        // arrange
        final car = CarModel.fromJson(
          jsonDecode(await Fixture.load('car_fixture.json')),
        );
        when(carsRemoteDataSource.fetchById("0")).thenAnswer((_) async => car);
        // act
        final actual = await carsRepositoryImpl.getById("0");
        // assert
        expect(actual, Right(car));
        verify(carsRemoteDataSource.fetchById("0")).called(1);
      });

      test('verify Car by Id when Exception', () async {
        // arrange
        when(carsRemoteDataSource.fetchById("0")).thenThrow(ServerException());
        // act
        final actual = await carsRepositoryImpl.getById("0");
        // assert
        expect(actual, Left(ServerFailure(msg: "Server issue")));
        verify(carsRemoteDataSource.fetchById("0")).called(1);
      });
    });
  });
}
