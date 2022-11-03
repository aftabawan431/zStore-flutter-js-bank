import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zstore_flutter/core/widgets/custom/custom_app_bar.dart';

import '../../../../core/router/app_state.dart';
import '../../../../core/utils/globals/globals.dart';
import '../my_membership_view_model/my_membership_view_model.dart';

class MyMembershipPage extends StatelessWidget {
  MyMembershipPage({Key? key}) : super(key: key);
  MyMemberShipViewModel myMemberShipProvider = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: myMemberShipProvider, child: const MyMembershipPageContent());
  }
}

class MyMembershipPageContent extends StatefulWidget {
  const MyMembershipPageContent({Key? key}) : super(key: key);
  @override
  State<MyMembershipPageContent> createState() =>
      _MyMembershipPageContentState();
}

class _MyMembershipPageContentState extends State<MyMembershipPageContent> {
  double _currentValue = 0;
  double min = 0;
  double max = 4000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 40, // Set this height

          backgroundColor: Colors.black,
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
           'My Membership',
            style:
            Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15.h,color: Colors.white),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
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
          ]),

      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r)),
              color: Colors.black,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              ListView(shrinkWrap: true, children: [
                CarouselSlider(
                    options: CarouselOptions(
                      height: 300.0.h,
                      enlargeCenterPage: true,
                      autoPlay: false,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.8,
                    ),
                    items: [
                      SizedBox(
                        height: 400.h,
                        width: 580.w,
                        child: Image.asset(AppAssets.icGoldPNG),
                      ),
                      SizedBox(
                        height: 400.h,
                        width: 280.w,
                        child: Image.asset(AppAssets.icSilverPng,
                            height: 400.h, width: 400.w),
                      ),
                    ]),
              ]),
              Text(
                _currentValue.toString(),
                style: TextStyle(fontSize: 10.sp),
              ),
              SliderTheme(
                data: SliderThemeData(
                    trackHeight: 4,
                    thumbShape:
                        RoundSliderThumbShape(enabledThumbRadius: 6.0.r)),
                child: Slider(
                  autofocus: true,
                  value: _currentValue,
                  min: min,
                  max: max,
                  divisions: 100,
                  activeColor: Colors.amber,
                  inactiveColor: Colors.grey,
                  thumbColor: Colors.amber,
                  label: _currentValue.toString(),
                  onChanged: (value) {
                    setState(() {
                      _currentValue = value;
                    });
                  },
                ),
              ),
              Text(
                ' Need 64 More  points  ',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 10.h, color: Colors.amber),
              ),
            ]),
          ),
          SizedBox(
            height: 30.h,
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            // removeBottom: true,
            child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 0, left: 25, right: 25),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Container(
                        height: 80.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    height: 80.h,
                                    width: 80.w,
                                    padding: const EdgeInsets.only(
                                        left: 1, top: 1, bottom: 1),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.asset(
                                        AppAssets.icPictureSvg,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2)),
                                      Text(
                                        '50% off your next order',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                                fontSize: 12.h,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        'Daily login bonus 50 max discount',
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 110.0, top: 12),
                                        child: Text(
                                          'Expire on 10 june',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              ?.copyWith(
                                                  fontSize: 8.h,
                                                  color: Colors.black26),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 10),
                                  child: Column(
                                    //     mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.icLockSvg,
                                        height: 15.h,
                                        color: Colors.cyan,
                                        //alignment: Alignment.topRight,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
