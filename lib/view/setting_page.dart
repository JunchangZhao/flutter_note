import 'package:flutter/material.dart';
import 'package:flutter_app/presenters/account_presenter.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AccountPresenter accountPresenter;

  @override
  void initState() {
    accountPresenter = AccountPresenter(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(),
        ),
        Divider(),
        GestureDetector(
          onTap: logout,
          child: ListTile(
            title: Center(
              child: Text(
                "Logout",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        )
      ],
    );
  }

  logout() {
    accountPresenter.logout().then((value) {
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed('/LoginPage');
    });
  }
}
