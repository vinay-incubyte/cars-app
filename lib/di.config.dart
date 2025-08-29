// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:sqflite/sqflite.dart' as _i779;

import 'core/di_modules.dart' as _i371;
import 'core/platforms/network_info.dart' as _i998;
import 'features/cars/data/data_sources/cars_local_data_source.dart' as _i849;
import 'features/cars/data/data_sources/cars_remote_data_source.dart' as _i577;
import 'features/cars/data/repositories/cars_repository_impl.dart' as _i1;
import 'features/cars/domain/repositories/cars_repository.dart' as _i441;
import 'features/cars/domain/usecases/fetch_cars_usecase.dart' as _i649;
import 'features/cars/presentation/cubit/cars_cubit.dart' as _i969;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    await gh.lazySingletonAsync<_i779.Database>(
      () => registerModule.carsDB(),
      preResolve: true,
    );
    gh.lazySingleton<_i998.NetworkInfo>(
      () => _i998.NetworkInfoImpl(
        connectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.lazySingleton<_i849.CarsLocalDataSource>(
      () => _i849.CarsLocalDataSourceImpl(db: gh<_i779.Database>()),
    );
    gh.lazySingleton<_i577.CarsRemoteDataSource>(
      () => _i577.CarsRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i441.CarsRepository>(
      () => _i1.CarsRepositoryImpl(
        networkInfo: gh<_i998.NetworkInfo>(),
        carsLocalDataSource: gh<_i849.CarsLocalDataSource>(),
        carsRemoteDataSource: gh<_i577.CarsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i649.FetchCarsUsecase>(
      () => _i649.FetchCarsUsecase(carsRepository: gh<_i441.CarsRepository>()),
    );
    gh.factory<_i969.CarsCubit>(
      () => _i969.CarsCubit(fetchCarsUsecase: gh<_i649.FetchCarsUsecase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i371.RegisterModule {}
