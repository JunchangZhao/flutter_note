import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/account_model.dart';
import 'package:flutter_app/model/data/net/restful/register_result.dart';
import 'package:flutter_app/widget/loading_dialog.dart';
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
  AccountModel _accountModel;

  @override
  void initState() {
    _accountModel = AccountModel(context);
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
            Text(S.of(context).already_register),
            GestureDetector(
              child: Text(
                S.of(context).login,
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
            S.of(context).register,
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.blue,
          onPressed: () {
            if (_formKey.currentState.validate()) {
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
          return S.of(context).input_password;
        }
      },
      decoration: InputDecoration(
        labelText: S.of(context).password,
      ),
    );
  }

  TextFormField buildConfirmTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _confirmPasswd = value,
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return S.of(context).input_passwd_again;
        }
      },
      decoration: InputDecoration(
        labelText: S.of(context).password,
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
        S.of(context).register,
        style: TextStyle(fontSize: 42.0, color: Colors.blue),
      ),
    );
  }

  void register() {
    if (_password != _confirmPasswd) {
      showToast(
        S.of(context).password_inconsistency,
        textPadding: EdgeInsets.all(12),
        position: ToastPosition.bottom,
      );
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return LoadingDialog(
            requestCallBack: _register(),
            outsideDismiss: false,
            loadingText: S.of(context).register,
          );
        });
  }

  Future _register() async {
    RegisterResult result = await _accountModel.register(_email, _password);
    if (result != null && result.isSuccess) {
      if (result.data.isSuccess) {
        showToast(
          S.of(context).register_success,
          position: ToastPosition.bottom,
          textPadding: EdgeInsets.all(12),
        );
        Timer.periodic(Duration(seconds: 1), (timer) {
          Navigator.pop(context);
        });
      } else {
        if (!result.data.isAccountNotDuplicate) {
          showToast(
            S.of(context).the_email_has_been_registed,
            position: ToastPosition.bottom,
            textPadding: EdgeInsets.all(12),
          );
        } else if (!result.data.isAccountValid) {
          showToast(
            S.of(context).email_is_invalid,
            textPadding: EdgeInsets.all(12),
            position: ToastPosition.bottom,
          );
        } else if (result.data.isPasswdValid) {
          showToast(
            S.of(context).password_is_invalid,
            textPadding: EdgeInsets.all(12),
            position: ToastPosition.bottom,
          );
        }
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
