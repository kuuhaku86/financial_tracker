import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  late Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await migration();
    });
  }

  Future migration() async {
    await db.execute('''
      create table transaction_type ( 
        id integer primary key autoincrement, 
        name text not null
      )'''
    );

    await db.execute('''
      create table transaction ( 
        id integer primary key autoincrement, 
        transaction_type_id integer not null,
        source_id integer not null,
        explanation text not null,
        amount integer not null
      )'''
    );

    await db.execute('''
      create table recurring_transaction ( 
        id integer primary key autoincrement, 
        transaction_id integer not null,
        time_recurring_in_second integer not null
      )'''
    );

    await db.execute('''
      create table source ( 
        id integer primary key autoincrement, 
        name text not null,
        initial_amount integer not null
      )'''
    );
  }

  Future<dynamic> insert(String tableName, dynamic object) async {
    object.id = await db.insert(tableName, object.toMap());

    return object;
  }

  Future<dynamic> get(String tableName, List<String> columns, int id, Function(Map<dynamic, dynamic>) onGet) async {
    List<Map> maps = await db.query(tableName,
        columns: columns,
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return onGet(maps.first);
    }

    return null;
  }

  Future<int> delete(String tableName, int id) async {
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(String tableName, dynamic object) async {
    return await db.update(tableName, object.toMap(),
        where: 'id = ?', whereArgs: [object.id]);
  }

  Future close() async => db.close();
}
