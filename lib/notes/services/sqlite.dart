import 'package:sqflite/sqflite.dart';

class SQLite {

  static Database _db;

  static Future<void> _onCreate (Database db , int version) async {
    await db.execute('create table notes (id integer primary key autoincrement,title text not null, body text not null, creationDate text not null)');
  }

  static Future<void> init() async{
    _db = await openDatabase(
      'note.db',
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Database get db => _db;

}

class SQliteHelper{

  Future<List<Map<String , dynamic>>> get notes async {
    return await SQLite.db.query(
      'notes',
      orderBy: 'creationDate ASC',
    );
  }

  Future<int> insertNote(Map<String , dynamic> note) async{
    return await SQLite.db.insert(
      'notes', 
      note,
      conflictAlgorithm: ConflictAlgorithm.replace,
      );
  }

  Future<int> deleteNote(int id)async {
    return await SQLite.db.delete(
      'notes',
      where: 'id=?',
      whereArgs: [id],
    );
  }

}