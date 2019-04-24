import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/note_model.dart';
import 'package:flutter_app/router/custome_router.dart';
import 'package:flutter_app/view/edit_note_page.dart';
import 'package:flutter_app/viewmodel/home_vm.dart';

class HomeViewModelImpl implements HomeViewModel {
  NoteModel _noteModel = NoteModel();
  var _homeController = StreamController<List<Note>>.broadcast();

  List<Note> _noteList = new List();

  BuildContext context;

  Note _removedNote;

  HomeViewModelImpl(BuildContext context) {
    this.context = context;
  }

  @override
  void dispose() {
    _homeController.close();
  }

  @override
  Sink get inNoteList => _homeController;

  @override
  Stream<List<Note>> get outNotelist => _homeController.stream.map((notes) {
        _noteList.addAll(notes);
        return _noteList;
      });

  @override
  addNote() async {
    await Navigator.of(context).push(SlideRoute(EditNotePage(null)));
    await getAllNotes();
  }

  @override
  edit(Note note) async {
    await Navigator.of(context).push(SlideRoute(EditNotePage(note)));
    await getAllNotes();
  }

  @override
  getAllNotes() async {
    _noteList.clear();
    List<Note> notes = await _noteModel.getAllNotes(context, false);
    _homeController.add(notes);
    return 0;
  }

  @override
  void removeNote(int index) async {
    _removedNote = this._noteList[index];
    this._noteList.removeAt(index);
    await _noteModel.deleteNote(_removedNote);
    await getAllNotes();
  }

  @override
  undoDelete() async {
    await _noteModel.undoDeleteNote(_removedNote);
    await getAllNotes();
  }
}
