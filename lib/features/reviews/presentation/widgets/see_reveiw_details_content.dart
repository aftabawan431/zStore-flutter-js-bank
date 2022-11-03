import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/features/reviews/presentation/reviews_view_model/reviews_view_model.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_url.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/widgets/custom/custom_app_bar.dart';

class SeeReviewDetails extends StatelessWidget {
  SeeReviewDetails({Key? key}) : super(key: key);
  ReviewsViewModel reviewsViewModel = sl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Review Details',
        color: kCyanColor,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssets.backgroundImagePNG),
              fit: BoxFit.cover),
        ),
        child: ValueListenableBuilder<bool>(
            valueListenable: reviewsViewModel.isSeeReviewDetailsNotifier,
            builder: (_, loading, __) {
              if (loading) {
                return const Center(child: CircularProgressIndicator.adaptive());
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product Images:',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 15.h),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: SizedBox(
                            height: 300.h,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 300.h,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ),
                              items: reviewsViewModel
                                  .seeReviewDetailsResponseModel!.data.images
                                  .map<Widget>((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 200.h,
                                        width: double.infinity,
                                     child:   CachedNetworkImage(
                                          placeholder: (context, url) =>  Container(
                                            height: 200.h,

                                            color: Colors.grey.withOpacity(.3),
                                          ),
                                          imageUrl: AppUrl.fileBaseUrl + i,
                                         fit: BoxFit.cover
                                        ),
                                      );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            'Rating:',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(fontSize: 15.h),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RatingBarIndicator(
                            rating: reviewsViewModel
                                .seeReviewDetailsResponseModel!.data.rating
                                .toDouble(),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 40.sp,
                            direction: Axis.horizontal,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            'Comments:',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(fontSize: 15.h),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, left: 20.w),
                          child: Text(
                            reviewsViewModel
                                .seeReviewDetailsResponseModel!.data.comment
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    fontSize: 12.h, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
