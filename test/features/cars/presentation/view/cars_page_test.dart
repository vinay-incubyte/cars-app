import 'package:cars_app/features/cars/domain/usecases/fetch_cars_usecase.dart';
import 'package:cars_app/features/cars/presentation/cubit/cars_cubit.dart';
import 'package:cars_app/features/cars/presentation/view/cars_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../cubit/cars_cubit_test.mocks.dart';

void main() {
  late CarsCubit carsCubit;
  late FetchCarsUsecase fetchCarsUsecase;

  setUp(() {
    fetchCarsUsecase = MockFetchCarsUsecase();
    carsCubit = CarsCubit(fetchCarsUsecase: fetchCarsUsecase);
  });

  group('verify cars page widgets', () {
    Widget loadPageView() {
      return BlocProvider.value(
        value: carsCubit,
        child: MaterialApp(home: CarsView()),
      );
    }

    testWidgets('verify cars page view title', (tester) async {
      // arrange
      await tester.pumpWidget(loadPageView());
      // act

      // assert
      expect(find.text('Cars'), findsOneWidget);
    });
  });
}
