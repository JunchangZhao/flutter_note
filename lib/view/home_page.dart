import 'package:flutter/material.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/viewmodel/home_vm.dart';
import 'package:flutter_app/viewmodel/impl/home_vm_impl.dart';
import 'package:flutter_app/widget/home_drawer.dart';
import 'package:flutter_app/widget/list_behavior.dart';
import 'package:flutter_app/widget/note_list_item.dart';
import 'package:flutter_svg/svg.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  String _accountName = "";
  List<Note> _notes;

  HomeViewModel _homeViewModel;

  @override
  void initState() {
    super.initState();
    _homeViewModel = HomeViewModelImpl(context);
    _homeViewModel.getAllNotes();
    SPKeys.ACCOUNT_NAME.getString().then((value) {
      setState(() {
        this._accountName = value;
      });
    });
    print(homePageNoteList);
    this._notes = homePageNoteList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_name),
      ),
      body: Center(child: getHomeBody()),
      drawer: Drawer(
        child: HomeDrawer(() {
          _homeViewModel.getAllNotes();
        }, _accountName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _homeViewModel.addNote,
        child: Icon(Icons.add),
      ),
    );
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
      child: StreamBuilder<List<Note>>(
          stream: _homeViewModel.outNotelist,
          builder: (context, snapshot) {
            print("jack: ${snapshot.data}");
            this._notes = snapshot.data;
            return GestureDetector(
                onTap: () {
                  _homeViewModel.edit(this._notes[index]);
                },
                child: NoteListItem(_notes.elementAt(index)));
          }),
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
                  _homeViewModel.getAllNotes();
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
