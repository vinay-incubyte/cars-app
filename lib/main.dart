import 'package:cars_app/di.dart';
import 'package:cars_app/features/cars/presentation/cubit/cars_cubit.dart';
import 'package:cars_app/features/cars/presentation/view/cars_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CarsCubit>(),
      child: const MaterialApp(home: CarsView()),
    );
  }
}
