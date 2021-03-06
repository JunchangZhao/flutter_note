import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:flutter_app/common/event.dart';
import 'package:flutter_app/config/network_config.dart';
import 'package:flutter_app/dao/note_dao.dart';
import 'package:flutter_app/model/data/db/note.dart';
import 'package:flutter_app/model/data/net/websocket/notes_info.dart';
import 'package:flutter_app/model/note_model.dart';
import 'package:web_socket_channel/io.dart';

class UploadModel {
  BuildContext context;

  NoteModel noteModel;

  UploadModel(BuildContext context) {
    this.context = context;
    noteModel = NoteModel();
  }

  IOWebSocketChannel getChannel() {
    IOWebSocketChannel channel = IOWebSocketChannel.connect(
      NetWorkConfig.WEBSOCKET_ADDRESS,
      headers: {"Authorization": "Bearer $jwt"},
    );
    return channel;
  }

  refreshFromServer() async {
    IOWebSocketChannel channel = getChannel();
    channel.stream.listen((data) async {
      print(data);
      NotesCreateAndModifyInfo info =
          NotesCreateAndModifyInfo.fromJson(json.decode(data));
      if (info.type == "create_modify_time") {
        List<NoteInfo> notesServer = info.data == null ? [] : info.data;
        List<Note> notesLocal =
            await noteModel.getAllNotes(this.context, NoteDao.TYPE_ALL);
        pushNotes(notesLocal, notesServer, channel);
        pullNotes(notesLocal, notesServer, channel);
      }

      if (info.type == "pull_note") {
        NoteInfo noteInfo = info.data[0];
        noteModel.addNote(noteInfo.title, noteInfo.context,
            createTime: noteInfo.createTime,
            modifyTime: noteInfo.modifyTime,
            isDeleted: noteInfo.isDeleted);
        eventBus.fire(PullNoteEvent());
      }
    });
  }

  void pushNotes(List<Note> notesLocal, List<NoteInfo> notesServer,
      IOWebSocketChannel channel) {
    if (notesLocal != null && notesLocal.length > 0) {
      notesLocal.forEach((note) {
        bool shouldUpload = true;
        notesServer.forEach((serverNote) {
          if (serverNote.createTime == note.createTime) {
            if (serverNote.modifyTime > note.modifyTime) {
              shouldUpload = false;
            }
          }
        });

        if (shouldUpload) {
          var data = NotesCreateAndModifyInfo("upload_note", [
            NoteInfo(note.title, note.context, note.createTime, note.modifyTime,
                note.isDeleted)
          ]);
          channel.sink.add(json.encode(data.toJson()));
        }
      });
    }
  }

  void pullNotes(List<Note> notesLocal, List<NoteInfo> notesServer,
      IOWebSocketChannel channel) {
    if (notesServer != null && notesServer.length > 0) {
      notesServer.forEach((serverNote) {
        bool needPullNote = true;

        if (notesLocal != null) {
          notesLocal.forEach((localNote) {
            if (serverNote.createTime == localNote.createTime) {
              if (serverNote.modifyTime <= localNote.modifyTime) {
                needPullNote = false;
              }
            }
          });
        }

        if (needPullNote) {
          var data = """{
            "type": "get_note",
            "data": {
               "createTime": "${serverNote.createTime.toString()}"
             }
          }""";
          channel.sink.add(data);
        }
      });
    }
  }
}
