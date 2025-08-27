import 'dart:convert';

import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture.dart';

void main() {
  test('verify car model from json', () async {
    // arrange
    final expected = CarModel(
      id: "1",
      name: 'Mercedes Benz Mercielago',
      manufacturer: 'Mazda',
      model: 'Cruze',
      fuel: 'Gasoline',
      type: 'Crew Cab Pickup',
      image: 'http://www.regcheck.org.uk/image.aspx/@TWF6ZGEgQ3J1emU=',
    );
    final jsonData = jsonDecode(await Fixture.load('car_fixture.json'));
    // act
    final actual = CarModel.fromJson(jsonData);
    // assert
    expect(actual, expected);
  });
}
