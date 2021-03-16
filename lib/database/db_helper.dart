import 'package:note_app/model/note_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper{
  static Future<Database> database() async{
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(
      dbPath, 'notes.db'), onCreate: (db, version){
        return db.execute('CREATE TABLE user_notes(id TEXT PRIMARY KEY, title TEXT, note TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object>data)async{
    print(data);
    final db = await DBHelper.database();
    var rawData = db.insert(
      table, 
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    print(rawData);
  }

  static Future<void>delete(String id) async {
    final db = await DBHelper.database();
    db.delete(
      "user_notes",
      where: "id = ?",
      whereArgs: [id]);
  }

  static Future<int>update(NoteModel noteModel) async {
    final db = await DBHelper.database();
     await db.update(
      "user_notes",
     noteModel.toMap(),
      where: "id = ?",
     whereArgs: [noteModel.id]
    );
  }

  static Future<List<Map<String, dynamic>>>getData(String table)async{
    final db = await DBHelper.database();
    return db.query(table);
  }
}