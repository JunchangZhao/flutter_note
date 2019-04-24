import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/data/home_data.dart';
import 'package:flutter_app/viewmodel/base_vm.dart';

abstract class HomeViewModel implements BaseViewModel<HomeData> {
  addNote();

  edit(Note note);

  refreshNotes();

  void removeNote(int index);

  undoDelete();

  Future gotoSetting();

  Future gotoTrash() {}
}
