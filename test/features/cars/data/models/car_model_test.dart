import 'dart:convert';

import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  late CarModel car;

  setUp(() {
    car = CarModel(
      id: "1",
      name: 'Mercedes Benz Mercielago',
      manufacturer: 'Mazda',
      model: 'Cruze',
      fuel: 'Gasoline',
      type: 'Crew Cab Pickup',
      image: 'http://www.regcheck.org.uk/image.aspx/@TWF6ZGEgQ3J1emU=',
    );
  });
  group('verify car model', () {
    test('verify car model from json', () async {
      // arrange
      final jsonData = jsonDecode(await Fixture.load('car_fixture.json'));
      // act
      final actual = CarModel.fromJson(jsonData);
      // assert
      expect(actual, car);
    });

    test('verify toMap from car model', () async {
      // arrange
      final expected = jsonDecode(await Fixture.load('car_fixture.json'));
      // act
      final actual = car.toMap();
      // assert
      expect(actual, expected);
    });
  });
}
