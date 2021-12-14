import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'my_table';

  static final columnId = '_id';
  static final columnUserId = 'userid';
  static final columnUsername = 'username';
  static final columnEmail = 'emai';
  static final columnImage = 'image';
  static final columnStreet = 'street';
  static final columnSuit = 'suit';
  static final columnCity = 'city';
  static final columnZipcode = 'zipcode';
  static final columnLat = 'lat';
  static final columnLon = 'lon';
  static final columnPhone = 'phone';
  static final columnWebsite = 'website';
  // static final columnBranchname = 'branchname';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnUserId INTEGER NOT NULL,
            $columnUsername TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnImage TEXT NOT NULL,
            $columnStreet TEXT NOT NULL,
            $columnSuit TEXT NOT NULL,
            $columnCity TEXT NOT NULL,
            $columnZipcode TEXT NOT NULL,
            $columnLat TEXT NOT NULL,
            $columnLon TEXT NOT NULL,
            $columnPhone TEXT NOT NULL,
            $columnWebsite TEXT NOT NULL
          )
          ''');
  }


  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryRows(userid) async {
    Database? db = await instance.database;
    return await db!.query(table, where: "$columnUserId LIKE '%$userid%'");
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return  db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<int> deletedb() async {
    Database? db = await instance.database;
    return  db!.delete("delete from $table");
  }
  Future close() async {
    Database? db = await instance.database;
    db!.close();
  }
}


