import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmerLoading extends StatelessWidget {
  const DashboardShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(.1),
      highlightColor: Colors.grey.withOpacity(.3),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //appbar
            SizedBox(
              height: 10.h,
            ),
            //banner
            Container(
              height: 80.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            //where to go
            Container(
              width: 250.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            //date
           SizedBox(
             height: 170.h,

             child: ListView.builder(
                 shrinkWrap: true,
                 scrollDirection: Axis.horizontal,
                 itemCount: 3,
                 itemBuilder: (BuildContext ,_){return  Padding(
                   padding:  EdgeInsets.symmetric(horizontal: 5.w),
                   child: Container(
               height: 150.h,
               width: 100.w,
               decoration: BoxDecoration(
                   color: Colors.grey,
                   borderRadius: BorderRadius.circular(12.r),
               ),
             ),
                 );}),
           ),
            SizedBox(
              height: 20.h,
            ),
            //around you
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 70.h,
                  width: .45.sw,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                Container(
                  height: 70.h,
                  width: .45.sw,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 70.h,
                  width: .45.sw,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                Container(
                  height: 70.h,
                  width: .45.sw,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
