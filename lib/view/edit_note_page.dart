import 'package:flutter/material.dart';
import 'package:flutter_app/model/db/note.dart';
import 'package:flutter_app/presenters/note_presenter.dart';
import 'package:zefyr/zefyr.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:convert';

class EditNotePage extends StatefulWidget {
  Note note;

  EditNotePage(this.note);

  @override
  _EditNotePage createState() => _EditNotePage();
}

class _EditNotePage extends State<EditNotePage> {
  ZefyrController _controller;
  FocusNode _focusNode;
  NotusDocument document;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.note == null) {
      this.document = NotusDocument();
      document.format(0, 10, NotusAttribute.heading.level1);
    } else {
      this.document = NotusDocument.fromJson(json.decode(widget.note.context));
      this.isEdit = true;
    }

    _controller = new ZefyrController(document);
    _controller.addListener(() {
      _saveNote();
    });
    _focusNode = new FocusNode();
  }

  void _saveNote() {
    if (this.isEdit) {
      Note note = Note(
          this.document.toDelta()[0].data,
          json.encode(this.document),
          widget.note.createTime,
          DateTime.now().millisecondsSinceEpoch);
      if (this.document.length == 1 &&
          this.document.toDelta()[0].data == "\n") {
        NotePresenter.deleteNote(note);
      } else {
        NotePresenter.updateNote(note);
      }
    } else {
      if (this.document.length == 1 &&
          this.document.toDelta()[0].data == "\n") {
        return;
      }
      this.isEdit = true;
      NotePresenter.addNote(
              this.document.toDelta()[0].data, json.encode(this.document))
          .then((note) {
        widget.note = note;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: Container(
        child: ZefyrScaffold(
          child: ZefyrEditor(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: false,
            padding: EdgeInsets.only(top: 8, left: 16, right: 16),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 48.0),
        child: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            _saveNote();
            showToast(
              "Save Success!",
              position: ToastPosition.bottom,
              textPadding: EdgeInsets.all(12),
            );
          },
        ),
      ),
    );
  }
}
