import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:cars_app/features/cars/presentation/view/car_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  testWidgets('verify car details', (tester) async {
    // arrange
    final carJson = jsonDecode(await Fixture.load('car_fixture.json'));
    final car = CarModel.fromJson(carJson);
    await tester.pumpWidget(MaterialApp(home: CarDetailsView(carEntity: car)));
    await tester.pumpAndSettle();
    // assert
    expect(find.byType(Text), findsExactly(5));
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
