import 'package:flutter/material.dart';
import 'package:flutter_app/common/event.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/presenters/account_presenter.dart';
import 'package:flutter_app/presenters/setting_presenter.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/view/dialog_choose.dart';
import 'package:flutter_app/widget/list_behavior.dart';
import 'package:package_info/package_info.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _sort = "";
  String _font = "";
  String _versionCode = "";
  bool _compress = false;
  bool _autoUpload = false;

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

    SPKeys.AUTO_UPLOAD.getBoolean().then((value) {
      setState(() {
        this._autoUpload = value;
      });
    });

    PackageInfo.fromPlatform().then((pkgInfo) {
      setState(() {
        this._versionCode = pkgInfo.version;
      });
    });

    SPKeys.COMPRESS_ITEM.getBoolean().then((value) {
      setState(() {
        this._compress = value;
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
                buildCompressItem(),
                buildFontItem(),
                buildUploadNoteItem(),
                buildVersionItem(),
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

  buildCompressItem() {
    return buildSwitchItem(S.of(context).compress_note_item, this._compress,
        (flag) {
      SPKeys.COMPRESS_ITEM.set(flag);
      eventBus.fire(CompressEvent(flag));
    });
  }

  buildUploadNoteItem() {
    return buildSwitchItem(S.of(context).auto_upload_notes, this._autoUpload,
        (flag) {
      SPKeys.AUTO_UPLOAD.set(flag);
    });
  }

  buildSwitchItem(String title, bool flag, Function onItemChanged) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
          ),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            trailing: Switch(
              value: flag,
              onChanged: (flag) {
                onItemChanged(flag);
              },
            ),
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  buildVersionItem() {
    return buildItem(S.of(context).version, _versionCode, () {});
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
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return AlertDialog(
            content: Text(S.of(context).confirm_logout),
            actions: <Widget>[
              FlatButton(
                child: Text(S.of(context).cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(S.of(context).confirm),
                onPressed: () {
                  Navigator.of(context).pop();
                  accountPresenter.logout().then((value) {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed('/LoginPage');
                  });
                },
              ),
            ],
          );
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
