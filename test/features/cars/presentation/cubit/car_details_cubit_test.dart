import 'dart:convert';

import 'package:cars_app/core/failure.dart';
import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:cars_app/features/cars/domain/usecases/fetch_car_by_id_usecase.dart';
import 'package:cars_app/features/cars/presentation/cubit/car_details_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import 'car_details_cubit_test.mocks.dart';

@GenerateMocks([FetchCarByIdUsecase])
void main() {
  late FetchCarByIdUsecase fetchCarByIdUsecase;
  late CarDetailsCubit carDetailsCubit;

  setUp(() {
    fetchCarByIdUsecase = MockFetchCarByIdUsecase();
    carDetailsCubit = CarDetailsCubit(fetchCarByIdUsecase: fetchCarByIdUsecase);
  });

  group('verify CarDetailsCubit', () {
    test('verify initial state', () async {
      // assert
      expect(carDetailsCubit.state, CarDetailsInitial());
    });

    test('verify get Car by Id success', () async {
      // arrange
      final car = CarModel.fromJson(
        jsonDecode(await Fixture.load('car_fixture.json')),
      );
      when(fetchCarByIdUsecase.call("0")).thenAnswer((_) async => Right(car));
      // assert
      final expected = [CarDetailsLoading(), CarDetailsLoaded(car: car)];
      expectLater(carDetailsCubit.stream, emitsInOrder(expected));
      // act
      carDetailsCubit.fetchById("0");
      // verify
      verify(fetchCarByIdUsecase.call("0")).called(1);
    });

    test('verify get Car by Id Failure', () async {
      // arrange
      when(
        fetchCarByIdUsecase.call("0"),
      ).thenAnswer((_) async => Left(ServerFailure(msg: "Server issue")));
      // assert
      final expected = [
        CarDetailsLoading(),
        CarDetailsLoadError(error: "Server issue"),
      ];
      expectLater(carDetailsCubit.stream, emitsInOrder(expected));
      // act
      carDetailsCubit.fetchById("0");
      // verify
      verify(fetchCarByIdUsecase.call("0")).called(1);
    });
  });
}
