import 'package:cars_app/features/cars/presentation/cubit/cars_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarsView extends StatefulWidget {
  const CarsView({super.key});

  @override
  State<CarsView> createState() => _CarsViewState();
}

class _CarsViewState extends State<CarsView> {
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
            if (state is CarsLoading) return CircularProgressIndicator();
            if (state is CarsLoaded) {
              return ListView.separated(
                itemBuilder: (context, index) => Text("data"),
                itemCount: state.cars.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
              );
            }
            return Placeholder();
          },
        ),
      ),
    );
  }
}
