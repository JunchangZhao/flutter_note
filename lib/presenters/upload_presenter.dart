import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class UploadPresenter {
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('ws://echo.websocket.org');
}
