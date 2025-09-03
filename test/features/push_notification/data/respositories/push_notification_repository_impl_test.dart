import 'package:cars_app/core/failure.dart';
import 'package:cars_app/features/push_notification/data/data_source/remote_push_notification_data_source.dart';
import 'package:cars_app/features/push_notification/data/repositories/push_notification_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'push_notification_repository_impl_test.mocks.dart';

@GenerateMocks([RemotePushNotificationDataSource])
void main() {
  late RemotePushNotificationDataSource remotePushNotificationDataSource;
  late PushNotificationRepositoryImpl pushNotificationRepositoryImpl;

  setUp(() {
    remotePushNotificationDataSource = MockRemotePushNotificationDataSource();
    pushNotificationRepositoryImpl = PushNotificationRepositoryImpl(
      remotePushNotificationDataSource: remotePushNotificationDataSource,
    );
  });

  group('verify PushNotificationRepositoryImpl', () {
    test('verify requestPermission() success', () async {
      // arrange
      when(
        remotePushNotificationDataSource.requestPermission(),
      ).thenAnswer((_) async => true);
      // act
      final actual = await pushNotificationRepositoryImpl.requestPermission();
      // assert
      expect(actual, Right(true));
      verify(remotePushNotificationDataSource.requestPermission()).called(1);
    });

    test('verify requestPermission() failure', () async {
      // arrange
      when(
        remotePushNotificationDataSource.requestPermission(),
      ).thenAnswer((_) async => false);
      // act
      final actual = await pushNotificationRepositoryImpl.requestPermission();
      // assert
      expect(actual, Left(PermissionFailure(msg: 'Not allowed')));
      verify(remotePushNotificationDataSource.requestPermission()).called(1);
    });

    test('verify requestPermission() throw Exception', () async {
      // arrange
      when(
        remotePushNotificationDataSource.requestPermission(),
      ).thenThrow(Exception());
      // act
      final actual = await pushNotificationRepositoryImpl.requestPermission();
      // assert
      expect(actual, Left(PermissionFailure(msg: 'Not allowed')));
      verify(remotePushNotificationDataSource.requestPermission()).called(1);
    });

    test('verify getFCM success', () async {
      // arrange
      when(
        remotePushNotificationDataSource.getFCM(),
      ).thenAnswer((_) async => 'fcm');
      // act
      final actual = await pushNotificationRepositoryImpl.getFCM();
      // assert
      expect(actual, Right('fcm'));
      verify(remotePushNotificationDataSource.getFCM()).called(1);
    });

    test('verify getFCM failure', () async {
      // arrange
      when(
        remotePushNotificationDataSource.getFCM(),
      ).thenThrow(Exception());
      // act
      final actual = await pushNotificationRepositoryImpl.getFCM();
      // assert
      expect(actual, Left(DeviceFailure(msg: 'get FCM failure')));
      verify(remotePushNotificationDataSource.getFCM()).called(1);
    });
  });
}
