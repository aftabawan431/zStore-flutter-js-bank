import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:zstore_flutter/core/utils/theme/app_theme.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/validators/form_validator.dart';
import '../../../../core/widgets/custom/continue_button.dart';
import '../../../../core/widgets/custom/custom_app_bar.dart';
import '../../../../core/widgets/custom/custom_form_field.dart';
import '../auth_view_model/authentication_view_model.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final AuthViewModel _authProvider = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _authProvider, child: const RegistrationScreenContent());
  }
}

class RegistrationScreenContent extends StatefulWidget {
  const RegistrationScreenContent({Key? key}) : super(key: key);

  @override
  State<RegistrationScreenContent> createState() =>
      _RegistrationScreenContentState();
}

class _RegistrationScreenContentState extends State<RegistrationScreenContent> {
  @override
  void initState() {
    context.read<AuthViewModel>().clearRegistrationFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Registration',
        color: kCyanColor,
      ),
      // resizeToAvoidBottomInset: false,
      // backgroundColor: scafoldBackgroundColor,
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
                key: context.read<AuthViewModel>().registerFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' First Name',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: CustomTextFormField(
                        maxLines: 1,
                        maxLength: 20,
                        maxLengthEnforced: true,
                        controller: context
                            .read<AuthViewModel>()
                            .registerFirstNameController,
                        validator: FormValidators.validateName,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        focusNode: context
                            .read<AuthViewModel>()
                            .registerFirstNameFocusNode,
                        onChanged: context
                            .read<AuthViewModel>()
                            .onRegisterFirstNameChange,
                        onFieldSubmitted: (_) => context
                            .read<AuthViewModel>()
                            .onRegisterFirstNameSubmitted(context),
                      ),
                    ),
                    Text(
                      '  Last Name',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: CustomTextFormField(
                        maxLength: 20,
                        maxLengthEnforced: true,
                        maxLines: 1,
                        controller: context
                            .read<AuthViewModel>()
                            .registerLastNameController,
                        validator: FormValidators.validateName,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        focusNode: context
                            .read<AuthViewModel>()
                            .registerLastNameFocusNode,
                        onChanged: context
                            .read<AuthViewModel>()
                            .onRegisterLastNameChange,
                        onFieldSubmitted: (_) => context
                            .read<AuthViewModel>()
                            .onRegisterLastNameSubmitted(context),
                      ),
                    ),
                    Text(
                      '  Email Address',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: CustomTextFormField(
                        maxLines: 1,
                        controller: context
                            .read<AuthViewModel>()
                            .registerEmailController,
                        validator: FormValidators.validateEmail,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        focusNode: context
                            .read<AuthViewModel>()
                            .registerEmailFocusNode,
                        onChanged:
                            context.read<AuthViewModel>().onRegisterEmailChange,
                        onFieldSubmitted: (_) => context
                            .read<AuthViewModel>()
                            .onRegisterEmailSubmitted(context),
                      ),
                    ),
                    Text(
                      '  Gender',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: InputDecorator(
                        decoration: InputDecoration(),
                        child: RadioGroup(
                          controller: context
                              .read<AuthViewModel>()
                              .genderRadioController,
                          values: context.read<AuthViewModel>().genderValues,
                          indexOfDefault: 0,
                          orientation: RadioGroupOrientation.Horizontal,
                          decoration: RadioGroupDecoration(
                            spacing: 100.w,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(fontSize: 12.sp),
                            activeColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '  Address',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: CustomTextFormField(
                        maxLength: 50,
                        maxLengthEnforced: true,
                        maxLines: 1,
                        controller: context
                            .read<AuthViewModel>()
                            .registerAddressController,
                        validator: FormValidators.validateDetails,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        focusNode: context
                            .read<AuthViewModel>()
                            .registerAddressFocusNode,
                        onChanged: context
                            .read<AuthViewModel>()
                            .onRegisterAddressChange,
                        onFieldSubmitted: (_) => context
                            .read<AuthViewModel>()
                            .onRegisterAddressSubmitted(context),
                      ),
                    ),
                    Text(
                      '  Password',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: context
                            .read<AuthViewModel>()
                            .obsecureRegistrationPasswordTextNotifier,
                        builder: (_, obsecureText, __) {
                          return CustomTextFormField(
                            maxLength: 20,
                            maxLengthEnforced: true,
                            controller: context
                                .read<AuthViewModel>()
                                .registerPasswordController,
                            obscureText: obsecureText,
                            suffixIconPath: obsecureText
                                ? AppAssets.icEyeOpenSvg
                                : AppAssets.icEyeCloseSvg,
                            suffixIconOnTap: context
                                .read<AuthViewModel>()
                                .onObsecureRegistrationPassword,
                            maxLines: 1,

                            validator: FormValidators.validatePassword,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            onFieldSubmitted: (_) => context
                                .read<AuthViewModel>()
                                .onRegisterPasswordSubmitted(context),
                            onChanged: context
                                .read<AuthViewModel>()
                                .onRegisterPasswordChange,
                            focusNode: context
                                .read<AuthViewModel>()
                                .registerPasswordFocusNode,
                          );
                        },
                      ),
                    ),
                    Text(
                      '  Re-enter Password',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: context
                            .read<AuthViewModel>()
                            .obsecureRegistrationConfirmPasswordTextNotifier,
                        builder: (_, obsecureText, __) {
                          return CustomTextFormField(
                            maxLength: 20,
                            maxLengthEnforced: true,
                            controller: context
                                .read<AuthViewModel>()
                                .registerConfirmPasswordController,
                            obscureText: obsecureText,
                            suffixIconPath: obsecureText
                                ? AppAssets.icEyeOpenSvg
                                : AppAssets.icEyeCloseSvg,
                            suffixIconOnTap: context
                                .read<AuthViewModel>()
                                .onObsecureRegistrationConfirmPassword,
                            maxLines: 1,
                            validator: FormValidators.validatePassword,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            onFieldSubmitted: (_) => context
                                .read<AuthViewModel>()
                                .onRegisterConfirmPasswordSubmitted(context),
                            onChanged: context
                                .read<AuthViewModel>()
                                .onRegisterConfirmPasswordChange,
                            focusNode: context
                                .read<AuthViewModel>()
                                .registerConfirmPasswordFocusNode,
                          );
                        },
                      ),
                    ),
                    Text(
                      '  Mobile Number',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: CustomTextFormField(
                        maxLength: 11,
                        maxLengthEnforced: true,
                        controller: context
                            .read<AuthViewModel>()
                            .registerMobileNumberController,
                        suffixIconOnTap:
                            context.read<AuthViewModel>().onObsecureChangeLogin,
                        maxLines: 1,
                        validator: FormValidators.validatePhone,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        onFieldSubmitted: (_) => context
                            .read<AuthViewModel>()
                            .onLoginPasswordSubmitted(context),
                        onChanged: context
                            .read<AuthViewModel>()
                            .onRegisterMobileNumChange,
                        focusNode: context
                            .read<AuthViewModel>()
                            .registerMobileNumFocusNode,
                      ),
                    ),
                    ContinueButton(
                        loadingNotifier: context
                            .read<AuthViewModel>()
                            .isRegisterLoadingNotifier,
                        text: 'Register',
                        // backgroundColor: Theme.of(context).primaryColor,
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context
                              .read<AuthViewModel>()
                              .isRegisterButtonPressed = true;
                          if (!context
                              .read<AuthViewModel>()
                              .registerFormKey
                              .currentState!
                              .validate()) {
                            return;
                          }

                          await context.read<AuthViewModel>().registerUser();
                          // context.read<AuthViewModel>().moveToLogin();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
