import 'package:cars_app/core/base_url.dart';
import 'package:cars_app/core/platforms/sql_db_provider.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  @lazySingleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  @lazySingleton
  FlutterLocalNotificationsPlugin get localNotificationsPlatform => FlutterLocalNotificationsPlugin();
}
