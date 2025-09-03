import 'package:firebase_messaging/firebase_messaging.dart';

abstract class RemotePushNotificationDataSource {
  Future<bool> requestPermission();
  Future<String> getFCM();
}

class FirebaseRemotePushNotification
    implements RemotePushNotificationDataSource {
  final FirebaseMessaging firebaseMessaging;

  FirebaseRemotePushNotification({required this.firebaseMessaging});

  @override
  Future<String> getFCM() async{
    final fcm = await firebaseMessaging.getToken();
    return 'fcm';
  }

  @override
  Future<bool> requestPermission() async {
    final settings = await firebaseMessaging.requestPermission();
    final authorized =
        settings.authorizationStatus == AuthorizationStatus.authorized;
    return authorized;
  }
}
