part of 'cars_cubit.dart';

sealed class CarsState extends Equatable {
  const CarsState();

  @override
  List<Object> get props => [];
}

final class CarsInitial extends CarsState {}

final class CarsLoading extends CarsState {}

final class CarsLoaded extends CarsState {
  final CarResponseEntity response;
  const CarsLoaded({required this.response});

  @override
  List<Object> get props => [super.props, response];
}

final class CarsLoadError extends CarsState {
  final String error;
  const CarsLoadError({required this.error});

  @override
  List<Object> get props => [super.props, error];
}
