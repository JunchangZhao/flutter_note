import 'package:flutter/material.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/view/home_page.dart';
import 'package:flutter_app/widget/list_behavior.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oktoast/oktoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _confirmPasswd;
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
                      "icons/register.svg",
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  buildEmailTextField(),
                  SizedBox(height: 15.0),
                  buildPasswordTextField(context),
                  SizedBox(height: 15.0),
                  buildConfirmTextField(context),
                  SizedBox(height: 60.0),
                  buildRegisterButton(context),
                  SizedBox(height: 20.0),
                  buildRegisterText(context),
                ],
              ),
            )));
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('已有账号? '),
            GestureDetector(
              child: Text(
                '登陆',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Align buildRegisterButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            'Register',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.blue,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              register();
            }
          },
          shape: StadiumBorder(
            side: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
        labelText: 'Password',
      ),
    );
  }

  TextFormField buildConfirmTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _confirmPasswd = value,
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return '请子再次输入密码';
        }
      },
      decoration: InputDecoration(
        labelText: 'Password',
      ),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Emall Address',
      ),
      validator: (String value) {
        var emailReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        if (!emailReg.hasMatch(value)) {
          return '请输入正确的邮箱地址';
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
        'Register',
        style: TextStyle(fontSize: 42.0, color: Colors.blue),
      ),
    );
  }

  void register() {
    if (_password != _confirmPasswd) {
      showToast(
        "密码不一致，请确认！",
        textPadding: EdgeInsets.all(12),
        position: ToastPosition.bottom,
      );
      return;
    }

    print("jack");
  }
}
