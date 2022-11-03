
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:zstore_flutter/features/authentication/data/modals/login_response_modal.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/app_state.dart';
import '../../../../core/router/models/page_action.dart';
import '../../../../core/router/models/page_config.dart';
import '../../../../core/utils/enums/page_state_enum.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/widgets/custom/continue_button.dart';
import '../../../authentication/presentation/auth_view_model/authentication_view_model.dart';

class SplashScreenContent extends StatefulWidget {
  const SplashScreenContent({Key? key}) : super(key: key);

  @override
  State<SplashScreenContent> createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<SplashScreenContent> {
  bool loading=true;
  AppState appState = GetIt.I.get<AppState>();
  final AuthViewModel authViewModel = sl();

  goToScreen() async {
    LoginResponseModel? user = await authViewModel.checkIfUserLoggedIn();

    if (user != null) {
      authViewModel.setLoggedInUser(user);

      appState.currentAction = PageAction(
          state: PageState.replace, page: PageConfigs.dashboardPageConfig);
      return;
    }
    setState(() {
      loading=false;
    });
  }


  @override
  void initState() {
    goToScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:loading?const Center(child: CircularProgressIndicator.adaptive(),): Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.splashImagePNG),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ContinueButton(
                text: 'Get Started ',
                onPressed: () async {
                  appState.currentAction = PageAction(
                      state: PageState.replace,
                      page: PageConfigs.loginPageConfig);
                }),
            SizedBox(
              height: 100.h,
            )
          ],
        ),
      ),
    );
  }
}
