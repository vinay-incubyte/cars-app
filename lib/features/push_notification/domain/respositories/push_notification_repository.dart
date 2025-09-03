import 'package:cars_app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PushNotificationRepository {
  Future<Either<Failure,bool>> requestPermission();
  Future<Either<Failure,String>> getFCM();
}