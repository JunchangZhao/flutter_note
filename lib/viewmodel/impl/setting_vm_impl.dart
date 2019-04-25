import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:flutter_app/common/event.dart';
import 'package:flutter_app/di/provider.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/account_model.dart';
import 'package:flutter_app/model/data/ui/setting_data.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/viewmodel/setting_vm.dart';
import 'package:package_info/package_info.dart';

class SettingViewModelImpl extends SettingViewModel<SettingData> {
  BuildContext context;
  SettingData _settingData = SettingData();
  AccountModel _accountModel;

  SettingViewModelImpl(this.context);


  @override
  initDatas() async {
    _accountModel = provideAccountModel(context);
    _settingData = await _accountModel.getSettingData();
    streamController.add(_settingData);
  }

  @override
  Future chooseSortMode(index) async {
    await SPKeys.SETTING_SORT.set(index);
    _settingData.sortInde = index;
    eventBus.fire(SortChangeEvent());
    streamController.add(_settingData);
    globalSettingData = _settingData;
  }

  @override
  Future chooseFontMode(index) async {
    await SPKeys.SETTING_FONT_SIZE.set(index);
    _settingData.fontIndex = index;
    eventBus.fire(FontChangeEvent(index));
    streamController.add(_settingData);
    globalSettingData = _settingData;
  }

  @override
  Future chooseCompressMode(bool isCompress) async {
    await SPKeys.COMPRESS_ITEM.set(isCompress);
    eventBus.fire(CompressEvent(isCompress));
    _settingData.isCompress = isCompress;
    streamController.add(_settingData);
    globalSettingData = _settingData;
  }

  @override
  Future chooseUploadMode(flag) async {
    await SPKeys.AUTO_UPLOAD.set(flag);
    _settingData.isAutoUpload = flag;
    streamController.add(_settingData);
    globalSettingData = _settingData;
  }

  @override
  Future logout() async {
    await _accountModel.logout();
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed('/LoginPage');
  }

}
