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

import 'core/di_modules.dart' as _i371;
import 'features/cars/data/data_sources/cars_remote_data_source.dart' as _i577;
import 'features/cars/data/repositories/cars_repository_impl.dart' as _i1;
import 'features/cars/domain/repositories/cars_repository.dart' as _i441;
import 'features/cars/domain/usecases/fetch_cars_usecase.dart' as _i649;
import 'features/cars/presentation/cubit/cars_cubit.dart' as _i969;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i577.CarsRemoteDataSource>(
      () => _i577.CarsRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i441.CarsRepository>(
      () => _i1.CarsRepositoryImpl(
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
