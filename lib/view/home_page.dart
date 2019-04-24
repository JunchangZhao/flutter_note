import 'package:flutter/material.dart';
import 'package:flutter_app/di/provider.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/data/home_data.dart';
import 'package:flutter_app/view/base_state.dart';
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

class _MyHomePageState extends BaseState<HomeViewModel>
    with WidgetsBindingObserver {
  bool _canShowBackground = true;

  @override
  void initState() {
    super.initState();
    eventBus.on<SortChangeEvent>().listen((event) {
      viewModel.refreshNotes();
    });
  }

  @override
  HomeViewModel provideViewModel() {
    return provideHomeViewModel(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomeData>(
      stream: viewModel.outDatas,
      builder: (context, snapshot) {
        HomeData homeData;
        if (snapshot.data != null) {
          homeData = snapshot.data;
        } else {
          homeData = HomeData();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).app_name),
          ),
          body: Center(child: getHomeBody(homeData)),
          drawer: Drawer(
            child: HomeDrawer(homeData.accountName, () {
              viewModel.gotoSetting();
            }, () {
              viewModel.gotoTrash().then((value) {
                viewModel.refreshNotes();
              });
            }),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: viewModel.addNote,
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  getHomeBody(HomeData homeData) {
    return Stack(children: <Widget>[
      getBackground(homeData.noteList),
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return viewModel.refreshNotes();
                },
                child: ScrollConfiguration(
                  child: buildNotesListView(homeData.noteList),
                  behavior: ListBehavior(),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget buildNotesListView(notes) {
    return ListView.builder(
        itemCount: (notes == null ? 0 : notes.length),
        itemBuilder: (BuildContext context, int index) {
          return buildItem(index, context, notes);
        });
  }

  Dismissible buildItem(int index, BuildContext context, List notes) {
    return Dismissible(
      key: new Key("${notes[index].createTime}"),
      onDismissed: (direction) {
        doOnItemDismiss(index, context);
      },
      child: GestureDetector(
          onTap: () async {
            this._canShowBackground = false;
            var note = notes[index];
            await viewModel.edit(note);
            this._canShowBackground = true;
          },
          child: NoteListItem(notes.elementAt(index))),
      background: Container(
        color: Colors.grey,
      ),
    );
  }

  void doOnItemDismiss(int index, BuildContext context) {
    viewModel.removeNote(index);
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: Row(
        children: <Widget>[
          Expanded(child: Text(S.of(context).note_removed)),
          GestureDetector(
            onTap: () async {
              _canShowBackground = false;
              await viewModel.undoDelete();
              _canShowBackground = true;
            },
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

  getBackground(note) {
    if ((note == null || note.length == 0) && this._canShowBackground) {
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
    super.dispose();
  }
}
