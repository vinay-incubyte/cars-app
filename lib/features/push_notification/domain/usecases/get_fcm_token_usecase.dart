import 'package:cars_app/core/failure.dart';
import 'package:cars_app/features/push_notification/domain/respositories/push_notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetFcmTokenUsecase {
  final PushNotificationRepository pushNotificationRepository;

  GetFcmTokenUsecase({required this.pushNotificationRepository});

  Future<Either<Failure, String>> call() async {
    return await pushNotificationRepository.getFCM();
  }
}
