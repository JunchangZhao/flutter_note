import 'package:flutter/material.dart';
import 'package:flutter_app/viewmodel/base_vm.dart';

abstract class BaseState<T extends BaseViewModel> extends State {
  T viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = provideViewModel();
    viewModel.initDatas();
  }

  T provideViewModel();

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }
}
