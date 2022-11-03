import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:zstore_flutter/features/my_favrouits/presentation/widgets/my_favorites_loading_item.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/app_state.dart';
import '../../../../core/utils/globals/globals.dart';

class NotificationsPageContent extends StatelessWidget {
  const NotificationsPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 40.h, // Set this height
        backgroundColor: kCyanColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: GestureDetector(
            onTap: () {
              GetIt.I.get<AppState>().moveToBackScreen();
            },
            child: Card(
              elevation: 2,
              child: Container(
                height: 26.h,
                width: 22.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white]),
                ),
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          'Notifications',
          style:
              Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15.h),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssets.backgroundImagePNG),
              fit: BoxFit.cover),
        ),
        child: const MyFavoritesLoadingItem(),
      ),
    );
  }
}
