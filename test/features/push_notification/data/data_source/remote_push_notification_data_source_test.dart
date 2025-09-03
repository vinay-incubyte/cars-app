import 'package:cars_app/features/push_notification/data/data_source/remote_push_notification_data_source.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_push_notification_data_source_test.mocks.dart';

@GenerateMocks([FirebaseMessaging])
void main() {
  late FirebaseMessaging firebaseMessaging;
  late RemotePushNotificationDataSource remotePushNotificationDataSource;

  setUp(() {
    firebaseMessaging = MockFirebaseMessaging();
    remotePushNotificationDataSource = FirebaseRemotePushNotification(
      firebaseMessaging: firebaseMessaging,
    );
  });

  group('verify remote push notification', () {
    test('verify permission request success', () async {
      // arrange
      final mockSettings = _mockNotificationSettings();
      when(
        firebaseMessaging.requestPermission(),
      ).thenAnswer((_) async => mockSettings);
      // act
      final actual = await remotePushNotificationDataSource.requestPermission();
      // assert
      expect(actual, true);
      verify(firebaseMessaging.requestPermission()).called(1);
      verifyNoMoreInteractions(firebaseMessaging);
    });

    test('verify permission request failure', () async {
      // arrange
      final mockSettings = _mockNotificationSettings(isAllowed: false);
      when(
        firebaseMessaging.requestPermission(),
      ).thenAnswer((_) async => mockSettings);
      // act
      final actual = await remotePushNotificationDataSource.requestPermission();
      // assert
      expect(actual, false);
      verify(firebaseMessaging.requestPermission()).called(1);
      verifyNoMoreInteractions(firebaseMessaging);
    });
  });
}

NotificationSettings _mockNotificationSettings({bool isAllowed = true}) {
  return NotificationSettings(
    alert: AppleNotificationSetting.enabled,
    announcement: AppleNotificationSetting.notSupported,
    badge: AppleNotificationSetting.enabled,
    carPlay: AppleNotificationSetting.notSupported,
    criticalAlert: AppleNotificationSetting.notSupported,
    lockScreen: AppleNotificationSetting.enabled,
    notificationCenter: AppleNotificationSetting.enabled,
    showPreviews: AppleShowPreviewSetting.always,
    timeSensitive: AppleNotificationSetting.notSupported,
    authorizationStatus: isAllowed
        ? AuthorizationStatus.authorized
        : AuthorizationStatus.denied,
    sound: AppleNotificationSetting.enabled,
    providesAppNotificationSettings: AppleNotificationSetting.enabled,
  );
}
