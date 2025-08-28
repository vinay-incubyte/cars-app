import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:cars_app/features/cars/domain/usecases/fetch_cars_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'cars_state.dart';
@injectable
class CarsCubit extends Cubit<CarsState> {
  CarsCubit({required this.fetchCarsUsecase}) : super(CarsInitial());
  final FetchCarsUsecase fetchCarsUsecase;

  void fetchCars() async {
    emit(CarsLoading());
    final response = await fetchCarsUsecase.call();
    response.fold(
      (failure) => emit(CarsLoadError(error: failure.msg)),
      (cars) => emit(CarsLoaded(cars: cars)),
    );
  }
}
