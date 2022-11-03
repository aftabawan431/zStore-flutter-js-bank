import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/router/custom_back_button_dispatcher.dart';
import 'core/router/custom_router_delegate.dart';
import 'core/router/custom_router_parser.dart';
import 'core/utils/globals/globals.dart';
import 'core/utils/theme/app_theme.dart';
import 'features/home/presentation/home_view_model/cart_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CustomRouterDelegate delegate;
  late CustomBackButtonDispatcher backButtonDispatcher;
  late CustomRouterParser parser = CustomRouterParser();

  @override
  void initState() {
    delegate = CustomRouterDelegate(sl());
    backButtonDispatcher = CustomBackButtonDispatcher(sl());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    CartProvider cart = sl();

    return ChangeNotifierProvider.value(
      value: cart,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (c, ch) => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Z-Store',
            theme: AppTheme.appTheme,
            scaffoldMessengerKey: snackbarKey,
            routerDelegate: delegate,
            backButtonDispatcher: backButtonDispatcher,
            routeInformationParser: parser,
          ),
        ),
      ),
    );
  }
}
