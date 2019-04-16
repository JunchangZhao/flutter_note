import 'package:flutter/material.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/view/home_page.dart';
import 'package:flutter_app/view/login_page.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    SPKeys.ACCOUNT_NAME.getString().then((value) {
      if (value == null || value.isEmpty) {
        Navigator.pop(context);
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        Navigator.pop(context);
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => MyHomePage(title: 'Flutter Note')));
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
