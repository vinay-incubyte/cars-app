import 'package:cars_app/core/failure.dart';
import 'package:cars_app/features/push_notification/domain/usecases/get_fcm_token_usecase.dart';
import 'package:cars_app/features/push_notification/domain/usecases/push_notification_permission_usecase.dart';
import 'package:cars_app/features/push_notification/presentation/cubit/firebase_push_notification_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firebase_push_notification_cubit_test.mocks.dart';

@GenerateMocks([GetFcmTokenUsecase, PushNotificationPermissionUsecase])
void main() {
  late GetFcmTokenUsecase getFcmTokenUsecase;
  late PushNotificationPermissionUsecase permissionUsecase;
  late FirebasePushNotificationCubit pushNotificationCubit;

  setUp(() {
    permissionUsecase = MockPushNotificationPermissionUsecase();
    getFcmTokenUsecase = MockGetFcmTokenUsecase();
    pushNotificationCubit = FirebasePushNotificationCubit(
      getFcmTokenUsecase: getFcmTokenUsecase,
      notificationPermissionUsecase: permissionUsecase,
    );
  });

  group('verify pushNotificationCubit', () {
    test('verify initial state', () async {
      // assert
      expect(pushNotificationCubit.state, FirebasePushNotificationInitial());
    });

    test('verify permission request', () async {
      // arrange
      when(permissionUsecase.call()).thenAnswer((_) async => Right(true));
      when(getFcmTokenUsecase.call()).thenAnswer((_) async => Right('fcm'));
      // act
      await pushNotificationCubit.init();
      // assert
      verify(permissionUsecase.call()).called(1);
    });

    test('verify permission request failure', () async {
      // arrange
      when(
        permissionUsecase.call(),
      ).thenAnswer((_) async => Left(PermissionFailure(msg: 'not allowed')));
      // act
      await pushNotificationCubit.init();
      // assert
      verify(permissionUsecase.call()).called(1);
    });

    test('verify get FCM success if permission allowed', () async {
      // arrange
      when(getFcmTokenUsecase.call()).thenAnswer((_) async => Right('fcm'));
      when(permissionUsecase.call()).thenAnswer((_) async => Right(true));
      // act
      await pushNotificationCubit.init();
      // assert
      verify(permissionUsecase.call()).called(1);
      verify(getFcmTokenUsecase.call()).called(1);
    });
  });
}
