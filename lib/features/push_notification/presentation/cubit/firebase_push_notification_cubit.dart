import 'package:cars_app/core/mixns/logger_mixin.dart';
import 'package:cars_app/features/push_notification/domain/usecases/get_fcm_token_usecase.dart';
import 'package:cars_app/features/push_notification/domain/usecases/push_notification_permission_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'firebase_push_notification_state.dart';

@injectable
class FirebasePushNotificationCubit extends Cubit<FirebasePushNotificationState>
    with LoggerMixin {
  FirebasePushNotificationCubit({
    required this.getFcmTokenUsecase,
    required this.notificationPermissionUsecase,
  }) : super(FirebasePushNotificationInitial());

  final GetFcmTokenUsecase getFcmTokenUsecase;
  final PushNotificationPermissionUsecase notificationPermissionUsecase;

  Future<void> init() async {
    final permission = await notificationPermissionUsecase.call();
    final isPermission = permission.fold((failure) {
      debugLog("NotificationPermission Failure ${failure.msg}");
      return false;
    }, (status) => status);

    if (!isPermission) return;

    final fcmResponse = await getFcmTokenUsecase.call();
    final fcm = fcmResponse.fold((failure) => failure.msg, (fcm) => fcm);
    debugLog("FCM: $fcm");

    FirebaseMessaging.onMessage.listen((message) {
      // print("Foreground message: ${message.notification?.toMap()}");
      // Show local notification if needed
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // print("App opened from notification: ${message.data}");
    });
  }
}
