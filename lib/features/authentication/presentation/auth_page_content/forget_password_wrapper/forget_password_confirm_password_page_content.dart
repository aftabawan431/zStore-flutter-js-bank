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

class ForgetConfirmPasswordPage extends StatelessWidget {
  ForgetConfirmPasswordPage({Key? key}) : super(key: key);

  AuthViewModel _authProvider = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: _authProvider, child: ForgetConfirmPasswordScreenContent());
  }
}

class ForgetConfirmPasswordScreenContent extends StatelessWidget {
  ForgetConfirmPasswordScreenContent({Key? key}) : super(key: key);

  AuthViewModel authProvider = sl();

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
                key: context.read<AuthViewModel>().forgetConfirmPasswordFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Create New Password',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(fontSize: 30.h),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'In order to create your new password,',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(fontSize: 16.h,color: Colors.black54),
                            ),
                            Text(
                              'please add new one to confirm.',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(fontSize: 16.h,color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Text(
                        '  Password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: context.read<AuthViewModel>().obsecurePasswordTextNotifier,
                        builder: (_, obsecureText, __) {
                          return CustomTextFormField(
                            controller: authProvider.forgetPasswordController,

                            obscureText: obsecureText,
                            suffixIconPath: obsecureText ? AppAssets.icEyeOpenSvg : AppAssets.icEyeCloseSvg,
                            suffixIconOnTap: context.read<AuthViewModel>().onObsecurePasswordChange,
                            maxLines: 1,
                            validator: FormValidators.validatePassword,
                            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            onFieldSubmitted: (_) => context.read<AuthViewModel>().onLoginPasswordSubmitted(context),
                            // onChanged: context.read<AuthProvider>().onForgetPasswordChange,
                            focusNode: context.read<AuthViewModel>().forgotPasswordFocusNode,
                          );
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const Text(
                        '  Change Password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: context.read<AuthViewModel>().obsecureConfirmPasswordTextNotifier,
                        builder: (_, obsecureText, __) {
                          return CustomTextFormField(
                            controller: authProvider.confirmPasswordController,

                            obscureText: obsecureText,
                            suffixIconPath: obsecureText ? AppAssets.icEyeOpenSvg : AppAssets.icEyeCloseSvg,
                            suffixIconOnTap: context.read<AuthViewModel>().onObsecureConfirmPasswordChange,
                            maxLines: 1,
                            validator: authProvider.validateConfirmPassword,
                            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            onFieldSubmitted: (_) => context.read<AuthViewModel>().onLoginPasswordSubmitted(context),
                            onChanged: context.read<AuthViewModel>().onConfirmPasswordChange,
                            focusNode: context.read<AuthViewModel>().confirmPasswordFocusNode,
                          );
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ContinueButton(
                          loadingNotifier:
                          context.read<AuthViewModel>().confirmPasswordLoadingTextNotifier,
                          text: 'Submit',
                          backgroundColor: AppTheme.appTheme.primaryColor,
                          onPressed: () async {
                            print('aftab');
                            FocusManager.instance.primaryFocus?.unfocus();
                            authProvider.isConfirmPasswordButtonPressed = true;
                            if (!context
                                .read<AuthViewModel>()
                                .forgetConfirmPasswordFormKey
                                .currentState!
                                .validate()) {
                              return;
                            }
                            context.read<AuthViewModel>().updatePassword();

                          }),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );  }


// goToNext() {
//   AppState appState = GetIt.I.get<AppState>();
//   appState.currentAction = PageAction(
//       // state: PageState.addPage, page: PageConfigs.securityQuestionPageConfig);
// }
}
