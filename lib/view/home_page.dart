import 'package:flutter/material.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/presenters/note_presenter.dart';
import 'package:flutter_app/router/custome_router.dart';
import 'package:flutter_app/model/db/note.dart';
import 'package:flutter_app/view/edit_note_page.dart';
import 'package:flutter_app/widget/home_drawer.dart';
import 'package:flutter_app/widget/list_behavior.dart';
import 'package:flutter_app/widget/note_list_item.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_app/utils/sputils.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  String accountName = "";
  List<Note> notes;

  Note removeNote;

  NotePresenter notePresenter = NotePresenter();

  @override
  void initState() {
    super.initState();
    getAllNotes();
    SPKeys.ACCOUNT_NAME.getString().then((value) {
      setState(() {
        this.accountName = value;
      });
    });
    this.notes = homePageNoteList;
  }

  getAllNotes() {
    notePresenter.getAllNotes(context, false).then((list) {
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
    this.notes = null;
    Navigator.of(context).push(SlideRoute(EditNotePage(note))).then((result) {
      getAllNotes();
    });
  }

  void _removeNote(int index) {
    removeNote = this.notes[index];
    this.notes.removeAt(index);
    notePresenter.deleteNote(removeNote).then((result) {
      getAllNotes();
    });
  }

  _undoDelete() {
    notePresenter.undoDeleteNote(removeNote).then((result) {
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
        title: Text(S.of(context).app_name),
      ),
      body: Center(child: _getHomeBody()),
      drawer: Drawer(
        child: HomeDrawer(() {
          getAllNotes();
        }, accountName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
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
                    Expanded(child: Text(S.of(context).note_removed)),
                    GestureDetector(
                      onTap: _undoDelete,
                      child: Text(
                        S.of(context).undo,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
                duration: Duration(seconds: 1),
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

  _getHomeBody() {
    return Stack(children: <Widget>[
      _getBackground(),
      Container(
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
      ),
    ]);
  }

  _getBackground() {
    if (this.notes == null || this.notes.length == 0) {
      return Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: SvgPicture.asset(
            "icons/emptyNote.svg",
          ),
        ),
      );
    }
    return Container();
  }
}
