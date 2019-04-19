import 'package:flutter_app/model/db/note.dart';
import 'package:flutter_app/dao/note_dao.dart';
import 'package:flutter_app/utils/sputils.dart';

class NotePresenter {
  static Future<List<Note>> getAllNotes(bool trash) async {
    NoteDao sqlite = await NoteDao.getInstance();
    var result = await sqlite.queryAll(trash);
    return result;
  }

  static Future<Note> addNote(String title, String context) async {
    NoteDao sqlite = await NoteDao.getInstance();
    int time = DateTime.now().millisecondsSinceEpoch;
    String user = await SPKeys.ACCOUNT_NAME.getString();
    Note note = Note(title, context, time, time, user);
    await sqlite.insert(note);
    return note;
  }

  static Future<int> deleteNote(Note note) async {
    NoteDao sqlite = await NoteDao.getInstance();
    var result = await sqlite.delete(note);
    return result;
  }

  static Future<int> undoDeleteNote(Note note) async {
    NoteDao sqlite = await NoteDao.getInstance();
    var result = await sqlite.undoDelete(note);
    return result;
  }

  static Future<int> updateNote(Note note) async {
    NoteDao sqlite = await NoteDao.getInstance();
    var result = await sqlite.update(note);
    print(result);
    return result;
  }

  static Future<int> realDeleteNote(Note note) async {
    NoteDao sqlite = await NoteDao.getInstance();
    return await sqlite.realDelete(note.createTime);
  }
}
