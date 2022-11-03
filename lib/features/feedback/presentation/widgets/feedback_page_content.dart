import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';
import 'package:zstore_flutter/core/constants/app_url.dart';
import 'package:zstore_flutter/core/utils/enums/status_enums.dart';
import 'package:zstore_flutter/core/utils/globals/show_app_bar.dart';
import 'package:zstore_flutter/core/widgets/custom/continue_button.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_view_model/authentication_view_model.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/widgets/custom/custom_app_bar.dart';
import '../feedback_view_model/feedback_view_model.dart';

class FeedBackPage extends StatelessWidget {
  FeedBackPage({Key? key}) : super(key: key);
  FeedbackViewModel feedbackProvider = sl();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: feedbackProvider, child: FeedBackScreenContent());
  }
}

class FeedBackScreenContent extends StatefulWidget {
  const FeedBackScreenContent({Key? key}) : super(key: key);
  @override
  State<FeedBackScreenContent> createState() => _FeedBackScreenContentState();
}

class _FeedBackScreenContentState extends State<FeedBackScreenContent> {
  FeedbackViewModel feedbackProvider = sl();
  AuthViewModel authViewModel = sl();
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    feedbackProvider.ratingController.text = '4';
    await feedbackProvider.getFeedback();
  }

  Status selectType = Status.good;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Feedback',
        color: kCyanColor,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.backgroundImagePNG),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<FeedbackViewModel>(
                builder: (BuildContext context, provider, __) {
              return ValueListenableBuilder<bool>(
                  valueListenable: provider.isGetFeedback,
                  builder: (_, val, __) {
                    if (val) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      );
                    } else {
                      return Column(children: [
                        SizedBox(height: 20.h),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 115.h,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.r),
                                        topRight: Radius.circular(15.r)),
                                    gradient: const LinearGradient(colors: [
                                      Colors.lightGreen,
                                      Colors.green,
                                      Colors.cyan
                                    ]),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 15.h),
                                      child: feedbackProvider
                                              .getFeedbackResponseModel!
                                              .data
                                              .isNotEmpty
                                          ? Text(
                                              provider
                                                          .getFeedbackResponseModel!
                                                          .data
                                                          .last
                                                          .comments
                                                          .length >
                                                      200
                                                  ? '${provider.getFeedbackResponseModel!.data.last.comments.substring(0, 200)}...'
                                                  : provider
                                                      .getFeedbackResponseModel!
                                                      .data
                                                      .last
                                                      .comments,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.copyWith(
                                                      fontSize: 10.h,
                                                      color: Colors.black),
                                            )
                                          : Text(
                                              "No Feedback yet",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.copyWith(
                                                      fontSize: 10.h,
                                                      color: Colors.black),
                                            )),
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 115.h,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15.r),
                                        bottomRight: Radius.circular(15.r)),
                                    gradient: const LinearGradient(
                                        colors: [Colors.white, Colors.white]),
                                  ),
                                ),
                              ),
                            ]),
                            Positioned(
                              child: Column(
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 20.w, top: 5.h),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Container(
                                          //padding: EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.r),
                                              border: Border.all(
                                                  color: Colors.white)),
                                          child: CircleAvatar(
                                            radius: 30.r,
                                            backgroundImage: NetworkImage(
                                              AppUrl.fileBaseUrl +
                                                  authViewModel
                                                      .userDetails!.data.image,
                                            ),
                                            // backgroundColor: Colors
                                            //     .transparent,
                                          ),
                                        ),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: RatingBar.builder(
                                      initialRating: feedbackProvider
                                              .getFeedbackResponseModel!
                                              .data
                                              .isNotEmpty
                                          ? double.parse(provider
                                              .getFeedbackResponseModel!
                                              .data
                                              .first
                                              .rating
                                              .toString())
                                          : 0,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      glow: true,
                                      ignoreGestures: false,
                                      itemCount: 5,
                                      itemSize: 15.w,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 12,
                                      ),
                                      onRatingUpdate: (value) {},
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      authViewModel.userDetails!.data.firstName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(
                                              fontSize: 10.h,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          height: 380.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    'How would you describe your experience with our services?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                            fontSize: 14.h,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectType = Status.worst;
                                          print('worst');
                                        });
                                        feedbackProvider.ratingController
                                            .clear();
                                        feedbackProvider.ratingController.text =
                                            '1';
                                      },
                                      child: Column(
                                        children: [
                                          Image(
                                            height: selectType == Status.worst
                                                ? 55.h
                                                : 45.h,
                                            width: selectType == Status.worst
                                                ? 60.w
                                                : 50.w,
                                            image: const AssetImage(
                                                AppAssets.icWorstPNG),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            'Worst',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                    fontSize: selectType ==
                                                            Status.worst
                                                        ? 14.h
                                                        : 10.h,
                                                    color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectType = Status.bad;
                                          print('bad');
                                        });
                                        feedbackProvider.ratingController
                                            .clear();
                                        feedbackProvider.ratingController.text =
                                            '2';
                                      },
                                      child: Column(
                                        children: [
                                          Image(
                                            height: selectType == Status.bad
                                                ? 55.h
                                                : 45.h,
                                            width: selectType == Status.bad
                                                ? 60.w
                                                : 50.w,
                                            image: const AssetImage(
                                                AppAssets.icBadPNG),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            'Bad',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                    fontSize:
                                                        selectType == Status.bad
                                                            ? 14.h
                                                            : 10.h,
                                                    color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectType = Status.good;
                                          print('good');
                                        });
                                        feedbackProvider.ratingController
                                            .clear();
                                        feedbackProvider.ratingController.text =
                                            '3';
                                      },
                                      child: Column(
                                        children: [
                                          Image(
                                            height: selectType == Status.good
                                                ? 55.h
                                                : 45.h,
                                            width: selectType == Status.good
                                                ? 60.w
                                                : 50.w,
                                            image:
                                                AssetImage(AppAssets.icGoodPNG),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            'Good',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                    fontSize: selectType ==
                                                            Status.good
                                                        ? 14.h
                                                        : 10.h,
                                                    color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectType = Status.excellent;
                                          print('excellent');
                                        });
                                        feedbackProvider.ratingController
                                            .clear();
                                        feedbackProvider.ratingController.text =
                                            '4';
                                      },
                                      child: Column(
                                        children: [
                                          Image(
                                            height:
                                                selectType == Status.excellent
                                                    ? 55.h
                                                    : 45.h,
                                            width:
                                                selectType == Status.excellent
                                                    ? 60.w
                                                    : 50.w,
                                            image: AssetImage(
                                                AppAssets.icExellentPNG),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            'Excellent',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                    fontSize: selectType ==
                                                            Status.excellent
                                                        ? 14.h
                                                        : 10.h,
                                                    color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'Do you have any other comments.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          fontSize: 15.h,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'questions or concern?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          fontSize: 15.h,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormField(
                                  controller:
                                      feedbackProvider.commentsController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black12,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black12,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          15,
                                        )),
                                    hintText: '',
                                    hintStyle: const TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                    filled: false,
                                  ),
                                  maxLines: 2,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                      height: 45.h,
                                      width: 220.w,
                                      child: ContinueButton(
                                          text: 'Submit',
                                          onPressed: () async {
                                            print(feedbackProvider
                                                .commentsController.text);
                                            print(feedbackProvider
                                                .ratingController.text);
                                            if (feedbackProvider
                                                    .commentsController
                                                    .text
                                                    .isEmpty ||
                                                feedbackProvider
                                                    .ratingController
                                                    .text
                                                    .isEmpty) {
                                              ShowSnackBar.show(
                                                  "Please Enter comments and Rating First");
                                            } else {
                                              await feedbackProvider
                                                  .postFeedback();
                                              await feedbackProvider
                                                  .getFeedback();
                                              feedbackProvider
                                                  .commentsController
                                                  .clear();
                                              feedbackProvider.ratingController
                                                  .clear();
                                            }
                                          })),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]);
                    }
                  });
            }),
          ),
        ),
      ),
    );
  }
}

Widget emojisRatings(BuildContext context) {
  return Column(
    children: [
      Image(
        height: 50.h,
        width: 55.w,
        image: AssetImage(AppAssets.icGoodPNG),
      ),
      SizedBox(
        height: 5.h,
      ),
      Text(
        'Good',
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontSize: 10.h, color: Colors.grey),
      ),
    ],
  );
}
