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
  Note note;

  EditNotePage(this.note);

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

  Future _saveNote() async {
    if (this.isEdit) {
      Note note = Note(
          this.document.toDelta()[0].data,
          json.encode(this.document),
          widget.note.createTime,
          DateTime.now().millisecondsSinceEpoch,
          await SPKeys.ACCOUNT_NAME.getString());
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
      print("jack");
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
      body: ScrollConfiguration(
        behavior: ListBehavior(),
        child: NestedScrollView(
          headerSliverBuilder: _sliverBuilder,
          body: Column(
            children: <Widget>[
              _getTabBar(),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    _getTabView(true),
                    _getTabView(false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: _getFloatingButtun(),
    );
  }

  Widget _getTabView(bool enable) {
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

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
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

  Widget _getTabBar() {
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

  Widget _getFloatingButtun() {
    if (!this.showFloatButton) {
      return null;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          _saveNote();
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
