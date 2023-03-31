import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteDB {
  late Database db;

  init() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      var databaseFactory = databaseFactoryFfi;
      db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    } else {
      await open(path.join(await getDatabasesPath(), "financial_tracker.db"));
    }

    await migration();
  }

  open(String path) async {
    db = await openDatabase(path, version: 1);
  }

  migration() async {
    await db.execute(
        '''
      CREATE TABLE IF NOT EXISTS transaction_types ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL
      )''');

    String tableName = "transaction_types";
    int? transactionTypesCount = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tableName"));

    if (transactionTypesCount == null || transactionTypesCount == 0) {
      await db.insert(tableName, <String, Object>{"name": "Income"});
      await db.insert(tableName, <String, Object>{"name": "Outcome"});
    }

    await db.execute(
        '''
      CREATE TABLE IF NOT EXISTS periods ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL
      )''');

    tableName = "periods";
    int? periodsCount = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tableName"));

    if (periodsCount == null || periodsCount == 0) {
      await db.insert(tableName, <String, Object>{"name": "Days"});
      await db.insert(tableName, <String, Object>{"name": "Months"});
      await db.insert(tableName, <String, Object>{"name": "Years"});
    }

    await db.execute(
        '''
      CREATE TABLE IF NOT EXISTS transactions ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        transaction_type_id INTEGER NOT NULL,
        source_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        explanation TEXT NOT NULL,
        amount FLOAT NOT NULL,
        date INTEGER NOT NULL
      )''');

    await db.execute(
        '''
      CREATE TABLE IF NOT EXISTS recurring_transactions ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        transaction_id INTEGER NOT NULL,
        number_in_period INTEGER NOT NULL,
        period_id INTEGER NOT NULL
      )''');

    await db.execute(
        '''
      CREATE TABLE IF NOT EXISTS sources ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL,
        image_route TEXT NOT NULL
      )''');
  }

  Future<int> insert(String tableName, Map<String, Object> map) async =>
      await db.insert(tableName, map);

  Future<Map?> get(String tableName, int id) async {
    List<Map> maps =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return maps.first;
    }

    return null;
  }

  Future<List<Map?>> getByWhere(
      String tableName, String whereStatement, List<Object?> whereArgs) async {
    List<Map> maps =
        await db.query(tableName, where: whereStatement, whereArgs: whereArgs);

    if (maps.isNotEmpty) {
      return maps;
    }

    return [];
  }

  Future<List<Map>> getAll(String tableName) async {
    List<Map> maps = await db.query(tableName);

    return maps;
  }

  Future<int> delete(String tableName, int id) async =>
      await db.delete(tableName, where: 'id = ?', whereArgs: [id]);

  Future<int> update(String tableName, dynamic object) async {
    return await db.update(tableName, object.toMap(),
        where: 'id = ?', whereArgs: [object.id]);
  }

  Future close() async => await db.close();
}
