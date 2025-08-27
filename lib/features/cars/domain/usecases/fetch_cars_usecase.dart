import 'package:cars_app/core/failure.dart';
import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:cars_app/features/cars/domain/repositories/cars_repository.dart';
import 'package:dartz/dartz.dart';

class FetchCarsUsecase {
  final CarsRepository carsRepository;
  const FetchCarsUsecase({required this.carsRepository});

  Future<Either<Failure,List<CarEntity>>> call() async{
    return await carsRepository.fetchCars();
  }
}
