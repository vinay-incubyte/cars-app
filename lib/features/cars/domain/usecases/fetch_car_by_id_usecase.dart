import 'package:cars_app/core/failure.dart';
import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:cars_app/features/cars/domain/repositories/cars_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchCarByIdUsecase {
  final CarsRepository carsRepository;
  const FetchCarByIdUsecase({required this.carsRepository});

  Future<Either<Failure, CarEntity>> call(String id) async {
    return await carsRepository.getById(id);
  }
}
