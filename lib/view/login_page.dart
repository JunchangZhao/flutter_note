import 'package:flutter/material.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/view/home_page.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      padding: EdgeInsets.only(top: 140),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 80,
              height: 80,
              child: SvgPicture.asset("icons/notebook.svg"),
            ),
          ],
        ),
      ),
    );
  }
}
