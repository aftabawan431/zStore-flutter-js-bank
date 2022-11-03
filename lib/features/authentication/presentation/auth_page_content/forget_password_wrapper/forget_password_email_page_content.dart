import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/widgets/custom/custom_app_bar.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/theme/app_theme.dart';
import '../../../../../core/utils/validators/form_validator.dart';
import '../../../../../core/widgets/custom/continue_button.dart';
import '../../../../../core/widgets/custom/custom_form_field.dart';
import '../../auth_view_model/authentication_view_model.dart';

class ForgetEnterEmailPage extends StatelessWidget {
  ForgetEnterEmailPage({Key? key}) : super(key: key);

  AuthViewModel _authProvider = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _authProvider, child: ForgetEnterEmailScreenContent());
  }
}

class ForgetEnterEmailScreenContent extends StatefulWidget {
  ForgetEnterEmailScreenContent({Key? key}) : super(key: key);

  @override
  State<ForgetEnterEmailScreenContent> createState() => _ForgetEnterEmailScreenContentState();
}

class _ForgetEnterEmailScreenContentState extends State<ForgetEnterEmailScreenContent> {
  AuthViewModel authProvider = sl();
  @override
  void initState() {
    authProvider.forgetEmailController.clear();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar( title: 'Password Recovery',color: kCyanColor,),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.backgroundImagePNG),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: context.read<AuthViewModel>().forgetEmailFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Forgot Password',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(fontSize: 30.h),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'You will receive a link to your email',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontSize: 16.h, color: Colors.black54),
                            ),
                            Text(
                              'to create your new password',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontSize: 16.h, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Text(
                        '  Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextFormField(
                        maxLines: 1,
                        controller:
                        context.read<AuthViewModel>().forgetEmailController,
                        validator: FormValidators.validateEmail,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        focusNode:
                            context.read<AuthViewModel>().forgetEmailFocusNode,
                        onChanged: context.read<AuthViewModel>().onEmailChange,
                        onFieldSubmitted: (_) => context
                            .read<AuthViewModel>()
                            .onForgotEmailSubmitted(context),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ContinueButton(
                          loadingNotifier: context
                              .read<AuthViewModel>()
                              .isEmailLoadingNotifier,
                          text: 'Send',
                          backgroundColor: AppTheme.appTheme.primaryColor,
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            authProvider.isForgotEmailButtonPressed = true;
                            if (!context
                                .read<AuthViewModel>()
                                .forgetEmailFormKey
                                .currentState!
                                .validate()) {
                              return;
                            }
                            // authProvider.moveToOtpScreen();
                            await authProvider.forgotPasswordEmail();
                          }),
                    ],
                  ),
                ),
              ),

              // ContinueButton(
              //     loadingNotifier: context.read<LoginProvider>().loginLoading,
              //     text: 'Login'.tr(),
              //     onPressed: () async {
              //       FocusManager.instance.primaryFocus?.unfocus();
              //       final token = await PushNotifcationService().getToken();
              //       if (_key.currentState!.validate()) {
              //         context
              //             .read<LoginProvider>()
              //             .loginUser(LoginRequestModel(email: emailController.text.toLowerCase().trim(), password: passwordController.text, fcmtoken: token!));
              //       }
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
