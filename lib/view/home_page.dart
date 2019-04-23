import 'package:flutter/material.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/note_model.dart';
import 'package:flutter_app/router/custome_router.dart';
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
  String _accountName = "";
  List<Note> _notes;
  Note _removedNote;
  NoteModel _notePresenter = NoteModel();

  @override
  void initState() {
    super.initState();
    getAllNotes();
    SPKeys.ACCOUNT_NAME.getString().then((value) {
      setState(() {
        this._accountName = value;
      });
    });
    this._notes = homePageNoteList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S
            .of(context)
            .app_name),
      ),
      body: Center(child: getHomeBody()),
      drawer: Drawer(
        child: HomeDrawer(() {
          getAllNotes();
        }, _accountName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: Icon(Icons.add),
      ),
    );
  }

  getAllNotes() {
    _notePresenter.getAllNotes(context, false).then((list) {
      setState(() {
        this._notes = list;
      });
    });
  }


  void addNote() {
    Navigator.of(context).push(SlideRoute(EditNotePage(null))).then((result) {
      getAllNotes();
    });
  }

  void edit(Note note) {
    this._notes = null;
    Navigator.of(context).push(SlideRoute(EditNotePage(note))).then((result) {
      getAllNotes();
    });
  }

  void removeNote(int index) {
    _removedNote = this._notes[index];
    this._notes.removeAt(index);
    _notePresenter.deleteNote(_removedNote).then((result) {
      getAllNotes();
    });
  }

  undoDelete() {
    _notePresenter.undoDeleteNote(_removedNote).then((result) {
      getAllNotes();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    showToast(state.toString());
  }

  ListView buildNotesListView() {
    return ListView.builder(
        itemCount: (_notes == null ? 0 : _notes.length),
        itemBuilder: (BuildContext context, int index) {
          return buildItem(index, context);
        });
  }

  Dismissible buildItem(int index, BuildContext context) {
    return Dismissible(
      key: new Key("${this._notes[index].createTime}"),
      onDismissed: (direction) {
        doOnItemDismiss(index, context);
      },
      child: GestureDetector(
          onTap: () {
            edit(this._notes[index]);
          },
          child: NoteListItem(_notes.elementAt(index))),
      background: Container(
        color: Colors.grey,
      ),
    );
  }

  void doOnItemDismiss(int index, BuildContext context) {
    removeNote(index);
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: Row(
        children: <Widget>[
          Expanded(child: Text(S
              .of(context)
              .note_removed)),
          GestureDetector(
            onTap: undoDelete,
            child: Text(
              S
                  .of(context)
                  .undo,
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
  }

  getHomeBody() {
    return Stack(children: <Widget>[
      getBackground(),
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  getAllNotes();
                },
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

  getBackground() {
    if (this._notes == null || this._notes.length == 0) {
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
