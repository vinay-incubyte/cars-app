import 'package:cars_app/features/cars/core/failure.dart';
import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CarsRepository {
  Future<Either<Failure,List<CarEntity>>> fetchCars();
}