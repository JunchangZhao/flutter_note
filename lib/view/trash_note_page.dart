import 'package:flutter/material.dart';
import 'package:flutter_app/model/db/note.dart';
import 'package:flutter_app/presenters/note_presenter.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/widget/custom_simple_dialog.dart';
import 'package:flutter_app/widget/list_behavior.dart';
import 'package:oktoast/oktoast.dart';

class TrashNotePage extends StatefulWidget {
  @override
  _TrashNotePageState createState() => _TrashNotePageState();
}

class _TrashNotePageState extends State<TrashNotePage> {
  List<Note> notes;

  @override
  void initState() {
    super.initState();
    _getAllTrash();
  }

  void _getAllTrash() {
    NotePresenter.getAllNotes(true).then((list) {
      setState(() {
        this.notes = list;
      });
    });
  }

  _showAction(Note note) {
    showDialog<Null>(
      context: context,
      builder: (BuildContex) {
        return new CustomSimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              child: Center(
                  child: new Text(
                'Restore',
                style: TextStyle(fontSize: 20),
              )),
              onPressed: () {
                _restore(note);
                Navigator.of(context).pop();
                _getAllTrash();
              },
            ),
            Divider(),
            SimpleDialogOption(
              child: Center(
                  child: new Text(
                'Delete',
                style: TextStyle(fontSize: 20),
              )),
              onPressed: () {
                _delete(note);
                Navigator.of(context).pop();
                _getAllTrash();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trash"),
      ),
      body: ScrollConfiguration(
        behavior: ListBehavior(),
        child: ListView.builder(
            itemCount: notes == null ? 0 : this.notes.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                GestureDetector(
                  onLongPress: () {
                    _showAction(this.notes[index]);
                  },
                  child: ListTile(
                    title: Text(
                      (this.notes[index].title == "\n"
                          ? "Undefined"
                          : this.notes[index].title),
                      style: TextStyle(
                        fontSize: 22,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      Utils.getSubTitle(this.notes[index]),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
              ]);
            }),
      ),
    );
  }

  _restore(Note note) {
    NotePresenter.undoDeleteNote(note);
  }

  _delete(Note note) {
    NotePresenter.realDeleteNote(note);
  }
}
