import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/viewmodel/base_vm.dart';
import 'package:notus/notus.dart';

abstract class EditViewModel<T> extends BaseViewModel<Note> {
  saveNote(bool isEdit,Note note,NotusDocument document);
}
