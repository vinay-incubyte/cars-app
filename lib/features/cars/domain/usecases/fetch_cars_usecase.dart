import 'package:cars_app/core/failure.dart';
import 'package:cars_app/features/cars/domain/entities/car_response_entity.dart';
import 'package:cars_app/features/cars/domain/repositories/cars_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchCarsUsecase {
  final CarsRepository carsRepository;
  const FetchCarsUsecase({required this.carsRepository});

  Future<Either<Failure, CarResponseEntity>> call() async {
    return await carsRepository.fetchCars();
  }
}
