import 'package:dio/dio.dart';
import 'package:flutter_app/config/network_config.dart';

class NetUtils {
  static Dio dio;

  static NetUtils getInstance() {
    if (dio == null) {
      dio = new Dio();
      dio.options.baseUrl = NetWorkConfig.SERVER_ADDRESS;
      dio.options.connectTimeout = NetWorkConfig.CONNECT_TIMEOUT;
      dio.options.receiveTimeout = NetWorkConfig.RECEIVE_TIMEOUT;
    }
    return new NetUtils();
  }

  Future<Response> getHttp(String url, Map<String, dynamic> parameters) async {
    try {
      Response response = await dio.get(url, queryParameters: parameters);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<Response> postHttp(String url, Map<String, dynamic> parameters) async {
    try {
      Response response = await dio.post(url, data: parameters);
      return response;
    } catch (e) {
      return null;
    }
  }

}
