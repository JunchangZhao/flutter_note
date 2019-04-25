import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/data/ui/trash_data.dart';
import 'package:flutter_app/viewmodel/base_vm.dart';

abstract class TrashViewModel extends BaseViewModel<TrashData> {

  void refreshData();

  restore(Note note);

  delete(Note note);
}
