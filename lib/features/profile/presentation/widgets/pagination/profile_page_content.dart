import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zstore_flutter/features/authentication/data/modals/login_response_modal.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_view_model/authentication_view_model.dart';
import 'package:zstore_flutter/features/profile/presentation/widgets/pagination/profile_avatar.dart';
import '../../../../../core/constants/app_url.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../profile_view_model/profile_view_model.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final ProfileViewModel profileViewModel = sl();
  final AuthViewModel authViewModel = sl();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: profileViewModel,
      ),
      ChangeNotifierProvider.value(
        value: authViewModel,
      ),
    ], child: ProfilePageContent());
  }
}

class ProfilePageContent extends StatefulWidget {
  ProfilePageContent({Key? key}) : super(key: key);

  @override
  State<ProfilePageContent> createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  AuthViewModel authViewModel = sl();
  ProfileViewModel profileViewModel = sl();

  @override
  void initState() {
    profileViewModel.loadProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.backgroundImagePNG),
                fit: BoxFit.cover),
          ),
          child: Selector<AuthViewModel, LoginResponseModel?>(
              selector: (_, val) => val.userDetails,
              builder: (_, myData, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 55.h,
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ProfileAvatar()),
                    SizedBox(
                      height: 15.h,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1.h,
                      endIndent: 20.h,
                      indent: 20.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<ProfileViewModel>()
                            .moveToUpdateProfielPage();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.edit_note_outlined,
                            size: 30.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    fontSize: 16.h, color: Colors.black54),
                          ),
                        Padding(
                          padding: EdgeInsets.only(left: .2.sw),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(AppAssets.accountImagePNG),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        myData!.data.firstName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(fontSize: 16.h, color: Colors.black87),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 8.w),
                                        child: Text(
                                          myData.data.lastName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              ?.copyWith(fontSize: 16.h, color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),

                          Divider(
                            color: Colors.grey,
                            thickness: 1.h,
                            endIndent: 40.h,
                            indent: 10.h,
                          ),
                          Text(
                            'Mobile',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    fontSize: 16.h, color: Colors.black54),
                          ),
                          informationContainer(
                              context: context,
                              leadingIcon: AppAssets.mobileImagePNG,
                              text: myData.data.contact),
                          Divider(
                            color: Colors.grey,
                            thickness: 1.h,
                            endIndent: 40.h,
                            indent: 10.h,
                          ),
                          Text(
                            'Email',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    fontSize: 16.h, color: Colors.black54),
                          ),
                          informationContainer(
                              context: context,
                              leadingIcon: AppAssets.profileImagePNG,
                              text: myData.data.email),
                          Divider(
                            color: Colors.grey,
                            thickness: 1.h,
                            endIndent: 40.h,
                            indent: 10.h,
                          ),
                          Text(
                            'Address',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    fontSize: 16.h, color: Colors.black54),
                          ),
                          informationContainer(
                              context: context,
                              leadingIcon: AppAssets.locationImagePNG,
                              text: myData.data.address),
                          Divider(
                            color: Colors.grey,
                            thickness: 1.h,
                            endIndent: 40.h,
                            indent: 10.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget informationContainer(
      {required BuildContext context,
      required String leadingIcon,
      required String text}) {
    return Padding(
      padding: EdgeInsets.only(left: .2.sw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(leadingIcon),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
              child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontSize: 16.h, color: Colors.black87),
          )),
        ],
      ),
    );
  }
}
