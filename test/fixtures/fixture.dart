import 'dart:io';

class Fixture {
  static Future<String> load(String name) async {
    return await File('test/fixtures/$name').readAsString();
  }
}
