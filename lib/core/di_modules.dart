import 'package:cars_app/core/base_url.dart';
import 'package:cars_app/core/platforms/sql_db_provider.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sqflite/sqflite.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() => Dio(BaseOptions(baseUrl: BASE_URL));

  @lazySingleton
  @preResolve
  Future<Database> carsDB() async => await CarDbProvider().getDB();

  @lazySingleton
  InternetConnectionChecker get  internetConnectionChecker => InternetConnectionChecker.instance;
}
