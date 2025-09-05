// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/core/extensions/navigation_extensions.dart';
import 'package:cars_app/features/cars/presentation/cubit/car_details_cubit.dart';
import 'package:cars_app/features/cars/presentation/view/error/cars_list_error.dart';
import 'package:cars_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailsArgs {
  final CarEntity? car;
  final String? deepLinkId;
  const CarDetailsArgs({this.car, this.deepLinkId});
}

class CarDetailsView extends StatefulWidget {
  const CarDetailsView({super.key, required this.args});
  final CarDetailsArgs args;

  @override
  State<CarDetailsView> createState() => _CarDetailsViewState();
}

class _CarDetailsViewState extends State<CarDetailsView> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<CarDetailsCubit>();
    final id = widget.args.deepLinkId;
    if (id != null) cubit.fetchById(id);
    final car = widget.args.car;
    if (car != null) cubit.carDetails(car);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.args.deepLinkId == null,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.pushPopUntil(AppRoutes.cars);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: widget.args.deepLinkId != null
              ? IconButton(
                  onPressed: () => context.pushPopUntil(AppRoutes.cars),
                  icon: Icon(Icons.clear),
                )
              : null,
        ),
        body: BlocBuilder<CarDetailsCubit, CarDetailsState>(
          builder: (context, state) {
            if (state is CarDetailsLoaded) {
              return _buildBody(state.car);
            }
            if (state is CarDetailsLoadError) {
              return CarsListError(error: state.error);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  SingleChildScrollView _buildBody(CarEntity car) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: car.id,
            transitionOnUserGestures: true,
            child: CachedNetworkImage(
              imageUrl: car.image,
              fit: BoxFit.fitWidth,
              height: 250,
              width: double.infinity,
              errorWidget: (context, url, error) => Material(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 100),
                    Text(
                      'Unable to load image',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildInfo(car),
        ],
      ),
    );
  }

  Widget _buildInfo(CarEntity car) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            car.name,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text("Manufacturer : ${car.manufacturer}", style: _textStyle),
          Text("Model : ${car.model}", style: _textStyle),
          Text("Type : ${car.type}", style: _textStyle),
          Text("Fuel type : ${car.fuel}", style: _textStyle),
        ],
      ),
    );
  }

  TextStyle get _textStyle {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
  }
}
