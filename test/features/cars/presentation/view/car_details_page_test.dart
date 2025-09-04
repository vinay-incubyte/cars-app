import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:cars_app/features/cars/presentation/view/car_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('verify car details', (tester) async {
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
    await tester.pumpWidget(MaterialApp(home: CarDetailsView(args: CarDetailsArgs(car: car))));
    await tester.pumpAndSettle();
    // assert
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(Text), findsExactly(5));
  });
}
