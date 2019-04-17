import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/view/home_page.dart';
import 'package:flutter_app/widget/list_behavior.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oktoast/oktoast.dart';

class ForgetPasswdPage extends StatefulWidget {
  @override
  _ForgetPasswdPageState createState() => _ForgetPasswdPageState();
}

class _ForgetPasswdPageState extends State<ForgetPasswdPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  Color _eyeColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: ScrollConfiguration(
              behavior: ListBehavior(),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                children: <Widget>[
                  SizedBox(
                    height: kToolbarHeight,
                  ),
                  buildTitle(),
                  buildTitleLine(),
                  SizedBox(height: 40.0),
                  SizedBox(
                    height: 100.0,
                    width: 100,
                    child: SvgPicture.asset(
                      "icons/forget_passwd.svg",
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  buildEmailTextField(),
                  SizedBox(height: 60.0),
                  buildGetPasswdButton(context),
                  SizedBox(height: 20.0),
                ],
              ),
            )));
  }

  Align buildGetPasswdButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            S.of(context).retrieve_password,
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.blue,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              getPasswd();
            }
          },
          shape: StadiumBorder(
            side: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: S.of(context).emall_address,
      ),
      validator: (String value) {
        var emailReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        if (!emailReg.hasMatch(value)) {
          return S.of(context).email_err;
        }
      },
      onSaved: (String value) => _email = value,
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.blue,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        S.of(context).retrieve_password,
        style: TextStyle(fontSize: 30.0, color: Colors.blue),
      ),
    );
  }

  void getPasswd() {
    print(_email);
  }
}
