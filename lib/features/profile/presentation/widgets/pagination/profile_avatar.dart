import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:zstore_flutter/core/constants/app_url.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_view_model/authentication_view_model.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../profile_view_model/profile_view_model.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({Key? key}) : super(key: key);

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  AuthViewModel authViewModel = sl();
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 75.r,
          backgroundColor: Theme.of(context).primaryColor,
          child:
               ValueListenableBuilder<File?>(
                    valueListenable:
                        context.read<ProfileViewModel>().profileImgFile,
                    builder: (_, profileImg, __) {
                      return CircleAvatar(
                          radius: 73.r,
                          backgroundColor: Colors.white,
                          child:  ValueListenableBuilder<bool>(
                              valueListenable:
                              context.read<ProfileViewModel>().profileImageNotifier,
                              builder: (_, val, __) {
                                return  val==true?const CircularProgressIndicator.adaptive(): CircleAvatar(
                                radius: 70.r,
                                backgroundColor: Colors.grey.withOpacity(0.3),
                                backgroundImage: NetworkImage(
                                    AppUrl.fileBaseUrl +
                                        authViewModel.userDetails!.data.image,
                                    scale: 1.0),
                              );
                            }
                          ));
                    })

        ),
        Positioned(
          bottom: 16.h,
          right: -8.w,
          child: GestureDetector(
            onTap: () async {
              await context
                  .read<ProfileViewModel>()
                  .profileImageSelector(context);
              if(context
                  .read<ProfileViewModel>().profileImgFile.value!=null){
             await   context.read<ProfileViewModel>().setProfileImage(context);

              }
            },
            child: SimpleShadow(
              opacity: 0.3,
              color: Colors.black12,
              offset: const Offset(0, 0),
              sigma: 10,
              child: Container(
                height: 38.w,
                width: 38.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                ),
                padding: EdgeInsets.all(8.w),
                child: SvgPicture.asset(AppAssets.icCameraSvg,
                    color: Colors.white, height: 28.w, width: 28.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
