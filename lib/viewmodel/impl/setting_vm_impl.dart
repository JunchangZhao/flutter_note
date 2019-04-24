import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/event.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/data/setting_data.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/viewmodel/setting_vm.dart';
import 'package:package_info/package_info.dart';

class SettingViewModelImpl implements SettingViewModel {
  BuildContext context;
  SettingData _settingData = SettingData();

  SettingViewModelImpl(this.context);

  var _settingController = StreamController<SettingData>.broadcast();

  @override
  initSettingDatas() async {
    _settingData.isAutoUpload = await SPKeys.AUTO_UPLOAD.getBoolean();
    _settingData.sortInde = await SPKeys.SETTING_SORT.getInt();
    _settingData.fontIndex = await SPKeys.SETTING_FONT_SIZE.getInt();
    var platform = await PackageInfo.fromPlatform();
    _settingData.versionCode = platform.version;
    _settingData.isCompress = await SPKeys.COMPRESS_ITEM.getBoolean();
    _settingData.sortList = [
      S.of(this.context).modify_time,
      S.of(this.context).create_time,
      S.of(this.context).title
    ];
    _settingData.fontList = [
      S.of(this.context).small,
      S.of(this.context).normal,
      S.of(this.context).large
    ];
    _settingController.add(_settingData);
  }

  @override
  Stream<SettingData> get outSettingData =>
      _settingController.stream.map((data) {
        return data;
      });

  @override
  void dispose() {
    _settingController.close();
  }

  @override
  Future chooseSortMode(index) async {
    await SPKeys.SETTING_SORT.set(index);
    _settingData.sortInde = index;
    eventBus.fire(SortChangeEvent());
    _settingController.add(_settingData);
  }

  @override
  Future chooseFontMode(index) async {
    await SPKeys.SETTING_FONT_SIZE.set(index);
    _settingData.fontIndex = index;
    eventBus.fire(FontChangeEvent(index));
    _settingController.add(_settingData);
  }

  @override
  Future chooseCompressMode(bool isCompress) async {
    await SPKeys.COMPRESS_ITEM.set(isCompress);
    eventBus.fire(CompressEvent(isCompress));
    _settingData.isCompress = isCompress;
    _settingController.add(_settingData);
  }

  @override
  Future chooseUploadMode(flag) async {
    await SPKeys.AUTO_UPLOAD.set(flag);
    _settingData.isAutoUpload = flag;
    _settingController.add(_settingData);
  }
}
