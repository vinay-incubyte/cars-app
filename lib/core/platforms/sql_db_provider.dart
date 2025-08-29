import 'package:sqflite/sqflite.dart';

abstract class SqlDbProvider {
  Future<Database> getCarsDB();
}