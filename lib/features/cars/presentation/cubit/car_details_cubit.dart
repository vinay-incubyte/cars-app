import 'package:cars_app/features/cars/domain/entities/car_entity.dart';
import 'package:cars_app/features/cars/domain/usecases/fetch_car_by_id_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'car_details_state.dart';

@injectable
class CarDetailsCubit extends Cubit<CarDetailsState> {
  CarDetailsCubit({required this.fetchCarByIdUsecase})
    : super(CarDetailsInitial());
  final FetchCarByIdUsecase fetchCarByIdUsecase;

  void fetchById(String id) async {
    emit(CarDetailsLoading());
    final response = await fetchCarByIdUsecase.call(id);
    response.fold((failure) {}, (car) {
      emit(CarDetailsLoaded(car: car));
    });
  }
}
