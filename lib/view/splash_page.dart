import 'package:flutter/material.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:flutter_app/presenters/note_presenter.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_svg/svg.dart';

class _SplashPageState extends State<SplashPage> {
  NotePresenter notePresenter = NotePresenter();

  @override
  void initState() {
    SPKeys.ACCOUNT_NAME.getString().then((value) {
      if (value == null || value.isEmpty) {
        Navigator.of(context).pushReplacementNamed('/LoginPage');
      } else {
        initDatas().then((value) {
          Navigator.of(context).pushReplacementNamed('/MainPage');
        });
      }
    });
    super.initState();
  }

  Future initDatas() async {
    homePageNoteList = await notePresenter.getAllNotes(context, false);
    jwt = await SPKeys.JWT.getString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          width: 68,
          height: 68,
          child: SvgPicture.asset(
            "icons/notebook.svg",
          ),
        ),
      ),
      color: Colors.blue,
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}
