import 'package:flutter/material.dart';
import 'package:flutter_app/model/db/note.dart';
import 'package:flutter_app/utils/date_format_base.dart';
import 'dart:convert';

import 'package:zefyr/zefyr.dart';

class NoteListItem extends StatefulWidget {
  Note note;

  NoteListItem(this.note);

  @override
  _NoteListItemState createState() => _NoteListItemState(this.note);
}

class _NoteListItemState extends State<NoteListItem> {
  Note note;

  _NoteListItemState(this.note);

  String _getSubTitle(String context) {
    NotusDocument document = NotusDocument.fromJson(json.decode(context));
    if (document.toDelta().length < 3) {
      return "";
    }
    return document.toDelta()[2].value.toString();
  }

  @override
  Widget build(BuildContext context) {
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
                        note.title.trim(),
                        style: TextStyle(
                          fontSize: 22,
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
                            _getSubTitle(note.context),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Align(
                          child: Text(
                            _getCreateTime(note.modifyTime),
                            style:
                                TextStyle(color: Colors.black45, fontSize: 14),
                            textAlign: TextAlign.right,
                          ),
                          alignment: FractionalOffset.bottomRight,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            height: 80,
          ),
          Divider(),
        ],
      ),
    );
  }

  String _getCreateTime(int modifyTime) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(note.modifyTime);
    return formatDate(
        time, [HH, ':', nn, ':', ss, "\n", yyyy, '-', mm, '-', dd]);
  }
}
