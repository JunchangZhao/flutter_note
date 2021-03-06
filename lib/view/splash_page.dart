import 'package:flutter/material.dart';
import 'package:flutter_app/di/provider.dart';
import 'package:flutter_app/viewmodel/splash_vm.dart';
import 'package:flutter_svg/svg.dart';

class _SplashPageState extends State<SplashPage> {
  SplashViewModel splashViewModel;

  @override
  void initState() {
    splashViewModel = provideSplashViewModel(context);
    splashViewModel.gotoNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          width: 68,
          height: 68,
          child: SvgPicture.asset(
            "icons/notebook.svg",
          ),
        ),
      ),
      color: Colors.blue,
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}
