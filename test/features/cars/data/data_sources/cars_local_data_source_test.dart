import 'package:cars_app/features/cars/data/data_sources/cars_local_data_source.dart';
import 'package:cars_app/features/cars/data/models/car_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import 'cars_local_data_source_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  late CarsLocalDataSourceImpl carsLocalDataSourceImpl;
  late Database database;

  setUp(() {
    database = MockDatabase();
    carsLocalDataSourceImpl = CarsLocalDataSourceImpl(db: database);
  });

  group('Verify cars local storage data source', () {
    test('get cached cars if data exsit in DB', () async {
      // arrange
      final List<CarModel> cars = List.generate(
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
      final dbRows = cars.map((e) => e.toMap()).toList();
      when(database.query(CARS_TABLE)).thenAnswer((_) async => dbRows);
      // act
      final actual = await carsLocalDataSourceImpl.getCache();
      // assert
      expect(actual, cars);
      verify(database.query(CARS_TABLE)).called(1);
    });
  });
}
