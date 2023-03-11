import 'package:sqflite/sqflite.dart';

class SqliteDB {
  late Database db;

  init() async {
    await open("financial_tracker.db");
  }

  open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await migration();
    });
  }

  migration() async {
    await db.execute('''
      create table if not exist transaction_types ( 
        id integer primary key autoincrement, 
        name text not null
      )''');

    await db.execute('''
      create table if not exist periods ( 
        id integer primary key autoincrement, 
        name text not null
      )''');

    await db.execute('''
      create table if not exist transactions ( 
        id integer primary key autoincrement, 
        transaction_type_id integer not null,
        source_id integer not null,
        name text not null,
        explanation text not null,
        amount float not null
        date integer not null
      )''');

    await db.execute('''
      create table if not exist recurring_transactions ( 
        id integer primary key autoincrement, 
        transaction_id integer not null,
        number_in_period integer not null
        period_id integer not null
      )''');

    await db.execute('''
      create table if not exist sources ( 
        id integer primary key autoincrement, 
        name text not null,
        image_route text not null
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
