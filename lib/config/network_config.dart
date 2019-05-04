class NetWorkConfig {
  static String ip = "192.168.2.101";
  static String SERVER_ADDRESS = "http://$ip:3000";
  static String WEBSOCKET_ADDRESS = "ws://$ip:3000/note/socket";
  static int CONNECT_TIMEOUT = 10 * 1000;
  static int RECEIVE_TIMEOUT = 5 * 1000;

  static String GET_ALL_NOTES = "get_all_notes";
}
