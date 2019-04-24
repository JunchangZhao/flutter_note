import 'package:dio/dio.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/data/net/login_result.dart';
import 'package:flutter_app/model/data/net/register_result.dart';
import 'package:flutter_app/model/data/setting_data.dart';
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


  Future<SettingData> getSettingData() async {
    SettingData settingData = SettingData();
    settingData.isAutoUpload = await SPKeys.AUTO_UPLOAD.getBoolean();
    settingData.sortInde = await SPKeys.SETTING_SORT.getInt();
    settingData.fontIndex = await SPKeys.SETTING_FONT_SIZE.getInt();
    var platform = await PackageInfo.fromPlatform();
    settingData.versionCode = platform.version;
    settingData.isCompress = await SPKeys.COMPRESS_ITEM.getBoolean();
    settingData.sortList = [
      S.of(this.context).modify_time,
      S.of(this.context).create_time,
      S.of(this.context).title
    ];
    settingData.fontList = [
      S.of(this.context).small,
      S.of(this.context).normal,
      S.of(this.context).large
    ];
    return settingData;
  }
}
