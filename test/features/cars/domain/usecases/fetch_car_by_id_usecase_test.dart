import 'dart:convert';

import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:cars_app/features/cars/domain/repositories/cars_repository.dart';
import 'package:cars_app/features/cars/domain/usecases/fetch_car_by_id_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import 'fetch_cars_usecase_test.mocks.dart';

void main() {
  late CarsRepository carsRepository;
  late FetchCarByIdUsecase fetchCarByIdUsecase;

  setUp(() {
    carsRepository = MockCarsRepository();
    fetchCarByIdUsecase = FetchCarByIdUsecase(carsRepository: carsRepository);
  });

  test('verfy FetchCarByIdUsecase', () async {
    // arrange
    final CarEntity car = CarModel.fromJson(
      jsonDecode(await Fixture.load('car_fixture.json')),
    );
    when(carsRepository.getById("0")).thenAnswer((_) async => Right(car));
    // act
    final actual = await fetchCarByIdUsecase.call("0");
    // assert
    expect(actual, Right(car));
    verify(fetchCarByIdUsecase.call("0")).called(1);
  });
}
