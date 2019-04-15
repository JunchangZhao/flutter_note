import 'dart:convert';

import 'package:flutter_app/model/db/note.dart';
import 'package:flutter_app/utils/date_format_base.dart';
import 'package:notus/notus.dart';

class Utils {
  static String getCreateTime(int timestr) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestr);
    return formatDate(
        time, [HH, ':', nn, ':', ss, "\n", yyyy, '-', mm, '-', dd]);
  }

  static String getSubTitle(Note note) {
    NotusDocument document = NotusDocument.fromJson(json.decode(note.context));
    if (note.title == "\n") {
      if (document.toDelta().length < 2) {
        return "";
      }
      return document.toDelta()[1].value.toString();
    } else {
      if (document.toDelta().length < 3) {
        return "";
      }
      return document.toDelta()[2].value.toString();
    }
  }
}
