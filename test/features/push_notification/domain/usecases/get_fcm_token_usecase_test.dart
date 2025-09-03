import 'package:cars_app/features/push_notification/domain/respositories/push_notification_repository.dart';
import 'package:cars_app/features/push_notification/domain/usecases/get_fcm_token_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_fcm_token_usecase_test.mocks.dart';

@GenerateMocks([PushNotificationRepository])
void main() {
  late PushNotificationRepository pushNotificationRepository;
  late GetFcmTokenUsecase getFcmTokenUsecase;

  setUp(() {
    pushNotificationRepository = MockPushNotificationRepository();
    getFcmTokenUsecase = GetFcmTokenUsecase(
      pushNotificationRepository: pushNotificationRepository,
    );
  });

  test('verify push notification repo call', () async {
    // arrange
    when(
      pushNotificationRepository.getFCM(),
    ).thenAnswer((_) async => Right("fcm"));
    // act
    final actual = await getFcmTokenUsecase.call();
    // assert
    expect(actual, Right("fcm"));
    verify(pushNotificationRepository.getFCM()).called(1);
  });
}
