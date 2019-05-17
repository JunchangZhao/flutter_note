import 'package:flutter/cupertino.dart';
import 'package:flutter_app/dao/note_dao.dart';
import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/data/ui/trash_data.dart';
import 'package:flutter_app/model/note_model.dart';
import 'package:flutter_app/viewmodel/trash_vm.dart';

class TrashViewModelImpl extends TrashViewModel {
  BuildContext context;
  NoteModel noteModel = NoteModel();

  TrashViewModelImpl(this.context);

  TrashData trashData = TrashData();

  @override
  initDatas() async {
    await refreshData();
  }

  @override
  void refreshData() async {
    List<Note> notes = await noteModel.getAllNotes(context, NoteDao.TYPE_TRASH);
    trashData.noteList = notes;
    streamController.add(trashData);
  }

  @override
  delete(Note note) {
    noteModel.realDeleteNote(note);
  }

  @override
  restore(Note note) {
    noteModel.undoDeleteNote(note);
  }
}
