import 'package:flutter/material.dart';
import 'package:flutter_app/common/common_datas.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeDrawer extends StatelessWidget {
  var _accountName;
  Function _onSettingClick;
  Function _onTrashClick;

  HomeDrawer(this._accountName, this._onSettingClick, this._onTrashClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildTitle(context),
          buildTrashItem(context),
          Divider(),
          buildSettingItem(context),
          Expanded(
            child: Container(),
          ),
          buldAccoutItem()
        ],
      ),
    );
  }

  Container buldAccoutItem() {
    return Container(
      child: Column(
        children: <Widget>[
          Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: SizedBox(
                width: 60,
                height: 60,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.blue,
                  ),
                ),
              ),
              title: Text(
                this._accountName,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildSettingItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        this._onSettingClick();
      },
      child: ListTile(
        leading: Icon(
          Icons.settings,
          color: Colors.blue,
        ),
        title: Text(
          S.of(context).settings,
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.blue,
        ),
      ),
    );
  }

  GestureDetector buildTrashItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        this._onTrashClick();
      },
      child: ListTile(
        leading: Icon(
          Icons.delete,
          color: Colors.blue,
        ),
        title: Text(
          S.of(context).go_to_trash,
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountEmail: Text(
        S.of(context).app_name,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      currentAccountPicture: SizedBox(
        width: 60,
        height: 60,
        child: SvgPicture.asset(
          "icons/notebook.svg",
        ),
      ),
    );
  }
}
