part of 'cars_cubit.dart';

sealed class CarsState extends Equatable {
  const CarsState();

  @override
  List<Object> get props => [];
}

final class CarsInitial extends CarsState {}

final class CarsLoading extends CarsState {}

final class CarsLoaded extends CarsState {
  final List<CarEntity> cars;
  const CarsLoaded({required this.cars});

  @override
  List<Object> get props => [super.props, cars];
}

final class CarsLoadError extends CarsState {}
