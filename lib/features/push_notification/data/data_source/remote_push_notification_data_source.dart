abstract class RemotePushNotificationDataSource {
  Future<bool> requestPermission();
  Future<String> getFCM();
}
