import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/model/db/note.dart';

class NoteSqlite {
  static NoteSqlite instance;
  Database db;

  static Future<NoteSqlite> getInstance() async {
    if (instance == null) {
      instance = new NoteSqlite();
      await instance.openSqlite();
    }
    return instance;
  }

  openSqlite() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY autoincrement, 
            $columnTitile TEXT, 
            $columnContext TEXT, 
            $columnCreateTime INTEGER, 
            $columnModifyTime INTEGER,
            $columnIsDeleted BOOL)
          ''');
    });
  }

  close() async {
    await db.close();
  }

  Future<Note> insert(Note note) async {
    await db.insert(tableName, note.toMap());
    return note;
  }

  Future<List<Note>> queryAll(bool trash) async {
    List<Map> maps = await db.query(tableName,
        columns: [
          columnTitile,
          columnContext,
          columnCreateTime,
          columnModifyTime,
          columnIsDeleted
        ],
        orderBy: columnModifyTime,
        where: '$columnIsDeleted = ?',
        whereArgs: [trash ? 1 : 0]);

    if (maps == null || maps.length == 0) {
      return null;
    }

    List<Note> notes = [];
    for (int i = maps.length - 1; i >= 0; i--) {
      Note note = Note.fromMap(maps[i]);
      notes.add(note);
    }
    return notes;
  }

  Future<int> delete(Note note) async {
    note.isDeleted = true;
    return await db.update(tableName, note.toMap(),
        where: '$columnCreateTime = ?', whereArgs: [note.createTime]);
  }

  Future<int> undoDelete(Note note) async {
    note.isDeleted = false;
    return await db.update(tableName, note.toMap(),
        where: '$columnCreateTime = ?', whereArgs: [note.createTime]);
  }

  Future<int> update(Note note) async {
    return await db.update(tableName, note.toMap(),
        where: '$columnCreateTime = ?', whereArgs: [note.createTime]);
  }

  Future<int> realDelete(int createTime) async {
    return await db.delete(tableName,
        where: '$columnCreateTime = ?', whereArgs: [createTime]);
  }
}
