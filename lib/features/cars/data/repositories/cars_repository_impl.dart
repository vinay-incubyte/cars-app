import 'package:cars_app/core/expections.dart';
import 'package:cars_app/core/failure.dart';
import 'package:cars_app/core/platforms/network_info.dart';
import 'package:cars_app/features/cars/data/data_sources/cars_local_data_source.dart';
import 'package:cars_app/features/cars/data/data_sources/cars_remote_data_source.dart';
import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:cars_app/features/cars/domain/repositories/cars_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CarsRepository)
class CarsRepositoryImpl implements CarsRepository {
  final CarsRemoteDataSource carsRemoteDataSource;
  final CarsLocalDataSource carsLocalDataSource;
  final NetworkInfo networkInfo;
  const CarsRepositoryImpl({
    required this.networkInfo,
    required this.carsLocalDataSource,
    required this.carsRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<CarEntity>>> fetchCars() async {
    final connected = await networkInfo.isConnected();
    try {
      final cars = await carsRemoteDataSource.fetchCars();
      carsLocalDataSource.setCache(cars);
      return Right(cars);
    } on ServerException catch (_) {
      return Left(ServerFailure(msg: "Server issue"));
    }
  }
}
