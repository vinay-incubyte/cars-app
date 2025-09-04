import 'package:cars_app/core/expections.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

abstract class RemotePushNotificationDataSource {
  Future<bool> requestPermission();
  Future<String> getFCM();
}

@LazySingleton(as: RemotePushNotificationDataSource)
class FirebaseRemotePushNotification
    implements RemotePushNotificationDataSource {
  final FirebaseMessaging firebaseMessaging;

  FirebaseRemotePushNotification({required this.firebaseMessaging});

  @override
  Future<String> getFCM() async {
    final fcm = await firebaseMessaging.getToken();
    if (fcm != null) return fcm;
    throw FCMTokenException();
  }

  @override
  Future<bool> requestPermission() async {
    final settings = await firebaseMessaging.requestPermission();
    final authorized =
        settings.authorizationStatus == AuthorizationStatus.authorized;
    return authorized;
  }
}
