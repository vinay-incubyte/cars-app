// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i163;
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
import 'features/cars/domain/usecases/fetch_car_by_id_usecase.dart' as _i415;
import 'features/cars/domain/usecases/fetch_cars_usecase.dart' as _i649;
import 'features/cars/presentation/cubit/car_details_cubit.dart' as _i719;
import 'features/cars/presentation/cubit/cars_cubit.dart' as _i969;
import 'features/push_notification/data/data_source/remote_push_notification_data_source.dart'
    as _i981;
import 'features/push_notification/data/repositories/push_notification_repository_impl.dart'
    as _i701;
import 'features/push_notification/domain/respositories/push_notification_repository.dart'
    as _i997;
import 'features/push_notification/domain/usecases/get_fcm_token_usecase.dart'
    as _i761;
import 'features/push_notification/domain/usecases/push_notification_permission_usecase.dart'
    as _i900;
import 'features/push_notification/presentation/cubit/firebase_push_notification_cubit.dart'
    as _i710;

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
    gh.lazySingleton<_i892.FirebaseMessaging>(
      () => registerModule.firebaseMessaging,
    );
    gh.lazySingleton<_i163.FlutterLocalNotificationsPlugin>(
      () => registerModule.localNotificationsPlatform,
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
    gh.lazySingleton<_i981.RemotePushNotificationDataSource>(
      () => _i981.FirebaseRemotePushNotification(
        firebaseMessaging: gh<_i892.FirebaseMessaging>(),
      ),
    );
    gh.lazySingleton<_i849.CarsLocalDataSource>(
      () => _i849.CarsLocalDataSourceImpl(db: gh<_i779.Database>()),
    );
    gh.lazySingleton<_i997.PushNotificationRepository>(
      () => _i701.PushNotificationRepositoryImpl(
        remotePushNotificationDataSource:
            gh<_i981.RemotePushNotificationDataSource>(),
      ),
    );
    gh.lazySingleton<_i577.CarsRemoteDataSource>(
      () => _i577.CarsRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i900.PushNotificationPermissionUsecase>(
      () => _i900.PushNotificationPermissionUsecase(
        pushNotificationRepository: gh<_i997.PushNotificationRepository>(),
      ),
    );
    gh.lazySingleton<_i761.GetFcmTokenUsecase>(
      () => _i761.GetFcmTokenUsecase(
        pushNotificationRepository: gh<_i997.PushNotificationRepository>(),
      ),
    );
    gh.factory<_i710.FirebasePushNotificationCubit>(
      () => _i710.FirebasePushNotificationCubit(
        getFcmTokenUsecase: gh<_i761.GetFcmTokenUsecase>(),
        notificationPermissionUsecase:
            gh<_i900.PushNotificationPermissionUsecase>(),
        localNotificationsPlugin: gh<_i163.FlutterLocalNotificationsPlugin>(),
      ),
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
    gh.lazySingleton<_i415.FetchCarByIdUsecase>(
      () =>
          _i415.FetchCarByIdUsecase(carsRepository: gh<_i441.CarsRepository>()),
    );
    gh.factory<_i969.CarsCubit>(
      () => _i969.CarsCubit(fetchCarsUsecase: gh<_i649.FetchCarsUsecase>()),
    );
    gh.factory<_i719.CarDetailsCubit>(
      () => _i719.CarDetailsCubit(
        fetchCarByIdUsecase: gh<_i415.FetchCarByIdUsecase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i371.RegisterModule {}
