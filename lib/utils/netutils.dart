import 'package:dio/dio.dart';
import 'package:flutter_app/model/net/deviceInfo.dart';

class NetUtils{
  static String service = "http://10.64.20.49:3000";
  static Dio dio;

  static NetUtils getInstance(){
    if(dio == null){
      dio = new Dio();
      dio.options.baseUrl = service;
      dio.options.connectTimeout = 5000;
      dio.options.receiveTimeout = 3000;
    }
    return new NetUtils();
  }


  Future<Response> getHttp(String url,Map<String, dynamic> parameters) async {
    try {
      Response response = await dio.get(url, queryParameters: parameters);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<Response> postHttp(String url,Map<String, dynamic> parameters) async {
    try {
      Response response = await dio.post(url, data: parameters);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<AllDeviceInfo> getAllDevices() async {
      String url = "/get_all_deviceIds";
      Response response = await getHttp(url, {});
      AllDeviceInfo all = AllDeviceInfo.fromJson(response.data);
      return all;
  }

}