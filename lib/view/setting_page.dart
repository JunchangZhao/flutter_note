import 'package:flutter/material.dart';
import 'package:flutter_app/common/Event.dart';
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
  String _font = "";

  AccountPresenter accountPresenter;
  SettingPresenter settingPresenter;

  List _sortList;
  List _fontList;

  @override
  void initState() {
    super.initState();
    accountPresenter = AccountPresenter(context);
    settingPresenter = SettingPresenter(context);

    SPKeys.SETTING_SORT.getInt().then((value) {
      this._sortList = [
        S.of(context).modify_time,
        S.of(context).create_time,
        S.of(context).title
      ];
      setState(() {
        this._sort = _sortList[value];
      });
    });

    SPKeys.SETTING_FONT_SIZE.getInt().then((value) {
      this._fontList = [
        S.of(context).small,
        S.of(context).normal,
        S.of(context).large
      ];
      setState(() {
        this._font = this._fontList[value];
      });
    });
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
                buildFontItem(),
//                buildVersionItem(),
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
    return buildItem(S.of(context).sort, this._sort, () {
      DialogChoose.showSortChooseDialg(context, this._sortList, (index) {
        SPKeys.SETTING_SORT.set(index);
        setState(() {
          this._sort = this._sortList[index];
        });
        eventBus.fire(SortChangeEvent());
      });
    });
  }

  buildFontItem() {
    return buildItem(S.of(context).font_size, this._font, () {
      DialogChoose.showSortChooseDialg(context, this._fontList, (index) {
        SPKeys.SETTING_FONT_SIZE.set(index);
        setState(() {
          this._font = this._fontList[index];
        });
        eventBus.fire(FontChangeEvent(index));
      });
    });
  }

  buildVersionItem() {
    buildItem(S.of(context).version, "1.0", () {});
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
