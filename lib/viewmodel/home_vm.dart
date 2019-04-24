import 'package:flutter_app/model/data/db/note.dart';

abstract class HomeViewModel {

  Stream<List<Note>> get outNotelist;

  addNote();

  edit(Note note);

  refreshNotes();

  void removeNote(int index);

  undoDelete();

  dispose();

  Future gotoSetting();

  Future gotoTrash() {}
}
