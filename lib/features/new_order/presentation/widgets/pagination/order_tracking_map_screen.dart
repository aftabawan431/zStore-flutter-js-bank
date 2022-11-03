import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';
import 'package:zstore_flutter/core/widgets/custom/custom_app_bar.dart';

import '../../../../../core/widgets/custom/continue_button.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  @override
  State<MapPage> createState() => _MapScreen();
}

class _MapScreen extends State<MapPage> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssets.backgroundImagePNG),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              zStoreAppBar(
                  context: context,
                  leadingIcon: AppAssets.icBackSvg,
                  title: 'Map',
                  trailingIcon: AppAssets.icNotificationSvg),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 500.h,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: const GoogleMap(
                          // myLocationButtonEnabled: true,
                          zoomControlsEnabled: false,
                          initialCameraPosition: _initialCameraPosition,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // top: 0,
                    bottom: 12.h,
                    child: SizedBox(
                      height: 70.h,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.cyan.withOpacity(0.7),
                        ),
                        height: 60.h,
                        width: 310.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 5, left: 20),
                                  child: Row(
                                    children: const [
                                      Text(
                                        "4 days 2 hr 9 min",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '5585 mi',
                                      style: TextStyle(fontSize: 9.sp),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Text(
                                      '6:41pm',
                                      style: TextStyle(fontSize: 9.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 120.w,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(AppAssets.icDirection)),
                            VerticalDivider(
                              color: Colors.grey,
                              thickness: 1.0,
                              width: 15.w,
                              indent: 10,
                              endIndent: 10,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(AppAssets.icCloseSvg)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Container(
                    height: 50.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: Image.asset(
                          AppAssets.membershipImagePNG,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        "Delivery Timer:",
                        style:
                            Theme.of(context).textTheme.headline6?.copyWith(
                                  fontSize: 10.h,
                                ),
                      ),
                      SizedBox(
                        width: 125.w,
                      ),
                      Text(
                        '12:12:12',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(
                                fontSize: 10.h,
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Container(
                    height: 95.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 30.h,
                            width: 20.w,
                          ),
                          const Text(
                            'Driver detail',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              height: 45.h,
                              width: 45.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.asset(
                                  AppAssets.membershipImagePNG,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Mobile No',
                                    style: TextStyle(
                                        fontSize: 10.sp, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Mohsin Ishfaq',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '03*******03',
                                  style: TextStyle(
                                      fontSize: 10.sp, color: Colors.grey),
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox.shrink()),
                            Column(
                              children: [
                                SvgPicture.asset(
                                  AppAssets.callSvg,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SvgPicture.asset(
                                  AppAssets.icEmailSvg,
                                  width: 16.w,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                child: ContinueButton(text: 'Okay', onPressed: () {

                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
