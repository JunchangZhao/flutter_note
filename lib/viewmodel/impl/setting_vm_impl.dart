import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:flutter_app/common/event.dart';
import 'package:flutter_app/di/provider.dart';
import 'package:flutter_app/model/account_model.dart';
import 'package:flutter_app/model/data/ui/setting_data.dart';
import 'package:flutter_app/model/setting_model.dart';
import 'package:flutter_app/viewmodel/setting_vm.dart';

class SettingViewModelImpl extends SettingViewModel {
  BuildContext context;
  SettingData _settingData = SettingData();
  AccountModel _accountModel;
  SettingModel _settingModel;

  SettingViewModelImpl(this.context);

  @override
  initDatas() async {
    _accountModel = provideAccountModel(context);
    _settingModel = provideSettingModel(context);
    _settingData = await _settingModel.getSettingData();
    streamController.add(_settingData);
  }

  @override
  Future chooseSortMode(index) async {
    await _settingModel.setSort(index);
    _settingData.sortInde = index;
    eventBus.fire(SortChangeEvent());
    streamController.add(_settingData);
    globalSettingData = _settingData;
  }

  @override
  Future chooseFontMode(index) async {
    await _settingModel.setFont(index);
    _settingData.fontIndex = index;
    eventBus.fire(FontChangeEvent(index));
    streamController.add(_settingData);
    globalSettingData = _settingData;
  }

  @override
  Future chooseCompressMode(bool isCompress) async {
    await _settingModel.setCompress(isCompress);
    eventBus.fire(CompressEvent(isCompress));
    _settingData.isCompress = isCompress;
    streamController.add(_settingData);
    globalSettingData = _settingData;
  }

  @override
  Future chooseUploadMode(flag) async {
    await _settingModel.setAutoUpload(flag);
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
