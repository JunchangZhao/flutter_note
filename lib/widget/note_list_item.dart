import 'package:flutter/material.dart';
import 'package:flutter_app/common/event.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/db/note.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/utils/utils.dart';

class NoteListItem extends StatefulWidget {
  Note note;

  NoteListItem(this.note);

  @override
  _NoteListItemState createState() => _NoteListItemState(this.note);
}

class _NoteListItemState extends State<NoteListItem> {
  Note note;
  bool _isCompress = false;

  _NoteListItemState(this.note);

  int _font = 0;

  @override
  void initState() {
    SPKeys.SETTING_FONT_SIZE.getInt().then((value) {
      setState(() {
        this._font = value;
      });
    });
    SPKeys.COMPRESS_ITEM.getBoolean().then((value) {
      setState(() {
        this._isCompress = value;
      });
    });
    super.initState();
    eventBus.on<FontChangeEvent>().listen((event) {
      setState(() {
        this._font = event.fontType;
      });
    });

    eventBus.on<CompressEvent>().listen((event) {
      setState(() {
        this._isCompress = event.flag;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isCompress) {
      return buildCompressItem(context);
    } else {
      return buildCompleteItem(context);
    }
  }

  Column buildCompressItem(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  note.title == "\n" ? S.of(context).undefined : note.title,
                  style: TextStyle(
                    fontSize: getSubTitleSize() + 4.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  Container buildCompleteItem(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        note.title == "\n"
                            ? S.of(context).undefined
                            : note.title,
                        style: TextStyle(
                          fontSize: getSubTitleSize() + 4.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            Utils.getSubTitle(note),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: getSubTitleSize(),
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              Utils.getCreateTime(note.modifyTime),
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: getSubTitleSize() - 2 * this._font),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          alignment: FractionalOffset.bottomRight,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            height: 80.0 + this._font * 10,
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  getSubTitleSize() {
    return 12.0 + _font * 4;
  }
}
