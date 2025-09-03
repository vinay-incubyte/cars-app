import 'package:cars_app/features/push_notification/domain/respositories/push_notification_repository.dart';
import 'package:cars_app/features/push_notification/domain/usecases/push_notification_permission_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_fcm_token_usecase_test.mocks.dart';

void main() {
  late PushNotificationRepository pushNotificationRepository;
  late PushNotificationPermissionUsecase
  pushNotificationPermissionUsecase;

  setUp(() {
    pushNotificationRepository = MockPushNotificationRepository();
    pushNotificationPermissionUsecase =
        PushNotificationPermissionUsecase(
          pushNotificationRepository: pushNotificationRepository,
        );
  });

  test('verify push notification repo call', () async {
    // arrange
    when(
      pushNotificationRepository.requestPermission(),
    ).thenAnswer((_) async => Right(true));
    // act
    final actual = await pushNotificationPermissionUsecase.call();
    // assert
    expect(actual, Right(true));
    verify(pushNotificationRepository.requestPermission()).called(1);
  });
}
