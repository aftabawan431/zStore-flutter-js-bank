import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';
import 'package:zstore_flutter/features/dashboard/presentation/widgets/notifications_page_content.dart';

import '../../router/app_state.dart';
import '../../utils/enums/page_state_enum.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
   CustomAppBar({required this.title, this.showBackButton = true, Key? key,this.color}) : super(key: key);

  final String title;
  Color? color;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        toolbarHeight: 40, // Set this height

        backgroundColor: color,
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
                child: Icon(Icons.chevron_left_rounded, color: Colors.black,size: 20.sp,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style:
          Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15.h),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationsPageContent()));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Card(
                elevation: 2,
                child: Container(
                  height: 23.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    gradient: const LinearGradient(
                        colors: [Colors.white, Colors.white]),
                  ),
                  child: Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
            // child: SvgPicture.asset(trailingIcon!),
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}



Widget zStoreAppBar(
    {required BuildContext context,
    required String leadingIcon,
    required String title,
      Color? titleColor,
    String? trailingIcon}) {
  return ListTile(
    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),

    leading: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
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
          child: Icon(Icons.chevron_left_rounded, color: Colors.black,size: 20.sp,
        ),
    ),
      ),),
    title: Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15.h,color:titleColor ),
      ),
    ),
    trailing: GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 2,
        child: Container(
          height: 26.h,
          width: 25.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            gradient: const LinearGradient(
                colors: [Colors.white, Colors.white]),
          ),
          child: Icon(Icons.notifications_none, color: Colors.black,size: 20.sp,
          ),
        ),
      ),
      // child: SvgPicture.asset(trailingIcon!),
    ),
  );
}

Widget zStoreMenuAppBar(
    {required BuildContext context,
    required String title,
   }) {
  return ListTile(
    leading: GestureDetector(
      onTap: () {
        // Navigator.of(context).pop();
      },
      child: Card(
        elevation: 2,

        child: Container(
          height: 22.h,
          width: 22.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            gradient: const LinearGradient(
                colors: [Colors.white, Colors.white]),
          ),
          child:  Icon(Icons.menu, color: Colors.black,size: 14.sp,
          ),
        ),
      ),),
    title: Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15.h),
      ),
    ),
    trailing: GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 2,
        child: Container(
          height: 23.h,
          width: 25.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            gradient: const LinearGradient(
                colors: [Colors.white, Colors.white]),
          ),
          child: Icon(Icons.notifications_none, color: Colors.black,
          ),
        ),
      ),
      // child: SvgPicture.asset(trailingIcon!),
    ),  );
}

Widget detailItem(
    {required BuildContext context,
    required String title,
    required int detail}) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(title, style: Theme.of(context).textTheme.bodyText2),
      SizedBox(width: 5.w),
      Expanded(
        child: Text('${detail}',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.grey),
            textAlign: TextAlign.end),
      ),
    ],
  );
}
