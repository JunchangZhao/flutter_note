import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:flutter_app/config/network_config.dart';
import 'package:flutter_app/model/data/net/websocket/send_data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

class UploadModel {
  static WebSocketChannel channel;

  BuildContext context;

  UploadModel(BuildContext context, Function onListen) {
    this.context = context;

    channel = IOWebSocketChannel.connect(
      NetWorkConfig.WEBSOCKET_ADDRESS,
      headers: {"Authorization": "Bearer $jwt"},
    );
    channel.stream.listen((data) {
      onListen(data);
    });
  }

  getAllNotes() {
    var data = SendData(NetWorkConfig.GET_ALL_NOTES, null);
    sendData(data);
  }

  sendData(data) {
    channel.sink.add(json.encode(data));
  }

  closeConnection() {
    channel.sink.close();
  }
}
