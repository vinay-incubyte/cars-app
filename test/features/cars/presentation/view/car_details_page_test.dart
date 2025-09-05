import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/core/failure.dart';
import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:cars_app/features/cars/domain/usecases/fetch_car_by_id_usecase.dart';
import 'package:cars_app/features/cars/presentation/cubit/car_details_cubit.dart';
import 'package:cars_app/features/cars/presentation/view/car_details_view.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../cubit/car_details_cubit_test.mocks.dart';

void main() {
  late CarDetailsCubit carDetailsCubit;
  late FetchCarByIdUsecase fetchCarByIdUsecase;

  setUp(() {
    fetchCarByIdUsecase = MockFetchCarByIdUsecase();
    carDetailsCubit = CarDetailsCubit(fetchCarByIdUsecase: fetchCarByIdUsecase);
  });
  group('verify Car details view', () {
    testWidgets('verify car details when Cars list exist', (tester) async {
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
        BlocProvider.value(
          value: carDetailsCubit,
          child: MaterialApp(
            home: CarDetailsView(args: CarDetailsArgs(car: car)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // assert
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.byType(Text), findsExactly(5));
    });

    testWidgets('verify car details when deeplinkId', (tester) async {
      // arrange
      final car = CarModel(
        id: "0",
        name: 'Mercedes Benz Mercielago',
        manufacturer: 'Mazda',
        model: 'Cruze',
        fuel: 'Gasoline',
        type: 'Crew Cab Pickup',
        image: 'http://www.regcheck.org.uk/image.aspx/@TWF6ZGEgQ3J1emU=',
      );
      when(fetchCarByIdUsecase.call("0")).thenAnswer((_) async => Right(car));
      await tester.pumpWidget(
        BlocProvider.value(
          value: carDetailsCubit,
          child: MaterialApp(
            home: CarDetailsView(args: CarDetailsArgs(deepLinkId: "0")),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOne);
      await tester.pumpAndSettle();
      // assert
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.byType(Text), findsExactly(5));
    });

    testWidgets('verify car details when deeplinkId failed', (tester) async {
      // arrange
      when(
        fetchCarByIdUsecase.call("0"),
      ).thenAnswer((_) async => Left(ServerFailure(msg: "Server issue")));
      await tester.pumpWidget(
        BlocProvider.value(
          value: carDetailsCubit,
          child: MaterialApp(
            home: CarDetailsView(args: CarDetailsArgs(deepLinkId: "0")),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOne);
      await tester.pumpAndSettle();
      // assert
      expect(find.text('Server issue'), findsOne);
    });

    testWidgets('verify CarDetailsView back flow when from deeplink', (tester) async {
      final car = CarModel(
        id: "0",
        name: 'Mercedes Benz Mercielago',
        manufacturer: 'Mazda',
        model: 'Cruze',
        fuel: 'Gasoline',
        type: 'Crew Cab Pickup',
        image: 'http://www.regcheck.org.uk/image.aspx/@TWF6ZGEgQ3J1emU=',
      );
      when(fetchCarByIdUsecase.call("0")).thenAnswer((_) async => Right(car));
      await tester.pumpWidget(
        BlocProvider.value(
          value: carDetailsCubit,
          child: MaterialApp(
            home: CarDetailsView(args: CarDetailsArgs(deepLinkId: "0")),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOne);
      await tester.pumpAndSettle();
      
      expect(find.byIcon(Icons.clear), findsOne);
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pumpAndSettle();

      expect(find.text('Cars'), findsOne);
    });
  });
}
