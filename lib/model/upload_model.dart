import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:flutter_app/config/network_config.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/data/net/restful/register_result.dart';
import 'package:flutter_app/model/note_model.dart';
import 'package:flutter_app/utils/netutils.dart';
import 'package:web_socket_channel/io.dart';

class UploadModel {
  BuildContext context;

  NoteModel noteModel;

  UploadModel(BuildContext context) {
    this.context = context;
    noteModel = NoteModel();
  }

  refreshFromServer() async {
//    return await getAllNotesFromServer();
    List<Note> notes = await noteModel.getAllNotes(this.context, false);
    if (notes != null && notes.length > 0) {
      IOWebSocketChannel channel = getChannel();
      notes.forEach((note) {
        var data = """{
          "type": "upload_note",
          "data": {
            "title": "${note.title}",
            "context": "${note.context.toString().replaceAll("\"", "\'")}",
            "createTime": "${note.createTime.toString()}",
            "modifyTime": "${note.modifyTime.toString()}"
          }
        }""";
        channel.sink.add(data);
        channel.stream.listen((data) {
          print(data);
        });
      });
    }
  }

  Future getAllNotesFromServer() async {
    Response response =
        await NetUtils.getInstance().postHttp("/getAllNotes", null);
    if (response == null) {
      return RegisterResult(false, null, S.of(context).network_err);
    }
    RegisterResult result = RegisterResult.fromJson(response.data);
    return result;
  }

  IOWebSocketChannel getChannel() {
    IOWebSocketChannel channel = IOWebSocketChannel.connect(
      NetWorkConfig.WEBSOCKET_ADDRESS,
      headers: {"Authorization": "Bearer $jwt"},
    );
    return channel;
  }
}
