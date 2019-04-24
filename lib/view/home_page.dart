import 'package:flutter/material.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:flutter_app/di/provider.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/viewmodel/home_vm.dart';
import 'package:flutter_app/widget/home_drawer.dart';
import 'package:flutter_app/widget/list_behavior.dart';
import 'package:flutter_app/widget/note_list_item.dart';
import 'package:flutter_app/common/event.dart';
import 'package:flutter_svg/svg.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  String _accountName = "";
  List<Note> _notes;
  bool _canShowBackground = true;

  HomeViewModel _homeViewModel;

  @override
  void initState() {
    super.initState();
    _homeViewModel = provideHomeViewModel(context);
    _homeViewModel.refreshNotes();
    SPKeys.ACCOUNT_NAME.getString().then((value) {
      setState(() {
        this._accountName = value;
      });
    });
    this._notes = homePageNoteList;
    eventBus.on<SortChangeEvent>().listen((event) {
      _homeViewModel.refreshNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_name),
      ),
      body: Center(child: getHomeBody()),
      drawer: Drawer(
        child: HomeDrawer(_accountName, () {
          _homeViewModel.gotoSetting();
        }, () {
          _homeViewModel.gotoTrash().then((value) {
            _homeViewModel.refreshNotes();
          });
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _homeViewModel.addNote,
        child: Icon(Icons.add),
      ),
    );
  }

  getHomeBody() {
    return StreamBuilder<List<Note>>(
        stream: _homeViewModel.outNotelist,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            this._notes = snapshot.data;
          }
          return Stack(children: <Widget>[
            getBackground(),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return _homeViewModel.refreshNotes();
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
        });
  }

  Widget buildNotesListView() {
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
          onTap: () async {
            this._canShowBackground = false;
            var note = this._notes[index];
            await _homeViewModel.edit(note);
            this._canShowBackground = true;
          },
          child: NoteListItem(_notes.elementAt(index))),
      background: Container(
        color: Colors.grey,
      ),
    );
  }

  void doOnItemDismiss(int index, BuildContext context) {
    _homeViewModel.removeNote(index);
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: Row(
        children: <Widget>[
          Expanded(child: Text(S.of(context).note_removed)),
          GestureDetector(
            onTap: _homeViewModel.undoDelete,
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
  }

  getBackground() {
    if ((this._notes == null || this._notes.length == 0) &&
        this._canShowBackground) {
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

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }
}
