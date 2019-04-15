import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.lightBlue,
            height: 160,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: SvgPicture.asset(
                      "icons/notebook.svg",
                    ),
                  ),
                ),
                Text(
                  "Fltter Note",
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.delete,
              color: Colors.blue,
            ),
            title: Text(
              "Go to Trash",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            title: Text(
              "Settings",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
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
                      "13218019903",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
