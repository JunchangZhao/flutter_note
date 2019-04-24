import 'package:flutter_app/model/data/setting_data.dart';

abstract class SettingViewModel {
  void initSettingDatas();

  Stream<SettingData> get outSettingData;

  void chooseSortMode(index);

  void chooseFontMode(index);

  void chooseCompressMode(bool isCompress);

  void chooseUploadMode(isAutoUpload);

  void logout();
}
