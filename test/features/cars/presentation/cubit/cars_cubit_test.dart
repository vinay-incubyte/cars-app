import 'dart:convert';

import 'package:cars_app/core/failure.dart';
import 'package:cars_app/core/platforms/network_info.dart';
import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:cars_app/features/cars/domain/entities/car_response_entity.dart';
import 'package:cars_app/features/cars/domain/usecases/fetch_cars_usecase.dart';
import 'package:cars_app/features/cars/presentation/cubit/cars_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import 'cars_cubit_test.mocks.dart';

@GenerateMocks([FetchCarsUsecase])
void main() {
  late CarsCubit carsCubit;
  late FetchCarsUsecase fetchCarsUsecase;

  setUp(() {
    fetchCarsUsecase = MockFetchCarsUsecase();
    carsCubit = CarsCubit(fetchCarsUsecase: fetchCarsUsecase);
  });

  group('verify cars cubit', () {
    test('verify initial state', () async {
      // assert
      expect(carsCubit.state, CarsInitial());
    });

    group('verify cars fetch when success', () {
      test('when connected to Network', () async {
        // arrange
        final cars = [
          CarModel.fromJson(jsonDecode(await Fixture.load('car_fixture.json'))),
        ];
        final response = CarResponseEntity(isConnected: true, cars: cars);
        when(fetchCarsUsecase.call()).thenAnswer((_) async => Right(response));
        // act
        final expected = [CarsLoading(), CarsLoaded(response: response)];
        expectLater(carsCubit.stream, emitsInOrder(expected));
        carsCubit.fetchCars();
        // assert
        await untilCalled(fetchCarsUsecase.call());
        verify(fetchCarsUsecase.call());
        verifyNoMoreInteractions(fetchCarsUsecase);
      });

      test('when Disconnected to Network', () async {
        // arrange
        final cars = [
          CarModel.fromJson(jsonDecode(await Fixture.load('car_fixture.json'))),
        ];
        final response = CarResponseEntity(isConnected: false, cars: cars);
        when(fetchCarsUsecase.call()).thenAnswer((_) async => Right(response));
        // act
        final expected = [CarsLoading(), CarsLoaded(response: response)];
        expectLater(carsCubit.stream, emitsInOrder(expected));
        carsCubit.fetchCars();
        // assert
        await untilCalled(fetchCarsUsecase.call());
        verify(fetchCarsUsecase.call());
        verifyNoMoreInteractions(fetchCarsUsecase);
      });
    });

    test('verify cars fetch when failed', () async {
      // arrange
      when(
        fetchCarsUsecase.call(),
      ).thenAnswer((_) async => Left(ServerFailure(msg: "server issue")));
      // act
      final expected = [CarsLoading(), CarsLoadError(error: "server issue")];
      expectLater(carsCubit.stream, emitsInOrder(expected));
      carsCubit.fetchCars();
      // assert
      await untilCalled(fetchCarsUsecase.call());
      verify(fetchCarsUsecase.call());
      verifyNoMoreInteractions(fetchCarsUsecase);
    });
  });
}
