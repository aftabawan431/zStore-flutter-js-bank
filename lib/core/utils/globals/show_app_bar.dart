import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'globals.dart';

class ShowSnackBar {
  static show(String text,{Color? color}) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      backgroundColor:color!=null?color:AppTheme.appTheme.primaryColor,
      duration: const Duration(milliseconds: 1300),
    );
    snackbarKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
