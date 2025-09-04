import 'package:cars_app/di.dart';
import 'package:cars_app/features/cars/presentation/cubit/cars_cubit.dart';
import 'package:cars_app/features/push_notification/presentation/cubit/firebase_push_notification_cubit.dart';
import 'package:cars_app/firebase_options.dart';
import 'package:cars_app/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
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
          create: (context) => getIt<FirebasePushNotificationCubit>(),
          lazy: false,
        ),
      ],
      child: const MaterialApp(onGenerateRoute: AppRouter.generateRoute),
    );
  }
}
