import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../../../features/reviews/presentation/reviews_view_model/reviews_view_model.dart';
import '../../utils/globals/globals.dart';
import 'continue_button.dart';

class AddReviewBottomSheet {
  final BuildContext context;
  final String productId;

  AddReviewBottomSheet({
    required this.context,
    required this.productId,
  });

  double rating = 0;
  int degree = 340;
  Future show() async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Container(
            height: 600.h +
                EdgeInsets.fromWindowPadding(
                        WidgetsBinding.instance.window.viewInsets,
                        WidgetsBinding.instance.window.devicePixelRatio)
                    .bottom,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r)),
            ),
            padding: EdgeInsets.only(
                top: 34.h, bottom: 12.w, left: 22.w, right: 22.w),
            child: Expanded(
              child: Form(
                key: context.read<ReviewsViewModel>().reviewFormFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('How would you Rate our product ?',
                        style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RatingBar.builder(
                        initialRating: rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 30.h,
                        itemBuilder: (context, _) => Icon(
                          Icons.star_border,
                          color: Colors.amber,
                          size: 20.h,
                        ),
                        onRatingUpdate: (value) {
                          rating = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('Add a photo or video',
                        style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(
                      height: 10.h,
                    ),
                    ValueListenableBuilder<File?>(
                        valueListenable: context
                            .read<ReviewsViewModel>()
                            .ratingImgFileNotifier,
                        builder: (_, profileImg, __) {
                          return GestureDetector(
                            child: Container(
                              height: 100.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Colors.cyan.withOpacity(0.1),
                              ),
                              child: DottedBorder(
                                color: Theme.of(context).primaryColor,
                                strokeWidth: 1,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(15.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Transform.rotate(
                                            angle: (degree * pi) / 180,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.image,
                                                color: const Color(0xFFE1BEE7),
                                                size: 40.h,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.play_circle_outline,
                                              color: Colors.grey,
                                              size: 42.h,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.green,
                                            size: 20.h,
                                          ),
                                          onPressed: () {},
                                        ),
                                        const Text(
                                          'Click here to upload',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () async {
                              ReviewsViewModel rev = sl();
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                      allowMultiple: true,
                                      type: FileType.image);
                              if (result == null) {
                                print("No file selected");
                              } else {
                                result.files.forEach((element) {
                                  rev.ratingImgFileNotifier.value =
                                      File(element.path!);
                                  List<int> imageBytes = rev
                                      .ratingImgFileNotifier.value!
                                      .readAsBytesSync();
                                  rev.reviewFilesList
                                      .add(base64Encode(imageBytes));
                                  // fileName = element.name;
                                  rev.reviewFilesNameList.add(element.name);
                                  print(rev.reviewFilesList.first);

                                  // fileslist.add(element.name);
                                });
                              }
                            },
                          );
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('Write your Review',
                        style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller:
                          context.read<ReviewsViewModel>().commentController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(
                            15.r,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(
                              15.r,
                            )),
                        hintText:
                            'Would you like to write anything about this product ?',
                        hintStyle: const TextStyle(
                            fontSize: 12, color: Colors.black12),
                        filled: false,
                      ),
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ContinueButton(
                        loadingNotifier:
                            context.read<ReviewsViewModel>().addReviewsNotifier,
                        text: 'Submit',
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();

                          if (context
                                      .read<ReviewsViewModel>()
                                      .commentController
                                      .text ==
                                  '' ||
                              context
                                      .read<ReviewsViewModel>()
                                      .reviewFilesList ==
                                  []) {
                            Fluttertoast.showToast(
                                msg: 'plz fill the form first',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM_LEFT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 12.sp);
                            return;
                          }
                          await context.read<ReviewsViewModel>().addYourReviews(
                              context
                                  .read<ReviewsViewModel>()
                                  .getReviewResponseModel!
                                  .ID
                                  .toString(),
                              rating.toInt(),
                              context
                                  .read<ReviewsViewModel>()
                                  .commentController
                                  .text,
                              context.read<ReviewsViewModel>().reviewFilesList);
                          print(
                              'this is the fucking product id ${context.read<ReviewsViewModel>().getReviewResponseModel!.ID}');
                          await context.read<ReviewsViewModel>().getAllReviews(
                              productId: context
                                  .read<ReviewsViewModel>()
                                  .getReviewResponseModel!
                                  .ID);
                          Navigator.of(context).pop();

                          // context
                          //     .read<ReviewsViewModel>()
                          //     .isUpdateButtonPressed = true;
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
