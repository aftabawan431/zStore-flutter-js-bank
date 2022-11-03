import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/widgets/custom/custom_app_bar.dart';
import '../../my_points_view_model/my_points_view_model.dart';

class MyPointsPage extends StatelessWidget {
  MyPointsPage({Key? key}) : super(key: key);
  final MyPointsViewModel orderHistory = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: orderHistory,
      child: const MyPointsPageContent(),
    );
  }
}

class MyPointsPageContent extends StatefulWidget {
  const MyPointsPageContent({Key? key}) : super(key: key);

  @override
  State<MyPointsPageContent> createState() => _MyPointsPageContentState();
}

class _MyPointsPageContentState extends State<MyPointsPageContent> {

 MyPointsViewModel orderHistory = sl();

  @override
  void initState() {
    orderHistory.getTotalPoints();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar( title: 'My Points',color: kCyanColor,),

      body: Container(
        color: Colors.white,
        child: Consumer<MyPointsViewModel>(builder: (_, myPointsConsumer, __) {
          if(myPointsConsumer.isGotTotalPointsNotifier.value){
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          else{return  SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 230.h,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    color:const Color(0xFFE1F5F5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.r),
                      bottomRight: Radius.circular(50.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200.h,
                        child:Stack(
                          children: [
                            SizedBox(
                              width: 380.w,
                              height: 200.h,
                              child:
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(13.r), // Image border
                                child: SizedBox.fromSize(
                                    child: SizedBox(
                                        height: 200.h,
                                        child: SvgPicture.asset(AppAssets.icGiftSvg,fit: BoxFit.cover,))
                                ),
                              ),
                            ),
                            Positioned.fill(
                                child: Padding(
                                  padding:  EdgeInsets.only(left: 30.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(myPointsConsumer.getTotalPointsResponseModel!.data.totalPoints.toString(),style: Theme.of(context).textTheme.headline6?.copyWith(color: Theme.of(context).primaryColor,fontSize: 20.sp),),
                                      const Text(' Points',style: TextStyle(color: Colors.grey),),
                                    ],
                                  ),
                                ))
                          ],
                        ) ,

                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 3, 17, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Spanish Teardrop',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          SizedBox(
                            width: 153.w,
                          ),
                          Text(
                            'Order ID:121',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                color: Colors.black26,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(13.r), // Image border
                              child: SizedBox.fromSize(
                                child: Image.asset(
                                  AppAssets.icPictureSvg,
                                  fit: BoxFit.cover,
                                  width: 55.w,
                                  height: 55.h,
                                ),
                              ),
                            ),
                            VerticalDivider(
                              width: 18.w,
                              thickness: 1,
                              indent: 1,
                              endIndent: 3,
                              color: Colors.black12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                rowItem(
                                  context: context,
                                  title: 'Placed On',
                                  detail: '12-05-2022',),
                                SizedBox(
                                  height: 8.h,
                                ),
                                rowItem(
                                    context: context,
                                    title: 'Order Value',
                                    detail: '12'),
                                SizedBox(
                                  height: 8.h,
                                ),
                                rowItem(
                                    context: context,
                                    title: 'Order Via',
                                    detail: 'Mobile'),
                              ],
                            ),
                            VerticalDivider(
                              width: 23.w,
                              thickness: 1,
                              indent: 1,
                              endIndent: 3,
                              color: Colors.black12,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Points Awarded',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  '200',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                      color: Colors.purple, fontSize: 30.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1.0,
                        endIndent: 10,
                        indent: 5,
                      ),
                      SizedBox(
                        height: 5.h,
                        width: 20.w,
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 90.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                                color: Colors.cyan,
                                borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                            child: Text(
                              'Daily',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                  fontSize: 10.sp,color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 30.h),
                          Container(
                            alignment: Alignment.center,
                            width: 90.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.cyan,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child:  Text(
                              'Weekly',
                              style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 9.h,color: Colors.black,fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 20.h),
                          Container(
                            alignment: Alignment.center,
                            width: 90.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.cyan,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.r),
                              ),
                            ),
                            child: Text(
                              'Monthly',
                              style: TextStyle(color: Colors.black, fontSize: 9.sp,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            itemCount: 5,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.r)),
                                  child: Container(
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(20.r),
                                                      ),
                                                      height: 80.h,
                                                      width: 80.w,
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 1,
                                                          top: 1,
                                                          bottom: 1),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(10.r),
                                                        child: Image.asset(
                                                          AppAssets
                                                              .icPictureSvg,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            vertical: 2)),
                                                    const Text(
                                                      '50% off your next order',
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      'Daily login bonus 50 max discount',
                                                      style: TextStyle(
                                                          fontSize: 9.sp,
                                                          color: Colors.grey),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 150.0,
                                                          top: 12),
                                                      child: Text(
                                                        'Expire on 10 june',
                                                        style: TextStyle(
                                                            fontSize: 8.sp,
                                                            color:
                                                            Colors.black26),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      // ExpansionTile(
                      //   title:
                      //   children: [
                      //     // MediaQuery.removePadding(
                      //     //   context: context,
                      //     //   removeTop: true,
                      //     //   child: ListView.builder(
                      //     //       itemCount: 2,
                      //     //       physics: const NeverScrollableScrollPhysics(),
                      //     //       shrinkWrap: true,
                      //     //       itemBuilder: (_, index) {
                      //     //         return Padding(
                      //     //           padding: const EdgeInsets.only(
                      //     //               top: 10, left: 5, right: 10),
                      //     //           child: Card(
                      //     //             elevation: 10,
                      //     //             shape: RoundedRectangleBorder(
                      //     //                 borderRadius:
                      //     //                     BorderRadius.circular(10.r)),
                      //     //             // borderRadius: BorderRadius.circular(10.r),
                      //     //             child: Container(
                      //     //               height: 80.h,
                      //     //               decoration: BoxDecoration(
                      //     //                 color: Colors.white,
                      //     //                 borderRadius:
                      //     //                     BorderRadius.circular(30.r),
                      //     //               ),
                      //     //               child: Row(
                      //     //                 children: [
                      //     //                   Expanded(
                      //     //                       child: Row(
                      //     //                     children: [
                      //     //                       Column(
                      //     //                         children: [
                      //     //                           Container(
                      //     //                               decoration: BoxDecoration(
                      //     //                                 color: Colors.white,
                      //     //                                 borderRadius:
                      //     //                                     BorderRadius
                      //     //                                         .circular(20.r),
                      //     //                               ),
                      //     //                               height: 80.h,
                      //     //                               width: 80.w,
                      //     //                               padding:
                      //     //                                   const EdgeInsets.only(
                      //     //                                       left: 1,
                      //     //                                       top: 1,
                      //     //                                       bottom: 1),
                      //     //                               child: ClipRRect(
                      //     //                                 borderRadius:
                      //     //                                     BorderRadius
                      //     //                                         .circular(10.r),
                      //     //                                 child: Image.asset(
                      //     //                                   AppAssets
                      //     //                                       .icPictureSvg,
                      //     //                                   fit: BoxFit.cover,
                      //     //                                 ),
                      //     //                               )),
                      //     //                         ],
                      //     //                       ),
                      //     //                       Padding(
                      //     //                         padding:
                      //     //                             const EdgeInsets.symmetric(
                      //     //                                 horizontal: 10),
                      //     //                         child: Column(
                      //     //                           crossAxisAlignment:
                      //     //                               CrossAxisAlignment.start,
                      //     //                           children: [
                      //     //                             const Padding(
                      //     //                                 padding: EdgeInsets
                      //     //                                     .symmetric(
                      //     //                                         vertical: 2)),
                      //     //                             const Text(
                      //     //                               '50% off your next order',
                      //     //                             ),
                      //     //                             const SizedBox(
                      //     //                               height: 2,
                      //     //                             ),
                      //     //                             Text(
                      //     //                               'Daily login bonus 50 max discount',
                      //     //                               style: TextStyle(
                      //     //                                   fontSize: 10.sp,
                      //     //                                   color: Colors.grey),
                      //     //                             ),
                      //     //                             SizedBox(
                      //     //                               height: 10.h,
                      //     //                             ),
                      //     //                             Padding(
                      //     //                               padding:
                      //     //                                   const EdgeInsets.only(
                      //     //                                       left: 135.0,
                      //     //                                       top: 12),
                      //     //                               child: Text(
                      //     //                                 'Expire on 10 june',
                      //     //                                 style: TextStyle(
                      //     //                                     fontSize: 8.sp,
                      //     //                                     color:
                      //     //                                         Colors.black26),
                      //     //                               ),
                      //     //                             ),
                      //     //                           ],
                      //     //                         ),
                      //     //                       ),
                      //     //                     ],
                      //     //                   )),
                      //     //                   Row(
                      //     //                     children: const [
                      //     //                       Padding(
                      //     //                         padding:
                      //     //                             EdgeInsets.only(bottom: 25),
                      //     //                       )
                      //     //                     ],
                      //     //                   )
                      //     //                 ],
                      //     //               ),
                      //     //             ),
                      //     //           ),
                      //     //         );
                      //     //       }),
                      //     // ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ],
            ),
          );}
          }
        ),
      ),
    );
  }

  Widget rowItem(
      {required BuildContext context,
        required String title,
        required String detail}) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 10.sp),
          textAlign: TextAlign.end,
        ),
        SizedBox(width: 40.w),
        Text(
          detail,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 10.sp),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
