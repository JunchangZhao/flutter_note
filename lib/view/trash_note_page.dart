import 'package:flutter/material.dart';
import 'package:flutter_app/di/provider.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/data/ui/trash_data.dart';
import 'package:flutter_app/model/note_model.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/view/base_state.dart';
import 'package:flutter_app/viewmodel/trash_vm.dart';
import 'package:flutter_app/widget/custom_simple_dialog.dart';
import 'package:flutter_app/widget/list_behavior.dart';
import 'package:flutter_svg/svg.dart';

class TrashNotePage extends StatefulWidget {
  @override
  _TrashNotePageState createState() => _TrashNotePageState();
}

class _TrashNotePageState extends BaseState<TrashViewModel> {
  @override
  TrashViewModel provideViewModel() {
    return provideTrashViewModel(context);
  }

  _showAction(Note note) {
    showDialog<Null>(
      context: context,
      builder: (context) {
        return new CustomSimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              child: Center(
                  child: new Text(
                S.of(context).restore,
                style: TextStyle(fontSize: 20),
              )),
              onPressed: () {
                viewModel.restore(note);
                Navigator.of(context).pop();
                viewModel.refreshData();
              },
            ),
            Divider(),
            SimpleDialogOption(
              child: Center(
                  child: new Text(
                S.of(context).delete,
                style: TextStyle(fontSize: 20),
              )),
              onPressed: () {
                viewModel.delete(note);
                Navigator.of(context).pop();
                viewModel.refreshData();
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
          title: Text(S.of(context).trash),
        ),
        body: StreamBuilder<TrashData>(
            stream: viewModel.outDatas,
            builder: (context, snapshot) {
              List notes;
              if (snapshot.data != null) {
                notes = snapshot.data.noteList;
              }
              return Stack(children: <Widget>[
                getBackground(notes),
                ScrollConfiguration(
                  behavior: ListBehavior(),
                  child: ListView.builder(
                      itemCount: notes == null ? 0 : notes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildItem(notes, index, context);
                      }),
                ),
              ]);
            }));
  }

  Column buildItem(List<Note> notes, int index, BuildContext context) {
    return Column(children: [
      GestureDetector(
        onLongPress: () {
          _showAction(notes[index]);
        },
        child: ListTile(
          title: Text(
            (notes[index].title == "\n"
                ? S.of(context).undefined
                : notes[index].title),
            style: TextStyle(
              fontSize: 22,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            Utils.getSubTitle(notes[index]),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            maxLines: 2,
          ),
        ),
      ),
      Divider(
        height: 1,
      ),
    ]);
  }

  getBackground(List notes) {
    if (notes == null || notes.length == 0) {
      return Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: SvgPicture.asset(
            "icons/trash.svg",
          ),
        ),
      );
    }
    return Container();
  }
}
