import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:flutter_app/dao/note_dao.dart';
import 'package:flutter_app/model/data/ui/setting_data.dart';
import 'package:flutter_app/model/note_model.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/viewmodel/splash_vm.dart';

class SplashViewModelImpl implements SplashViewModel {
  BuildContext context;
  NoteModel _noteModel = NoteModel();

  SplashViewModelImpl(this.context);

  @override
  gotoNextPage() {
    SPKeys.ACCOUNT_NAME.getString().then((value) {
      if (value == null || value.isEmpty) {
        Navigator.of(context).pushReplacementNamed('/LoginPage');
      } else {
        initDatas().then((value) {
          Navigator.of(context).pushReplacementNamed('/MainPage');
        });
      }
    });
  }

  Future initDatas() async {
    homePageNoteList = await _noteModel.getAllNotes(context, NoteDao.TYPE_NORMAL);
    jwt = await SPKeys.JWT.getString();
    globalSettingData = SettingData();
    globalSettingData.isCompress = await SPKeys.COMPRESS_ITEM.getBoolean();
    globalSettingData.isAutoUpload = await SPKeys.AUTO_UPLOAD.getBoolean();
    globalSettingData.fontIndex = await SPKeys.SETTING_FONT_SIZE.getInt();
    globalSettingData.sortInde = await SPKeys.SETTING_SORT.getInt();
  }
}
