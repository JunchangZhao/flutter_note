import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/data/ui/home_data.dart';
import 'package:flutter_app/viewmodel/base_vm.dart';

abstract class HomeViewModel extends BaseViewModel<HomeData> {
  addNote();

  edit(Note note);

  refreshNotes();

  void removeNote(int index);

  undoDelete();

  gotoSetting();

  gotoTrash() {}

  startUpload();
}
