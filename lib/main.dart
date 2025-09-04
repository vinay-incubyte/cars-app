import 'package:cars_app/di.dart';
import 'package:cars_app/features/cars/presentation/cubit/car_details_cubit.dart';
import 'package:cars_app/features/cars/presentation/cubit/cars_cubit.dart';
import 'package:cars_app/features/push_notification/presentation/cubit/firebase_push_notification_cubit.dart';
import 'package:cars_app/firebase_options.dart';
import 'package:cars_app/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> _registerLocalNotifications() async {
  var initializationSettingsAndroid = AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );
  var initializationSettingsIOS = DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  final localNotificationsPlugin = getIt<FlutterLocalNotificationsPlugin>();
  await localNotificationsPlugin.initialize(initializationSettings);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await configureDependencies();
  await _registerLocalNotifications();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<CarsCubit>()),
        BlocProvider(
          create: (context) => getIt<FirebasePushNotificationCubit>()..init(),
          lazy: false,
        ),
        BlocProvider(create: (context) => getIt<CarDetailsCubit>()),
      ],
      child: const MaterialApp(onGenerateRoute: AppRouter.generateRoute),
    );
  }
}
