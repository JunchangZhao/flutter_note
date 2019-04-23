import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class UploadModel {
  static WebSocketChannel channel;

  BuildContext context;

  UploadModel(BuildContext context) {
    this.context = context;

    channel = IOWebSocketChannel.connect(
      'ws://echo.websocket.org',
      headers: {"Authorization": "Bearer $jwt"},
    );
  }







}
