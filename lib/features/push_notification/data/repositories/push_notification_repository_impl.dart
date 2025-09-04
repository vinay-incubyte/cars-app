import 'package:cars_app/core/failure.dart';
import 'package:cars_app/core/mixns/logger_mixin.dart';
import 'package:cars_app/features/push_notification/data/data_source/remote_push_notification_data_source.dart';
import 'package:cars_app/features/push_notification/domain/respositories/push_notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PushNotificationRepository)
class PushNotificationRepositoryImpl
    with LoggerMixin
    implements PushNotificationRepository {
  final RemotePushNotificationDataSource remotePushNotificationDataSource;

  PushNotificationRepositoryImpl({
    required this.remotePushNotificationDataSource,
  });

  @override
  Future<Either<Failure, String>> getFCM() async {
    try {
      final fcm = await remotePushNotificationDataSource.getFCM();
      return Right(fcm);
    } on Exception catch (e) {
      debugLog("PushNotificationRepositoryImpl getFCM() : $e");
      return Left(DeviceFailure(msg: 'get FCM failure'));
    }
  }

  @override
  Future<Either<Failure, bool>> requestPermission() async {
    try {
      final status = await remotePushNotificationDataSource.requestPermission();
      return status
          ? Right(status)
          : Left(PermissionFailure(msg: 'Not allowed'));
    } on Exception catch (e) {
      debugLog("PushNotificationRepositoryImpl requestPermission() : $e");
      return Left(PermissionFailure(msg: 'Not allowed'));
    }
  }
}
