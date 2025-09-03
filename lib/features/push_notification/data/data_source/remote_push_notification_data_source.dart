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
  Future<String> getFCM() {
    // TODO: implement getFCM
    throw UnimplementedError();
  }

  @override
  Future<bool> requestPermission() async {
    await firebaseMessaging.requestPermission();
    return true;
  }
}
