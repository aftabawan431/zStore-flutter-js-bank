import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/widgets/custom/custom_app_bar.dart';
import '../../../../../core/widgets/custom/custom_otp_fields.dart';
import '../../auth_view_model/authentication_view_model.dart';

class OtpPage extends StatelessWidget {
  OtpPage({Key? key}) : super(key: key);

  AuthViewModel _authProvider = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: _authProvider, child: OtpScreenContent());
  }
}

class OtpScreenContent extends StatefulWidget {
  OtpScreenContent({Key? key}) : super(key: key);

  @override
  State<OtpScreenContent> createState() => _OtpScreenContentState();
}

class _OtpScreenContentState extends State<OtpScreenContent> {
  AuthViewModel authProvider = sl();
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar( title: 'Password Recovery',color: kCyanColor,),

      backgroundColor: scafoldBackgroundColor,
      // resizeToAvoidBottomInset: false,
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
                key: context.read<AuthViewModel>().otpFormKey,
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
                              'OTP Validation',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(fontSize: 30.h),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'You have received pin on your email',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(fontSize: 16.h,color: Colors.black54),
                            ),
                            Text(
                              'Please enter',
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
                      CustomOtpFields(
// controller: authProvider.otpController,
                        errorStream: authProvider.errorStream,
                        onChanged: authProvider.onChanged,
                        onCompleted: authProvider.onCompleted,
                        beforeTextPaste: authProvider.beforeTextPaste,
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: authProvider.isResendOtpNotifier,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: value
                                ? Center(
                              child: SizedBox(
                                height: 30.w,
                                width: 30.w,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 2,
                                  backgroundColor: Colors.transparent,
                                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                ),
                              ),
                            )
                                : Center(
                                  child: TextButton(
                              onPressed: () async {
                                  authProvider.otpController.clear();
                                  await authProvider.generateOtp();
                              },
                              child: Text('Resend Code', style: Theme.of(context).textTheme.subtitle2),
                              style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h), primary: Color(0xFFF7F8FA)),
                            ),
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

