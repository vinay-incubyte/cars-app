import 'package:equatable/equatable.dart';

class PushNotificationEntity extends Equatable{
  final String title;
  final String? body;

  const PushNotificationEntity({required this.title, this.body});
  
  @override
  List<Object?> get props => [title,body];
}
