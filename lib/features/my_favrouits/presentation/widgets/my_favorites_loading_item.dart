import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_assets.dart';

class MyFavoritesLoadingItem extends StatelessWidget {
  const MyFavoritesLoadingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      constraints:  const BoxConstraints.expand(),
      decoration:  const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppAssets.backgroundImagePNG),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          SizedBox(height: 20.h),

          Expanded(
            child: Container(

              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  )),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
                child: ListView.separated(
                  itemCount: 21,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                        thickness: 1.5, color: Colors.white, indent: 22.w, endIndent: 22.w);
                  },
                  itemBuilder: (_, index) {
                    if (index == 20) {
                      return SizedBox(
                        height: 28.h,
                      );
                    }
                    // return const TransactionItem();
                    return Shimmer.fromColors(
                        baseColor: Colors.grey.shade50,
                        highlightColor: Colors.grey.withOpacity(.1),
                        child: Row(
                          children: [
                            Container(
                              width: 80.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.grey.shade50, width: 1),
// shape: BoxShape.circle,
                              ),
                              // alignment: Alignment.center,
                            ),
                            Expanded(
                              child: Container(
                                height: 80.h,
                                // width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
