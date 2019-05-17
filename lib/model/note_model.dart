import 'package:flutter/cupertino.dart';
import 'package:flutter_app/dao/note_dao.dart';
import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/utils/sputils.dart';

class NoteModel {

  Future<List<Note>> getAllNotes(BuildContext context, int type) async {
    NoteDao sqlite = await NoteDao.getInstance();
    List<Note> result = await sqlite.queryAll(type);
    int sortType = await SPKeys.SETTING_SORT.getInt();
    if (result != null) {
      result.sort((left, right) {
        if (sortType == 0) {
          return -left.modifyTime.compareTo(right.modifyTime);
        }
        if (sortType == 1) {
          return -left.createTime.compareTo(right.createTime);
        }
        if (sortType == 2) {
          return left.title.compareTo(right.title);
        }
      });
    }
    return result;
  }

  Future<Note> addNote(String title, String context,
      {int createTime: -1, int modifyTime: -1, bool isDeleted: false}) async {
    NoteDao sqlite = await NoteDao.getInstance();
    if (createTime == -1) {
      int time = DateTime
          .now()
          .millisecondsSinceEpoch;
      createTime = time;
      modifyTime = time;
    }
    String user = await SPKeys.ACCOUNT_NAME.getString();
    Note note = Note(title, context, createTime, modifyTime, user);
    await sqlite.insert(note);
    return note;
  }

  Future<int> deleteNote(Note note) async {
    note.user = await SPKeys.ACCOUNT_NAME.getString();
    NoteDao sqlite = await NoteDao.getInstance();
    var result = await sqlite.delete(note);
    return result;
  }

  Future<int> undoDeleteNote(Note note) async {
    note.user = await SPKeys.ACCOUNT_NAME.getString();
    NoteDao sqlite = await NoteDao.getInstance();
    var result = await sqlite.undoDelete(note);
    return result;
  }

  Future<int> updateNote(Note note) async {
    note.user = await SPKeys.ACCOUNT_NAME.getString();
    NoteDao sqlite = await NoteDao.getInstance();
    var result = await sqlite.update(note);
    return result;
  }

  Future<int> realDeleteNote(Note note) async {
    NoteDao sqlite = await NoteDao.getInstance();
    return await sqlite.realDelete(note.createTime);
  }
}
