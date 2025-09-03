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
      // act
      pushNotificationCubit.init();
      // assert
      verify(permissionUsecase.call()).called(1);
    });
  });
}
