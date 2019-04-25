import 'package:flutter_app/model/data/setting_data.dart';
import 'package:flutter_app/viewmodel/base_vm.dart';

abstract class SettingViewModel extends BaseViewModel{
  Stream<SettingData> get outSettingData;

  void chooseSortMode(index);

  void chooseFontMode(index);

  void chooseCompressMode(bool isCompress);

  void chooseUploadMode(isAutoUpload);

  void logout();
}
