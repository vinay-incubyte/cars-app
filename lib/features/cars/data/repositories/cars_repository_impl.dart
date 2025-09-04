import 'package:cars_app/core/expections.dart';
import 'package:cars_app/core/failure.dart';
import 'package:cars_app/core/mixns/logger_mixin.dart';
import 'package:cars_app/core/platforms/network_info.dart';
import 'package:cars_app/features/cars/data/data_sources/cars_local_data_source.dart';
import 'package:cars_app/features/cars/data/data_sources/cars_remote_data_source.dart';
import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:cars_app/features/cars/domain/entities/car_response_entity.dart';
import 'package:cars_app/features/cars/domain/repositories/cars_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CarsRepository)
class CarsRepositoryImpl with LoggerMixin implements CarsRepository {
  final CarsRemoteDataSource carsRemoteDataSource;
  final CarsLocalDataSource carsLocalDataSource;
  final NetworkInfo networkInfo;
  const CarsRepositoryImpl({
    required this.networkInfo,
    required this.carsLocalDataSource,
    required this.carsRemoteDataSource,
  });

  @override
  Future<Either<Failure, CarResponseEntity>> fetchCars() async {
    final connected = await networkInfo.isConnected();
    debugLog("Network Status : $connected");
    if (connected) {
      try {
        final cars = await carsRemoteDataSource.fetchCars();
        carsLocalDataSource.setCache(cars);
        debugLog("CarsRemoteDataSource : $cars");
        return Right(CarResponseEntity(isConnected: connected, cars: cars));
      } on ServerException catch (e) {
        debugLog("CarsRemoteDataSource : $e");
        return Left(ServerFailure(msg: "Server issue"));
      }
    } else {
      try {
        final cars = await carsLocalDataSource.getCache();
        debugLog("CarsLocalDataSource : $cars");
        return Right(CarResponseEntity(isConnected: connected, cars: cars));
      } on CacheException catch (e) {
        debugLog("CarsLocalDataSource : $e");
        return Left(CacheFailure(msg: 'No Cache Data Available'));
      }
    }
  }

  @override
  Future<Either<Exception, CarEntity>> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }
}
