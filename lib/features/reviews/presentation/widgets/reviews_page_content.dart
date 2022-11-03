import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';

import '../../../../core/constants/app_url.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/widgets/custom/add_review_bottom_sheet.dart';
import '../../../../core/widgets/custom/custom_app_bar.dart';
import '../reviews_view_model/reviews_view_model.dart';

class ReviewsPage extends StatelessWidget {
  ReviewsPage({Key? key}) : super(key: key);
  ReviewsViewModel reviewScreenProvider = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: reviewScreenProvider, child: const ReviewScreenContent());
  }
}

class ReviewScreenContent extends StatefulWidget {
  const ReviewScreenContent({Key? key}) : super(key: key);
  @override
  State<ReviewScreenContent> createState() => _ReviewScreenContentState();
}

class _ReviewScreenContentState extends State<ReviewScreenContent> {
  // ReviewsViewModel reviewsViewModel=sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Reviews',
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () async {
                      context
                          .read<ReviewsViewModel>()
                          .commentController
                          .clear();
                      context.read<ReviewsViewModel>().reviewFilesList = [];
                      AddReviewBottomSheet bottomSheet = AddReviewBottomSheet(
                        context: context,
                        productId: '',
                      );
                      await bottomSheet.show();
                    },
                    child: Text(
                      'Add Review',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).primaryColor),
                    )),
              ),
            ),
            Consumer<ReviewsViewModel>(builder: (_, reviewsViewModel, __) {
              if (reviewsViewModel.getAllReviewsNotifier.value) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else {
                if (reviewsViewModel.getReviewResponseModel!.data.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200.h,
                      ),
                      Text('No Reviews Found yet 😌',
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text('Kindly add review to see yours',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle2)
                    ],
                  );
                } else {
                  return Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: reviewsViewModel
                            .getReviewResponseModel!.data.length,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 1.h);
                        },
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              context.read<ReviewsViewModel>().seeReviewDetails(
                                  reviewId: reviewsViewModel
                                      .getReviewResponseModel!.data[index].id);
                              // context.read<ReviewsViewModel>().moveToSeeReviewDetails();
                            },
                            child: Card(
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 18.w,
                                  vertical: 10.0.h,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 50.0.w,
                                      height: 65.0.h,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              Container(
                                            width: 50.0.w,
                                            height: 65.0.h,
                                            color: Colors.grey.withOpacity(.3),
                                          ),
                                          imageUrl: AppUrl.fileBaseUrl +
                                              reviewsViewModel
                                                  .getReviewResponseModel!
                                                  .data[index]
                                                  .image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          reviewsViewModel
                                              .getReviewResponseModel!
                                              .data[index]
                                              .productName,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 4.0.h,
                                        ),
                                        Text(
                                            'Rs: ${reviewsViewModel.getReviewResponseModel!.data[index].discountedPrice}',
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Ratings",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black26,
                                                  fontSize: 12.sp),
                                            ),
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            RatingBarIndicator(
                                              rating: reviewsViewModel
                                                  .getReviewResponseModel!
                                                  .data[index]
                                                  .rating
                                                  .toDouble(),
                                              itemBuilder: (context, index) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 20.sp,
                                              direction: Axis.horizontal,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
