import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static Future<Database> database() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbpath, 'places.db'),
      onCreate: (db, version) {
        print('Creating database table "places"...');
        return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, img TEXT, loc_lat REAL, loc_lng REAL, address TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbHelper.database();

    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbHelper.database();
    return db.query(table);
  }
}
