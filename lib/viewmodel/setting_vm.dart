import 'package:flutter_app/model/data/setting_data.dart';

abstract class SettingViewModel {
  void initSettingDatas();

  Stream<SettingData> get outSettingData;
}
