import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/app_theme.dart';
import '../../../../core/utils/validators/form_validator.dart';
import '../../../../core/widgets/custom/continue_button.dart';
import '../../../../core/widgets/custom/custom_form_field.dart';
import '../auth_view_model/authentication_view_model.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final AuthViewModel _authProvider = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _authProvider, child: LoginScreenContent());
  }
}


class LoginScreenContent extends StatefulWidget {
  const LoginScreenContent({Key? key}) : super(key: key);

  @override
  State<LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<LoginScreenContent> {
  final AuthViewModel authProvider = sl();

  @override
  void initState() {
    // authProvider.loginEmailController.clear();
    // authProvider.loginPasswordController.clear();
    super.initState();
  }
  Widget showBottomSheet() {
    return BottomSheet(
      enableDrag: false,
      backgroundColor: Colors.transparent,
      onClosing: () {},
      builder: (context) {
        return Container(
          height: 350.h,
          width: double.infinity,

          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),

              )),
          child: Form(
            key: context.read<AuthViewModel>().loginFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 350.h,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    // mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                       Text('  Email',style: AppTheme.appTheme.textTheme.subtitle2,),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 10),
                        child: CustomTextFormField(
                          maxLines: 1,
                          controller:
                              context.read<AuthViewModel>().loginEmailController,
                          prefixIconPath: AppAssets.icEmailSvg,
                          validator: FormValidators.validateEmail,
                          contentPadding:
                              const EdgeInsets.symmetric( horizontal: 5),
                          focusNode: context.read<AuthViewModel>().loginEmailFocusNode,
                          onChanged: context.read<AuthViewModel>().onEmailChange,
                          onFieldSubmitted: (_) => context
                              .read<AuthViewModel>()
                              .onLoginEmailSubmitted(context),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                       Text('  Password',style: AppTheme.appTheme.textTheme.subtitle2,),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ValueListenableBuilder<bool>(
                          valueListenable:
                              context.read<AuthViewModel>().obsecureLoginTextNotifier,
                          builder: (_, obsecureText, __) {
                            return CustomTextFormField(
                              controller: context
                                  .read<AuthViewModel>()
                                  .loginPasswordController,
                              prefixIconPath: AppAssets.icLockSvg,
                              obscureText: obsecureText,
                              suffixIconPath: obsecureText
                                  ? AppAssets.icEyeOpenSvg
                                  : AppAssets.icEyeCloseSvg,
                              suffixIconOnTap:
                                  context.read<AuthViewModel>().onObsecureChangeLogin,
                              maxLines: 1,
                              validator: FormValidators.validatePassword,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              onFieldSubmitted: (_) => context
                                  .read<AuthViewModel>()
                                  .onLoginPasswordSubmitted(context),
                              onChanged:
                                  context.read<AuthViewModel>().onPasswordChange,
                              focusNode:
                                  context.read<AuthViewModel>().loginPasswordFocusNode,
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            context.read<AuthViewModel>().moveToForgetPasswordEmail();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ContinueButton(
                          loadingNotifier:
                              context.read<AuthViewModel>().isLoginLoadingNotifier,
                          text: 'Login',
                          // backgroundColor: Theme.of(context).primaryColor,
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();

                            context.read<AuthViewModel>().isLoginButtonPressed =
                                true;

                            if (!context
                                .read<AuthViewModel>()
                                .loginFormKey
                                .currentState!
                                .validate()) {
                              return;
                            }
                            await context.read<AuthViewModel>().login();
                          }),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('don\'t have account?',
                              style: Theme.of(context).textTheme.subtitle2?.copyWith(color:Colors.grey)),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<AuthViewModel>()
                                  .moveToRegisterScreen();
                            },
                            child: Text(' Register now',
                                style: Theme.of(context).textTheme.subtitle1?.copyWith(color: AppTheme.appTheme.primaryColor,)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // backgroundColor: scafoldBackgroundColor,
      body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.loginImagePNG),
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
          // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              showBottomSheet(),
            ],
          )),
    );
  }
}
