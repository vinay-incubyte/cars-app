import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/core/failure.dart';
import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:cars_app/features/cars/domain/entities/car_response_entity.dart';
import 'package:cars_app/features/cars/domain/usecases/fetch_cars_usecase.dart';
import 'package:cars_app/features/cars/presentation/cubit/cars_cubit.dart';
import 'package:cars_app/features/cars/presentation/view/car_item/car_list_item.dart';
import 'package:cars_app/features/cars/presentation/view/cars_view.dart';
import 'package:cars_app/features/cars/presentation/view/error/cars_list_error.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../cubit/cars_cubit_test.mocks.dart';

void main() {
  late CarsCubit carsCubit;
  late FetchCarsUsecase fetchCarsUsecase;

  setUp(() {
    fetchCarsUsecase = MockFetchCarsUsecase();
    carsCubit = CarsCubit(fetchCarsUsecase: fetchCarsUsecase);
    final carsList = List.generate(
      10,
      (index) => CarModel(
        id: "${index + 1}",
        name: 'Mercedes Benz Mercielago',
        manufacturer: 'Mazda',
        model: 'Cruze',
        fuel: 'Gasoline',
        type: 'Crew Cab Pickup',
        image: 'http://www.regcheck.org.uk/image.aspx/@TWF6ZGEgQ3J1emU=',
      ),
    );
    when(fetchCarsUsecase.call()).thenAnswer((_) async {
      await Future.delayed(Duration.zero);
      return Right(CarResponseEntity(isConnected: true, cars: carsList));
    });
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
      await tester.pumpAndSettle();
      // assert
      expect(find.text('Cars'), findsOneWidget);
    });

    testWidgets('verify loader and Cars list', (tester) async {
      // arrange
      await tester.pumpWidget(loadPageView());
      await tester.pump();
      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('verify list view items - Cars', (tester) async {
      // arrange
      await tester.pumpWidget(loadPageView());
      await tester.pumpAndSettle();
      //* data loaded success
      // assert
      expect(
        (tester.widget(find.byType(ListView)) as ListView).semanticChildCount,
        10,
      );
    });

    testWidgets('verify Car item details', (tester) async {
      // arrange
      final car = CarModel(
        id: "1",
        name: 'Mercedes Benz Mercielago',
        manufacturer: 'Mazda',
        model: 'Cruze',
        fuel: 'Gasoline',
        type: 'Crew Cab Pickup',
        image: 'http://www.regcheck.org.uk/image.aspx/@TWF6ZGEgQ3J1emU=',
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Material(child: CarListItem(car: car)),
        ),
      );
      await tester.pumpAndSettle();
      //* data loaded success
      // assert
      expect(find.byType(CarListItem), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('verify error widget when load cars failed', (tester) async {
      // arrange
      when(fetchCarsUsecase.call()).thenAnswer((_) async {
        await Future.delayed(Duration.zero);
        return Left(ServerFailure(msg: 'Server issue'));
      });
      // act
      await tester.pumpWidget(loadPageView());
      await tester.pumpAndSettle();
      //* data loaded
      // assert
      expect(find.byType(CarsListError), findsOneWidget);
      expect(find.text('Server issue'), findsOneWidget);
    });
  });
}
