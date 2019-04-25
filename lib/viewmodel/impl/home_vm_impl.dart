import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/data/home_data.dart';
import 'package:flutter_app/model/note_model.dart';
import 'package:flutter_app/router/custome_router.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/view/edit_note_page.dart';
import 'package:flutter_app/view/setting_page.dart';
import 'package:flutter_app/view/trash_note_page.dart';
import 'package:flutter_app/viewmodel/home_vm.dart';

class HomeViewModelImpl implements HomeViewModel {
  NoteModel _noteModel = NoteModel();
  var _homeController = StreamController<HomeData>.broadcast();

  HomeData _homeData = HomeData();

  BuildContext context;

  Note _removedNote;

  HomeViewModelImpl(BuildContext context) {
    this.context = context;
  }

  @override
  Stream<HomeData> get outDatas => _homeController.stream.map((data) {
        return data;
      });

  @override
  initDatas() async {
    _homeData.accountName = await SPKeys.ACCOUNT_NAME.getString();
    return refreshNotes();
  }

  @override
  void dispose() {
    _homeController.close();
  }

  @override
  addNote() async {
    await Navigator.of(context).push(SlideRoute(EditNotePage(null)));
    await refreshNotes();
  }

  @override
  edit(Note note) async {
    _homeData.noteList.clear();
    _homeController.add(_homeData);
    await Navigator.of(context).push(SlideRoute(EditNotePage(note)));
    await refreshNotes();
  }

  @override
  refreshNotes() async {
    _homeData.noteList.clear();
    List<Note> notes = await _noteModel.getAllNotes(context, false);
    _homeData.noteList = notes;
    _homeController.add(_homeData);
  }

  @override
  void removeNote(int index) async {
    _removedNote = this._homeData.noteList[index];
    this._homeData.noteList.removeAt(index);
    await _noteModel.deleteNote(_removedNote);
  }

  @override
  undoDelete() async {
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
