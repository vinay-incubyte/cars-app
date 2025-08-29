import 'package:cars_app/core/expections.dart';
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
  late List<CarModel> cars;

  setUp(() {
    database = MockDatabase();
    carsLocalDataSourceImpl = CarsLocalDataSourceImpl(db: database);
    cars = List.generate(
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
  });

  group('Verify cars local storage data source', () {
    test('get cached cars if data exsit in DB', () async {
      // arrange

      final dbRows = cars.map((e) => e.toMap()).toList();
      when(database.query(CARS_TABLE)).thenAnswer((_) async => dbRows);
      // act
      final actual = await carsLocalDataSourceImpl.getCache();
      // assert
      expect(actual, cars);
      verify(database.query(CARS_TABLE)).called(1);
    });

    test('get Cache Expection if cars data not in DB', () async {
      // arrange
      final List<Map<String, Object?>> cars = [];
      when(database.query(CARS_TABLE)).thenAnswer((_) async => cars);
      // act
      final call = carsLocalDataSourceImpl.getCache();
      // assert
      expect(() => call, throwsA(TypeMatcher<CacheException>()));
      verify(database.query(CARS_TABLE)).called(1);
    });

    test('set cars cache with success', () async {
      // arrange
      when(database.delete(CARS_TABLE)).thenAnswer((_) async => 10);
      final batch = _FakeBatch();
      when(database.batch()).thenReturn(batch);
      // act
      await carsLocalDataSourceImpl.setCache(cars);
      // assert
      verify(database.delete(CARS_TABLE)).called(1);
      verify(database.batch()).called(1);
      expect(batch.inserts, cars.length);
    });
  });
}

class _FakeBatch implements Batch {
  int inserts = 0;

  @override
  Future<List<Object?>> commit({
    bool? exclusive,
    bool? noResult,
    bool? continueOnError,
  }) async {
    return [];
  }

  @override
  void insert(
    String table,
    Map<String, Object?> values, {
    String? nullColumnHack,
    ConflictAlgorithm? conflictAlgorithm,
  }) {
    inserts++;
  }

  // ignore unimplemented methods
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
