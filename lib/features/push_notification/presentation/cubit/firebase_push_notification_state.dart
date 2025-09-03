part of 'firebase_push_notification_cubit.dart';

sealed class FirebasePushNotificationState extends Equatable {
  const FirebasePushNotificationState();

  @override
  List<Object> get props => [];
}

final class FirebasePushNotificationInitial extends FirebasePushNotificationState {}
