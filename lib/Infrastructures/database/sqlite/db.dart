import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SqliteDB {
  late Database db;

  init() async {
    await open(path.join(await getDatabasesPath(), "financial_tracker.db"));
  }

  open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await migration();
    });
  }

  migration() async {
    await db.execute('''
      CREATE TABLE IF NOT EXIST transaction_types ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL
      )''');

    await db.execute('''
      CREATE TABLE IF NOT EXIST periods ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL
      )''');

    await db.execute('''
      CREATE TABLE IF NOT EXIST transactions ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        transaction_type_id INTEGER NOT NULL,
        source_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        explanation TEXT NOT NULL,
        amount FLOAT NOT NULL
        date INTEGER NOT NULL
      )''');

    await db.execute('''
      CREATE TABLE IF NOT EXIST recurring_transactions ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        transaction_id INTEGER NOT NULL,
        number_in_period INTEGER NOT NULL
        period_id INTEGER NOT NULL
      )''');

    await db.execute('''
      CREATE TABLE IF NOT EXIST sources ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL,
        image_route TEXT NOT NULL
      )''');
  }

  Future<int> insert(String tableName, dynamic object) async =>
      await db.insert(tableName, object.toMap());

  Future<Map?> get(String tableName, int id) async {
    List<Map> maps =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return maps.first;
    }

    return null;
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
