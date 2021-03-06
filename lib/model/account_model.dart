import 'package:dio/dio.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/data/net/restful/login_result.dart';
import 'package:flutter_app/model/data/net/restful/register_result.dart';
import 'package:flutter_app/model/data/ui/setting_data.dart';
import 'package:flutter_app/utils/netutils.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:package_info/package_info.dart';

class AccountModel {
  var context;

  AccountModel(this.context);

  Future<LoginResult> login(String email, String pwd) async {
    Response response = await NetUtils.getInstance()
        .postHttp("/login", {"email": email, "passwd": pwd});
    if (response == null) {
      return LoginResult(false, null, S.of(context).network_err);
    }
    LoginResult result = LoginResult.fromJson(response.data);
    return result;
  }

  Future<RegisterResult> register(String email, String pwd) async {
    Response response = await NetUtils.getInstance()
        .postHttp("/register", {"email": email, "passwd": pwd});
    if (response == null) {
      return RegisterResult(false, null, S.of(context).network_err);
    }
    RegisterResult result = RegisterResult.fromJson(response.data);
    return result;
  }

  Future logout() async {
    await SPKeys.JWT.set("");
    await SPKeys.ACCOUNT_NAME.set("");
  }


}
