import 'package:flutter/material.dart';
import 'package:flutter_app/view/home_page.dart';
import 'package:oktoast/oktoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Note',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _gotoNext(),
      ),
    );
  }

  _gotoNext() {
    return MyHomePage(title: 'Flutter Note');
  }
}

