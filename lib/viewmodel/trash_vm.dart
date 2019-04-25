import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/data/ui/trash_data.dart';
import 'package:flutter_app/viewmodel/base_vm.dart';

abstract class TrashViewModel<T> extends BaseViewModel<TrashData, T> {

  void refreshData();

  restore(Note note);

  delete(Note note);
}
