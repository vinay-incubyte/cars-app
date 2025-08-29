import 'package:cars_app/core/failure.dart';
import 'package:cars_app/features/cars/domain/entities/car_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CarsRepository {
  Future<Either<Failure,CarResponseEntity>> fetchCars();
}