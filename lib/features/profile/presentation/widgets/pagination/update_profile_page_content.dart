import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_view_model/authentication_view_model.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/theme/app_theme.dart';
import '../../../../../core/utils/validators/form_validator.dart';
import '../../../../../core/widgets/custom/continue_button.dart';
import '../../../../../core/widgets/custom/custom_app_bar.dart';
import '../../../../../core/widgets/custom/custom_form_field.dart';
import '../../profile_view_model/profile_view_model.dart';

class UpdateProfilePage extends StatelessWidget {
  UpdateProfilePage({Key? key}) : super(key: key);
  final ProfileViewModel profileViewModel = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: profileViewModel, child: const ProfilePageContent());
  }
}
class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar( title: 'Update Profile',color: kCyanColor,),

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
                key: context.read<ProfileViewModel>().updateProfileFormKey,
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
                        controller: context
                            .read<ProfileViewModel>()
                            .firstNameController,
                        validator: FormValidators.validateName,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        focusNode: context
                            .read<ProfileViewModel>()
                            .firstNameFocusNode,
                        onChanged: context
                            .read<ProfileViewModel>()
                            .onUpdateFirstNameChange,
                        onFieldSubmitted: (_) => context
                            .read<ProfileViewModel>()
                            .onUpdateFirstNameSubmitted(context),
                      ),
                    ),
                    Text(
                      '  Last Name',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: CustomTextFormField(
                        maxLines: 1,
                        controller: context
                            .read<ProfileViewModel>()
                            .lastNameController,
                        validator: FormValidators.validateName,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        focusNode: context
                            .read<ProfileViewModel>()
                            .lastNameFocusNode,
                        onChanged: context
                            .read<ProfileViewModel>()
                            .onUpdateLastNameChange,
                        onFieldSubmitted: (_) => context
                            .read<ProfileViewModel>()
                            .onUpdateLastNameSubmitted(context),
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
                            .read<ProfileViewModel>()
                            .emailController,
                        validator: FormValidators.validateEmail,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        focusNode: context
                            .read<ProfileViewModel>()
                            .emailFocusNode,
                        onChanged: context
                            .read<ProfileViewModel>()
                            .onEmailChange,
                        onFieldSubmitted: (_) => context
                            .read<ProfileViewModel>()
                            .onUpdateEmailSubmitted(context),
                      ),
                    ),
                    Text(
                      '  Gender',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: InputDecorator(
                        decoration: InputDecoration(

                        ),
                        child: RadioGroup(
                          controller: context
                              .read<ProfileViewModel>()
                              .genderRadioController,
                          values: context.read<ProfileViewModel>().genderValues,
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
                      '  Mobile',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: CustomTextFormField(
                        maxLines: 1,
                        controller: context
                            .read<ProfileViewModel>()
                            .mobileController,
                        validator: FormValidators.validatePhone,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        focusNode: context
                            .read<ProfileViewModel>()
                            .mobileFocusNode,
                        onChanged: context
                            .read<ProfileViewModel>()
                            .onMobileChange,
                        onFieldSubmitted: (_) => context
                            .read<ProfileViewModel>()
                            .onUpdateMobileSubmitted(context),
                      ),
                    ),     Text(
                      '  Address',
                      style: AppTheme.appTheme.textTheme.subtitle2,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: CustomTextFormField(
                        maxLines: 1,
                        controller: context
                            .read<ProfileViewModel>()
                            .addressController,
                        validator: FormValidators.validateDetails,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        focusNode: context
                            .read<ProfileViewModel>()
                            .addressFocusNode,
                        onChanged: context
                            .read<ProfileViewModel>()
                            .onAddressChange,
                        onFieldSubmitted: (_) => context
                            .read<ProfileViewModel>()
                            .onUpdateAddressSubmitted(context),
                      ),
                    ),
                    ContinueButton(
                        loadingNotifier: context
                            .read<ProfileViewModel>()
                            .isLoadingNotifier,
                        text: 'Update',
                        // backgroundColor: Theme.of(context).primaryColor,
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context
                              .read<ProfileViewModel>()
                              .isUpdateButtonPressed = true;
                          if (!context
                              .read<ProfileViewModel>()
                              .updateProfileFormKey
                              .currentState!
                              .validate()) {
                            return;
                          }
                         // print( context.read<ProfileViewModel>().genderRadioController.value);
                          await context.read<ProfileViewModel>().updateProfile();

                         context.read<ProfileViewModel>().loadProfileData();
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

