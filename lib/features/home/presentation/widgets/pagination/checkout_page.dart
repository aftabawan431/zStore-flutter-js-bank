import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/radio_group_v2.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/theme/app_theme.dart';
import '../../../../../core/widgets/custom/continue_button.dart';
import '../../../../../core/widgets/custom/custom_app_bar.dart';
import '../../home_view_model/home_view_model.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({Key? key}) : super(key: key);

  final HomeViewModel homeProvider = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: homeProvider, child: const CheckoutScreenContent());
  }
}

class CheckoutScreenContent extends StatelessWidget {
  const CheckoutScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.backgroundImagePNG),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 700.h,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    zStoreAppBar(
                        context: context,
                        leadingIcon: AppAssets.icBackSvg,
                        title: 'Checkout',
                        trailingIcon: AppAssets.icNotificationSvg),
                    SizedBox(height: 15.h),
                    _headingItem(
                        context: context,
                        title: 'Delivery Address',
                     onTap: () { return null; }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Card(
                        child: Container(
                          height: 120.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),

                          ),
                          child: Column(
                            children: [
                              _detailItem(context: context, icon:  AppAssets.icPersonSvg, detail: 'Aftab Ahmad'),
                              _detailItem(context: context, icon:  AppAssets.icMobileSvg, detail: '03423121141'),
                              _detailItem(context: context, icon:  AppAssets.icHomeSvg, detail: 'House number 29 near govt model school')
                            ],
                          ),
                        ),
                      ),
                    ),

                    _headingItem(
                        context: context,
                        title: 'Delivery Option',
                        onTap: () { return null; }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Card(
                        child: Container(
                          height: 100.h,
                          width: double.infinity,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),

                          ),
                          child:     Padding(
                            padding: const EdgeInsets.only(left: 20,),
                            child: RadioGroup(
                              controller: context.read<HomeViewModel>().deliveryOptionRadioController,
                              values: context.read<HomeViewModel>().deliveryOptionValues,
                              indexOfDefault: 1,
                              orientation: RadioGroupOrientation.Vertical,
                              decoration: RadioGroupDecoration(
                                spacing: 50,
                                labelStyle: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15.sp),
                                activeColor: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    _headingItem(
                        context: context,
                        title: 'Payment Method',
                        onTap: () { return null; }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Card(
                        child: Container(
                          height: 50.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),

                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _detailItem(context: context, icon:  AppAssets.icMasterSvg, detail: 'Credit Card'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [SizedBox(width: 52.w,),
                            Text('987788900987888',style: AppTheme.appTheme.textTheme.subtitle2!.copyWith(color: Colors.grey),)],)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: detailItem(
                          context: context, title: 'Sub Total', detail: 0988),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: detailItem(
                          context: context,
                          title: 'Delivery Charges',
                          detail: 0988),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: detailItem(
                          context: context,
                          title: 'Estimated Tax',
                          detail: 0988),
                    ),
                    const Divider(
                      thickness: 1,
                      indent: 8,
                      endIndent: 8,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: detailItem(
                          context: context, title: 'Total', detail: 0988),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ContinueButton(text: 'Checkout', onPressed: () {
                    context.read<HomeViewModel>().moveToStatus();
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _headingItem(
      {required BuildContext context,
      required String title,
      required Function? onTap()}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTheme.appTheme.textTheme.subtitle1!
                .copyWith(fontSize: 18.sp),
          ),
          TextButton(
              onPressed: onTap,
              child: Text(
                'Change',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppTheme.appTheme.primaryColor),
                textAlign: TextAlign.end,
              )),
        ],
      ),
    );
  }
  Widget _detailItem({required BuildContext context, required String icon,  required String detail}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: 18.w),
          Expanded(child: Text(detail, style: Theme.of(context).textTheme.bodyText2)),

        ],
      ),
    );
  }
}
