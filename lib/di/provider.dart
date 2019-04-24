import 'package:flutter/cupertino.dart';
import 'package:flutter_app/viewmodel/impl/home_vm_impl.dart';
import 'package:flutter_app/viewmodel/impl/setting_vm_impl.dart';
import 'package:flutter_app/viewmodel/impl/splash_vm_impl.dart';

provideHomeViewModel(BuildContext context) {
  return HomeViewModelImpl(context);
}

provideSplashViewModel(BuildContext context) {
  return SplashViewModelImpl(context);
}

provideSettingViewModel(BuildContext context) {
  return SettingViewModelImpl(context);
}
