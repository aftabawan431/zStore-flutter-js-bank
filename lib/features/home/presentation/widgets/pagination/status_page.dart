import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/router/app_state.dart';
import 'package:zstore_flutter/core/utils/theme/app_theme.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/widgets/custom/continue_button.dart';
import '../../home_view_model/cart_provider.dart';
import '../../home_view_model/db_helper.dart';
import '../../home_view_model/home_view_model.dart';

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);

  final HomeViewModel homeProvider = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: homeProvider, child:  StatusScreenContent());
  }
}

class StatusScreenContent extends StatelessWidget {
   StatusScreenContent({Key? key}) : super(key: key);
HomeViewModel homeViewModel =sl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.hereItsComeImagePNG),
            Text('Your order is on its way.Your order',
                style: AppTheme.appTheme.textTheme.headline5!
                    .copyWith(fontSize: 16)),
            Text('Tracking id is ${homeViewModel.checkoutResponseModel!.data.trackingId}',
                style: AppTheme.appTheme.textTheme.headline5!
                    .copyWith(fontSize: 16)),
            SizedBox(
              height: 20.h,
            ),

            Text('Your order will arrive in next two days.',
                style: AppTheme.appTheme.textTheme.headline5!.copyWith(
                    fontSize: 20, color: AppTheme.appTheme.primaryColor)),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65),
              child: ContinueButton(
                  text: 'Continue ',
                  onPressed: () async {
                    CartProvider cartProvider = sl();
                    await cartProvider.delAll();
                    context.read<HomeViewModel>().moveToCheckout();
                  }),
            ),
            SizedBox(
              height: 100.h,
            )
          ],
        ),
      ),
    );
  }
}
