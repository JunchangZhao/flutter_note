import 'package:flutter/material.dart';
import 'package:flutter_app/widget/list_behavior.dart';

class DialogChoose {
  static showSortChooseDialg(
      BuildContext context, List titles, Function onChoosed) {
    showModalBottomSheet(
        context: context,
        builder: (build) {
          return Container(
              height: 52.0 * titles.length,
              color: Colors.white,
              child: ScrollConfiguration(
                behavior: ListBehavior(),
                child: ListView.builder(
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: GestureDetector(
                              onTap: () {
                                onChoosed(index);
                                Navigator.pop(context);
                              },
                              child: ListTile(
                                dense: true,
                                title: Text(
                                  titles[index],
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 2,
                          ),
                        ],
                      );
                    }),
              ));
        });
  }
}
