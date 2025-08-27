import 'package:cars_app/core/base_url.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() => Dio(BaseOptions(baseUrl: BASE_URL));
}
