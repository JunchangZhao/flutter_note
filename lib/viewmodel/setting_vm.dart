import 'package:flutter_app/model/data/ui/setting_data.dart';
import 'package:flutter_app/viewmodel/base_vm.dart';

abstract class SettingViewModel extends BaseViewModel<SettingData> {
  void chooseSortMode(index);

  void chooseFontMode(index);

  void chooseCompressMode(bool isCompress);

  void chooseUploadMode(isAutoUpload);

  void logout();
}
