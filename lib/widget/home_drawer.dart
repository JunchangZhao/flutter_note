import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          ListTile(
            leading: Icon(
              Icons.delete,
              color: Colors.blue,
            ),
            title: Text("Go to Trash"),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
