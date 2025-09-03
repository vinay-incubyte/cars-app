import 'package:cars_app/core/mixns/logger_mixin.dart';
import 'package:cars_app/features/push_notification/domain/usecases/get_fcm_token_usecase.dart';
import 'package:cars_app/features/push_notification/domain/usecases/push_notification_permission_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'firebase_push_notification_state.dart';

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
  }
}
