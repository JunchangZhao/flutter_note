import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/db/note.dart';
import 'package:flutter_app/presenters/note_presenter.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/widget/list_behavior.dart';
import 'package:zefyr/zefyr.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:convert';

class EditNotePage extends StatefulWidget {
  Note _note;

  EditNotePage(this._note);

  @override
  _EditNotePage createState() => _EditNotePage();
}

class _EditNotePage extends State<EditNotePage>
    with SingleTickerProviderStateMixin {
  ZefyrController _controller;
  FocusNode _focusNode;
  NotusDocument document;
  bool isEdit = false;
  TabController tabController;
  bool showFloatButton = true;
  NotePresenter notePresenter = NotePresenter();

  @override
  void initState() {
    super.initState();
    if (widget._note == null) {
      this.document = NotusDocument();
      document.format(0, 10, NotusAttribute.heading.level1);
    } else {
      this.document = NotusDocument.fromJson(json.decode(widget._note.context));
      this.isEdit = true;
    }

    _controller = new ZefyrController(document);
    _controller.addListener(() {
      saveNote();
    });
    _focusNode = new FocusNode();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        if (tabController.index == 0) {
          showFloatButton = true;
        } else {
          showFloatButton = false;
        }
      });
    });
  }

  Future saveNote() async {
    if (this.isEdit) {
      Note note = Note(
          this.document.toDelta()[0].data,
          json.encode(this.document),
          widget._note.createTime,
          DateTime.now().millisecondsSinceEpoch,
          await SPKeys.ACCOUNT_NAME.getString());
      if (this.document.length == 1 &&
          this.document.toDelta()[0].data == "\n") {
        notePresenter.deleteNote(note);
      } else {
        notePresenter.updateNote(note);
      }
    } else {
      if (this.document.length == 1 &&
          this.document.toDelta()[0].data == "\n") {
        return;
      }
      this.isEdit = true;
      notePresenter.addNote(
              this.document.toDelta()[0].data, json.encode(this.document))
          .then((note) {
        widget._note = note;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ListBehavior(),
        child: NestedScrollView(
          headerSliverBuilder: sliverBuilder,
          body: Column(
            children: <Widget>[
              getTabBar(),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    getTabView(true),
                    getTabView(false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: getFloatingButtun(),
    );
  }

  Widget getTabView(bool enable) {
    return Container(
        child: ZefyrScaffold(
            child: ZefyrEditor(
                controller: _controller,
                focusNode: _focusNode,
                autofocus: false,
                enabled: enable,
                padding: EdgeInsets.only(top: 8, left: 16, right: 16))));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  List<Widget> sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        centerTitle: true,
        expandedHeight: 50.0,
        backgroundColor: Colors.blue,
        floating: false,
        pinned: false,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(S.of(context).edit_note),
        ),
      )
    ];
  }

  Widget getTabBar() {
    return Container(
      height: 72,
      child: PhysicalModel(
        elevation: 6,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: TabBar(
            controller: tabController,
            tabs: <Widget>[
              Tab(
                child: Text(
                  S.of(context).edit,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).preview,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFloatingButtun() {
    if (!this.showFloatButton) {
      return null;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          saveNote();
          showToast(
            S.of(context).save_success,
            position: ToastPosition.bottom,
            textPadding: EdgeInsets.all(12),
          );
        },
      ),
    );
  }
}
