import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/utils/sputils.dart';
import 'package:flutter_app/view/home_page.dart';
import 'package:flutter_app/view/login_page.dart';
import 'package:flutter_app/view/splash_page.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        onGenerateTitle: (context) {
          // 此处
          return S.of(context).app_name;
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashPage(),
        routes: {
          '/MainPage': (ctx) => MyHomePage(),
          '/LoginPage': (ctx) => LoginPage(),
        },
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}
