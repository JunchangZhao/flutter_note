import 'package:dio/dio.dart';
import 'package:flutter_app/model/net/login_result.dart';
import 'package:flutter_app/model/net/register_result.dart';
import 'package:flutter_app/utils/netutils.dart';
import 'package:flutter_app/utils/sputils.dart';

class AccountPresenter {
  Future<LoginResult> login(String email, String pwd) async {
    Response response = await NetUtils.getInstance()
        .postHttp("/login", {"email": email, "passwd": pwd});
    LoginResult result = LoginResult.fromJson(response.data);
    return result;
  }

  Future<RegisterResult> register(String email, String pwd) async {
    Response response = await NetUtils.getInstance()
        .postHttp("/register", {"email": email, "passwd": pwd});
    RegisterResult result = RegisterResult.fromJson(response.data);
    return result;
  }

  Future logout() async {
    await SPKeys.JWT.set("");
    await SPKeys.ACCOUNT_NAME.set("");
  }
}
