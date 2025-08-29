import 'package:cars_app/core/platforms/sql_db_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

@GenerateMocks([Database])
void main() {
  late SqlDbProvider carDbProviderImpl;
  late Database db;
  sqfliteFfiInit();

  setUp(() async {
    databaseFactory = databaseFactoryFfi;
    await databaseFactory.deleteDatabase(inMemoryDatabasePath);
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute('''
        CREATE TABLE cars(
          id INTEGER PRIMARY KEY,
          vehicle TEXT,
          model TEXT,
          type TEXT,
          manufacturer TEXT,
          fuel TEXT,
          image TEXT
        )
      ''');

    carDbProviderImpl = CarDbProvider(
      dbFactory: databaseFactory,
      path: inMemoryDatabasePath,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('verify get Cars DB', () async {
    // act
    final actual = await carDbProviderImpl.getDB();
    final result = await actual.rawQuery("PRAGMA table_info(cars);");
    final columnNames = result.map((row) => row['name']).toList();
    // assert
    expect(
      columnNames,
      containsAll([
        'id',
        'vehicle',
        'model',
        'type',
        'manufacturer',
        'fuel',
        'image',
      ]),
    );
  });
}
