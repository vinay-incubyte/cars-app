import 'package:cars_app/core/failure.dart';
import 'package:cars_app/features/push_notification/domain/respositories/push_notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PushNotificationPermissionUsecase {
  final PushNotificationRepository pushNotificationRepository;

  PushNotificationPermissionUsecase({required this.pushNotificationRepository});

  Future<Either<Failure, bool>> call() async {
    return await pushNotificationRepository.requestPermission();
  }
}
