
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/common_datas.dart';
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
    homePageNoteList = await _noteModel.getAllNotes(context, false);
    jwt = await SPKeys.JWT.getString();
  }
}
