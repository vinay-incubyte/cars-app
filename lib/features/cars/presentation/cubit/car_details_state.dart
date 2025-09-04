part of 'car_details_cubit.dart';

sealed class CarDetailsState extends Equatable {
  const CarDetailsState();

  @override
  List<Object> get props => [];
}

final class CarDetailsInitial extends CarDetailsState {}

final class CarDetailsLoading extends CarDetailsState {}

final class CarDetailsLoaded extends CarDetailsState {
  final CarEntity car;
  const CarDetailsLoaded({required this.car});

  @override
  List<Object> get props => [car];
}

final class CarDetailsLoadError extends CarDetailsState {
  final String error;
  const CarDetailsLoadError({required this.error});

  @override
  List<Object> get props => [error];
}
