import 'package:flutter/material.dart';
import 'package:flutter_app/common/HomePageDatas.dart';
import 'package:flutter_app/presenters/note_presenter.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/view/home_page.dart';
import 'package:flutter_app/view/login_page.dart';
import 'package:flutter_svg/svg.dart';

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    SPKeys.ACCOUNT_NAME.getString().then((value) {
      if (value == null || value.isEmpty) {
        Navigator.of(context).pushReplacementNamed('/LoginPage');
      } else {
        NotePresenter.getAllNotes(context, false).then((list) {
          homePageNoteList = list;
          Navigator.of(context).pushReplacementNamed('/MainPage');
        });
      }
    });
    super.initState();
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
