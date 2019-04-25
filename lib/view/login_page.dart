import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/account_model.dart';
import 'package:flutter_app/model/data/net/login_result.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/view/forget_passwd_page.dart';
import 'package:flutter_app/view/register_page.dart';
import 'package:flutter_app/widget/loading_dialog.dart';
import 'package:flutter_app/widget/list_behavior.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isObscure = true;
  Color _eyeColor;
  AccountModel accountModel;

  @override
  void initState() {
    accountModel = AccountModel(context);
    super.initState();
  }

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
                  SizedBox(height: 25.0),
                  SizedBox(
                    height: 100.0,
                    width: 100,
                    child: SvgPicture.asset(
                      "icons/login.svg",
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 25.0),
                  buildEmailTextField(),
                  SizedBox(height: 20.0),
                  buildPasswordTextField(context),
                  buildForgetPasswordText(context),
                  SizedBox(height: 50.0),
                  buildLoginButton(context),
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
            Text(S.of(context).no_account),
            GestureDetector(
              child: Text(
                S.of(context).top_register,
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => RegisterPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            S.of(context).login,
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.blue,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              login();
            }
          },
          shape: StadiumBorder(
            side: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            S.of(context).forget_passwd,
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => ForgetPasswdPage()));
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return S.of(context).input_passwd;
        }
      },
      decoration: InputDecoration(
          labelText: S.of(context).password,
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
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
        S.of(context).login,
        style: TextStyle(fontSize: 42.0, color: Colors.blue),
      ),
    );
  }

  void login() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return LoadingDialog(
            requestCallBack: _login(),
            outsideDismiss: false,
            loadingText: S.of(context).login,
          );
        });
  }

  Future _login() async {
    LoginResult result = await accountModel.login(_email, _password);
    if (result != null && result.isSuccess) {
      if (result.data.isSuccess) {
        SPKeys.ACCOUNT_NAME.set(_email);
        SPKeys.JWT.set(result.data.jwt);
        await Navigator.pop(context);
        await Navigator.of(context).pushReplacementNamed('/MainPage');
      } else {
        showToast(
          S.of(context).the_account_with_password_was_not_found,
          position: ToastPosition.bottom,
          textPadding: EdgeInsets.all(12),
        );
      }
    } else {
      showToast(
        S.of(context).network_err,
        position: ToastPosition.bottom,
        textPadding: EdgeInsets.all(12),
      );
    }
  }
}
