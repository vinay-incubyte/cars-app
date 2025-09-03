import 'package:cars_app/features/push_notification/domain/entities/push_notification_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('verify push notification entity', () async {
    // arrange
    final expected = PushNotificationEntity(title: 'title');
    // assert
    expect(expected.title, 'title');
    expect(expected, PushNotificationEntity(title: 'title'));
  });
}