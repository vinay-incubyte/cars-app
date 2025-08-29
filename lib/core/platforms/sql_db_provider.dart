import 'package:sqflite/sqflite.dart';

abstract class SqlDbProvider {
  Future<Database> getDB();
}

class CarDbProvider implements SqlDbProvider {
  final DatabaseFactory dbFactory;
  final String path;

  CarDbProvider({DatabaseFactory? dbFactory, this.path = 'cars.db'})
    : dbFactory = dbFactory ?? databaseFactory;

  @override
  Future<Database> getDB() async {
    final db = await dbFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
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
        },
      ),
    );
    return db;
  }
}
