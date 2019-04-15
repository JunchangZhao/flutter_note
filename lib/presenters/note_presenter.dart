import 'package:flutter_app/model/db/note.dart';
import 'package:flutter_app/utils/dbutils.dart';

class NotePresenter {
  static Future<List<Note>> getAllNotes() async {
    NoteSqlite sqlite = await NoteSqlite.getInstance();
    var result = await sqlite.queryAll();
    return result;
  }

  static Future<Note> addNote(String title, String context) async {
    NoteSqlite sqlite = await NoteSqlite.getInstance();
    int time = DateTime.now().millisecondsSinceEpoch;
    Note note = Note(title, context, time, time);
    await sqlite.insert(note);
    return note;
  }

  static Future<int> deleteNote(Note note) async {
    NoteSqlite sqlite = await NoteSqlite.getInstance();
    var result = await sqlite.delete(note);
    return result;
  }

  static Future<int> undoDeleteNote(Note note) async {
    NoteSqlite sqlite = await NoteSqlite.getInstance();
    var result = await sqlite.undoDelete(note);
    return result;
  }

  static Future<int> updateNote(Note note) async {
    NoteSqlite sqlite = await NoteSqlite.getInstance();
    var result = await sqlite.update(note);
    return result;
  }
}
