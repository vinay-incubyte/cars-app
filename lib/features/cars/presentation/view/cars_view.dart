import 'package:cars_app/features/cars/presentation/cubit/cars_cubit.dart';
import 'package:cars_app/features/cars/presentation/view/car_item/car_list_item.dart';
import 'package:cars_app/features/cars/presentation/view/error/cars_list_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CarsView extends StatefulWidget {
  const CarsView({super.key});

  @override
  State<CarsView> createState() => _CarsViewState();
}

class _CarsViewState extends State<CarsView> {
  final cacheManager = DefaultCacheManager();

  @override
  void initState() {
    Future.microtask(context.read<CarsCubit>().fetchCars);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cars', style: TextStyle(fontSize: 24))),
      body: Center(
        child: BlocBuilder<CarsCubit, CarsState>(
          builder: (context, state) {
            if (state is CarsLoaded) {
              final cars = state.cars;
              return ListView.separated(
                itemBuilder: (context, index) => CarListItem(
                  car: cars[index],
                  key: ValueKey("carId_${cars[index].id}"),
                  cacheManager: cacheManager,
                ),
                itemCount: cars.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
              );
            }
            if (state is CarsLoadError) {
              return CarsListError(error: state.error);
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
