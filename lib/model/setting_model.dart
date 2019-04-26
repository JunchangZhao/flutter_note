import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/data/ui/setting_data.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:package_info/package_info.dart';

class SettingModel {
  BuildContext context;

  SettingModel(context) {
    this.context = context;
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

  setSort(index) async {
    await SPKeys.SETTING_SORT.set(index);
  }

  setFont(index) async {
    await SPKeys.SETTING_FONT_SIZE.set(index);
  }

  setCompress(bool flag) async {
    await SPKeys.COMPRESS_ITEM.set(flag);
  }

  setAutoUpload(bool flag) async {
    await SPKeys.AUTO_UPLOAD.set(flag);
  }
}
