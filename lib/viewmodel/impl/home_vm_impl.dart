import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/note_model.dart';
import 'package:flutter_app/router/custome_router.dart';
import 'package:flutter_app/view/edit_note_page.dart';
import 'package:flutter_app/view/setting_page.dart';
import 'package:flutter_app/view/trash_note_page.dart';
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
  Stream<List<Note>> get outNotelist => _homeController.stream.map((notes) {
        _noteList.addAll(notes);
        return _noteList;
      });

  @override
  addNote() async {
    await Navigator.of(context).push(SlideRoute(EditNotePage(null)));
    await refreshNotes();
  }

  @override
  edit(Note note) async {
    _noteList.clear();
    _homeController.add(null);
    await Navigator.of(context).push(SlideRoute(EditNotePage(note)));
    await refreshNotes();
  }

  @override
  refreshNotes() async {
    _noteList.clear();
    List<Note> notes = await _noteModel.getAllNotes(context, false);
    _homeController.add(notes);
  }

  @override
  void removeNote(int index) async {
    _removedNote = this._noteList[index];
    this._noteList.removeAt(index);
    await _noteModel.deleteNote(_removedNote);
  }

  @override
  undoDelete() async {
    _homeController.add([]);
    await _noteModel.undoDeleteNote(_removedNote);
    await refreshNotes();
  }

  @override
  Future gotoSetting() async {
    return await Navigator.push(
        context, new MaterialPageRoute(builder: (context) => SettingPage()));
  }

  @override
  Future gotoTrash() async {
    return await Navigator.push(
        context, new MaterialPageRoute(builder: (context) => TrashNotePage()));
  }
}
