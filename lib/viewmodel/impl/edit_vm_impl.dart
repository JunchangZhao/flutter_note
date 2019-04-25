import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/note_model.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/viewmodel/edit_vm.dart';
import 'package:notus/notus.dart';

class EditViewModelImpl extends EditViewModel {
  BuildContext context;
  NoteModel noteModel;
  int _createTime;

  EditViewModelImpl(this.context);

  @override
  initDatas() async {
    noteModel = NoteModel();
  }

  @override
  Future<bool> saveNote(
      bool isEdit, Note oldNote, NotusDocument document) async {
    if (isEdit) {
      Note note = Note(
          document.toDelta()[0].data,
          json.encode(document),
          oldNote == null ? _createTime : oldNote.createTime,
          DateTime.now().millisecondsSinceEpoch,
          await SPKeys.ACCOUNT_NAME.getString());
      if (document.length == 1 && document.toDelta()[0].data == "\n") {
        noteModel.deleteNote(note);
      } else {
        noteModel.updateNote(note);
      }
    } else {
      if (document.length == 1 && document.toDelta()[0].data == "\n") {
        return isEdit;
      }
      isEdit = true;
      noteModel
          .addNote(document.toDelta()[0].data, json.encode(document))
          .then((note) {
        _createTime = note.createTime;
      });
    }
    return isEdit;
  }
}
