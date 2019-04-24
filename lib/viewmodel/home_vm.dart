import 'package:flutter_app/model/data/db/note.dart';

abstract class HomeViewModel {
  Sink get inNoteList;

  Stream<List<Note>> get outNotelist;

  addNote();

  edit(Note note);

  getAllNotes();

  void removeNote(int index);

  undoDelete();

  void dispose();
}
