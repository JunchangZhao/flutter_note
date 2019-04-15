import 'package:flutter/material.dart';
import 'package:flutter_app/presenters/note_presenter.dart';
import 'package:flutter_app/router/custome_router.dart';
import 'package:flutter_app/model/db/note.dart';
import 'package:flutter_app/view/edit_note_page.dart';
import 'package:flutter_app/widget/home_drawer.dart';
import 'package:flutter_app/widget/list_behavior.dart';
import 'package:flutter_app/widget/note_list_item.dart';
import 'package:oktoast/oktoast.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<Note> notes;

  Note removeNote;

  @override
  void initState() {
    super.initState();
    getAllNotes();
  }

  getAllNotes() {
    NotePresenter.getAllNotes().then((list) {
      setState(() {
        this.notes = list;
      });
    });
  }

  Future<void> _getAllNotes() async {
    getAllNotes();
    return null;
  }

  void _addNote() {
    Navigator.of(context).push(SlideRoute(EditNotePage(null))).then((result) {
      getAllNotes();
    });
  }

  void _edit(Note note) {
    setState(() {
      this.notes = null;
    });
    Navigator.of(context).push(SlideRoute(EditNotePage(note))).then((result) {
      getAllNotes();
    });
  }

  void _removeNote(int index) {
    removeNote = this.notes[index];
    this.notes.removeAt(index);
    NotePresenter.deleteNote(removeNote).then((result) {
      getAllNotes();
    });
  }

  _undoDelete() {
    NotePresenter.undoDeleteNote(removeNote).then((result) {
      getAllNotes();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    showToast(state.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: RefreshIndicator(
                onRefresh: _getAllNotes,
                child: ScrollConfiguration(
                  child: buildNotesListView(),
                  behavior: ListBehavior(),
                ),
              ),
            ),
          ],
        ),
      )),
      drawer: Drawer(
        child: HomeDrawer(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView buildNotesListView() {
    return ListView.builder(
                    itemCount: (notes == null ? 0 : notes.length),
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: new Key("${this.notes[index].createTime}"),
                        onDismissed: (direction) {
                          _removeNote(index);
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            content: Row(
                              children: <Widget>[
                                Expanded(child: Text("Note is dismissed")),
                                GestureDetector(
                                  onTap: _undoDelete,
                                  child: Text(
                                    "undo",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white70,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            duration: Duration(seconds: 2),
                          ));
                        },
                        child: GestureDetector(
                            onTap: () {
                              _edit(this.notes[index]);
                            },
                            child: NoteListItem(notes.elementAt(index))),
                        background: Container(
                          color: Colors.grey,
                        ),
                      );
                    });
  }
}
