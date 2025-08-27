import 'package:cars_app/features/cars/domain/repositories/cars_repository.dart';
import 'package:cars_app/features/cars/domain/usecases/fetch_cars_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_cars_usecase_test.mocks.dart';

@GenerateMocks([CarsRepository])
void main() {
  late CarsRepository carsRepository;
  late FetchCarsUsecase fetchCarsUsecase;

  setUp((){
    carsRepository = MockCarsRepository();
    fetchCarsUsecase = FetchCarsUsecase(carsRepository: carsRepository);
  });

  test('Verify repo fetch cars call', () async {
    // arrange
    when(carsRepository.fetchCars()).thenAnswer((_) async => Right([]));
    // act
    await fetchCarsUsecase.call();
    // assert
    verify(carsRepository.fetchCars());
    verifyNoMoreInteractions(carsRepository);
  });
}