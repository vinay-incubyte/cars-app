import 'package:cars_app/core/failure.dart';
import 'package:cars_app/features/cars/data/data_sources/cars_remote_data_source.dart';
import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:cars_app/features/cars/domain/repositories/cars_repository.dart';
import 'package:dartz/dartz.dart';

class CarsRepositoryImpl implements CarsRepository {
  final CarsRemoteDataSource carsRemoteDataSource;
  const CarsRepositoryImpl({required this.carsRemoteDataSource});

  @override
  Future<Either<Failure, List<CarEntity>>> fetchCars() async {
    // TODO: implement fetchCars
    throw UnimplementedError();
  }
}
