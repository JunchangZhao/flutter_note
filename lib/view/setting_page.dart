import 'package:flutter/material.dart';
import 'package:flutter_app/di/provider.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/model/data/ui/setting_data.dart';
import 'package:flutter_app/view/base_state.dart';
import 'package:flutter_app/viewmodel/setting_vm.dart';
import 'package:flutter_app/widget/dialog_choose.dart';
import 'package:flutter_app/widget/list_behavior.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends BaseState<SettingViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return StreamBuilder<SettingData>(
      stream: viewModel.outDatas,
      builder: (context, snapShot) {
        if (snapShot.data == null) {
          return Container();
        }
        SettingData settingData = snapShot.data;
        return Column(
          children: <Widget>[
            Expanded(
              child: ScrollConfiguration(
                behavior: ListBehavior(),
                child: ListView(
                  children: <Widget>[
                    buildSortItem(settingData.sortList, settingData.sortInde),
                    buildCompressItem(settingData.isCompress),
                    buildFontItem(settingData.fontList, settingData.fontIndex),
                    buildUploadNoteItem(settingData.isAutoUpload),
                    buildVersionItem(settingData.versionCode),
                  ],
                ),
              ),
            ),
            Divider(),
            buildLogoutItem(S.of(context).logout, showLogoutDialog)
          ],
        );
      },
    );
  }

  Widget buildSortItem(List sortList, int sortIndex) {
    return buildItem(S.of(context).sort, sortList[sortIndex], () {
      DialogChoose.showSortChooseDialg(context, sortList, (index) {
        viewModel.chooseSortMode(index);
      });
    });
  }

  Widget buildFontItem(List fontList, int fontIndex) {
    return buildItem(S.of(context).font_size, fontList[fontIndex], () {
      DialogChoose.showSortChooseDialg(context, fontList, (index) {
        viewModel.chooseFontMode(index);
      });
    });
  }

  Widget buildCompressItem(bool isCompress) {
    return buildSwitchItem(S.of(context).compress_note_item, isCompress,
        (flag) {
      viewModel.chooseCompressMode(flag);
    });
  }

  Widget buildUploadNoteItem(isAutoUpload) {
    return buildSwitchItem(S.of(context).auto_upload_notes, isAutoUpload,
        (flag) async {
      viewModel.chooseUploadMode(flag);
    });
  }

  Widget buildSwitchItem(String title, bool flag, Function onItemChanged) {
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

  Widget buildVersionItem(String version) {
    return buildItem(S.of(context).version, version, () {});
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

  showLogoutDialog() {
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
                  viewModel.logout();
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

  @override
  provideViewModel() {
    return provideSettingViewModel(context);
  }
}
