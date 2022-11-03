

import 'package:flutter/material.dart';

import 'app_state.dart';

class CustomBackButtonDispatcher extends RootBackButtonDispatcher {
  final AppState appState;

  CustomBackButtonDispatcher(this.appState) : super();

  @override
  Future<bool> didPopRoute() async {
    appState.moveToBackScreen();
    return true;
  }
}
