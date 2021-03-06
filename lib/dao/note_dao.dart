import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDao {
  static final int TYPE_NORMAL = 0;
  static final int TYPE_TRASH = 1;
  static final int TYPE_ALL = 2;

  static NoteDao instance;
  Database db;

  static Future<NoteDao> getInstance() async {
    if (instance == null) {
      instance = new NoteDao();
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
            $columnIsDeleted BOOL,
            $columnUser TEXT)
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

  Future<List<Note>> queryAll(int type) async {
    String whereStr = ' $columnUser = ?';
    List whereArgs = [await SPKeys.ACCOUNT_NAME.getString()];
    if (type != 2) {
      whereStr = '$columnIsDeleted = ? and $columnUser = ?';
      whereArgs = [type, await SPKeys.ACCOUNT_NAME.getString()];
    }

    List<Map> maps = await db.query(tableName,
        columns: [
          columnTitile,
          columnContext,
          columnCreateTime,
          columnModifyTime,
          columnIsDeleted
        ],
        orderBy: columnModifyTime,
        where: whereStr,
        whereArgs: whereArgs);

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
    note.modifyTime = DateTime.now().millisecondsSinceEpoch;
    return await db.update(tableName, note.toMap(),
        where: '$columnCreateTime = ?', whereArgs: [note.createTime]);
  }

  Future<int> undoDelete(Note note) async {
    note.isDeleted = false;
    note.modifyTime = DateTime.now().millisecondsSinceEpoch;
    return await db.update(tableName, note.toMap(),
        where: '$columnCreateTime = ?', whereArgs: [note.createTime]);
  }

  Future<int> update(Note note) async {
    note.modifyTime = DateTime.now().millisecondsSinceEpoch;
    return await db.update(tableName, note.toMap(),
        where: '$columnCreateTime = ?', whereArgs: [note.createTime]);
  }

  Future<int> realDelete(int createTime) async {
    return await db.delete(tableName,
        where: '$columnCreateTime = ?', whereArgs: [createTime]);
  }
}
