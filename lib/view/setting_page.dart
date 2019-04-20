import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/presenters/account_presenter.dart';
import 'package:flutter_app/presenters/setting_presenter.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/view/dialog_choose.dart';
import 'package:flutter_app/widget/list_behavior.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _sort = "";

  AccountPresenter accountPresenter;
  SettingPresenter settingPresenter;

  @override
  void initState() {
    accountPresenter = AccountPresenter(context);
    settingPresenter = SettingPresenter(context);
    SPKeys.SETTING_SORT.getString().then((value) {
      if (value == null) {
        value = S.of(context).modify_time;
      }
      setState(() {
        this._sort = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ScrollConfiguration(
            behavior: ListBehavior(),
            child: ListView(
              children: <Widget>[
                buildSortItem(),
              ],
            ),
          ),
        ),
        Divider(),
        buildLogoutItem(S.of(context).logout, logout)
      ],
    );
  }

  Widget buildSortItem() {
    List sortList = [
      S.of(context).modify_time,
      S.of(context).create_time,
      S.of(context).title
    ];
    return buildItem(S.of(context).sort, this._sort, () {
      DialogChoose.showSortChooseDialg(context, sortList, (index) {
        SPKeys.SETTING_SORT.set(sortList[index]);
        setState(() {
          this._sort = sortList[index];
        });
      });
    });
  }

  Widget buildLogoutItem(String title, onClick) {
    return GestureDetector(
      onTap: onClick,
      child: ListTile(
        title: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  logout() {
    accountPresenter.logout().then((value) {
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed('/LoginPage');
    });
  }

  Widget buildItem(String title, String trailing, Function onClick) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
          child: GestureDetector(
            onTap: onClick,
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
              trailing: Text(
                trailing,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
