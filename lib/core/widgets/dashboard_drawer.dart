import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_view_model/authentication_view_model.dart';
import 'package:zstore_flutter/features/home/presentation/home_view_model/cart_provider.dart';
import 'package:zstore_flutter/features/home/presentation/home_view_model/db_helper.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../features/dashboard/presentation/dashboard_view_model/dashboard_view_model.dart';
import '../router/app_state.dart';
import '../router/models/page_action.dart';
import '../router/models/page_config.dart';
import '../utils/enums/page_state_enum.dart';

class DashboardDrawerMenuWidget extends StatelessWidget {
  DashboardDrawerMenuWidget({Key? key}) : super(key: key);
  final DashboardViewModel menu = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: menu,
      child: DashboardDrawerMenuWidgetContent(),
    );
  }
}

class DashboardDrawerMenuWidgetContent extends StatelessWidget {
  DashboardDrawerMenuWidgetContent({Key? key}) : super(key: key);
  AppState appState = GetIt.I.get<AppState>();
  AuthViewModel authViewModel = sl();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150.h,
        ),
        _orderHistoryCard(
            context: context,
            leadingicon: AppAssets.historyImagePNG,
            title: 'ORDER HISTORY',
            onTap: () {
              appState.currentAction = PageAction(
                  state: PageState.addPage,
                  page: PageConfigs.orderHistoryConfig);
            }),
        _orderHistoryCard(
            context: context,
            leadingicon: AppAssets.pointImagePNG,
            title: 'MY POINTS',
            onTap: () {
              appState.currentAction = PageAction(
                  state: PageState.addPage, page: PageConfigs.myPointsConfig);
            }),
        _orderHistoryCard(
            context: context,
            leadingicon: AppAssets.membershipImagePNG,
            title: 'MY MEMBERSHIP',
            onTap: () {
              appState.currentAction = PageAction(
                  state: PageState.addPage,
                  page: PageConfigs.myMembershipScreenPage);
            }),
        _orderHistoryCard(
            context: context,
            leadingicon: AppAssets.trackingImagePNG,
            title: 'ORDER TRACKING',
            onTap: () {
              appState.currentAction = PageAction(
                  state: PageState.addPage,
                  page: PageConfigs.orderTrackingPageConfig);
            }),
        // _orderHistoryCard(
        //     context: context,
        //     leadingicon: AppAssets.reviewsImagePNG,
        //     title: 'REVIEWS',
        //     onTap: () {
        //       appState.currentAction = PageAction(
        //           state: PageState.addPage, page: PageConfigs.reviewScreenPage);
        //     }),
        _orderHistoryCard(
            context: context,
            leadingicon: AppAssets.feedbackImagePNG,
            title: 'FEEDBACK',
            onTap: () {
              appState.currentAction = PageAction(
                  state: PageState.addPage, page: PageConfigs.feedbackConfig);
            }),
        _orderHistoryCard(
            context: context,
            leadingicon: AppAssets.orderImagePNG,
            title: 'LogOut',
            onTap: () async {
           await _showMyDialog(context);
            }),
      ],
    );
  }

  Widget _orderHistoryCard({
    required BuildContext context,
    required String leadingicon,
    required String title,
    required Function onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFC6F5F5),
            radius: 20.r,
            child: Image.asset(leadingicon),
          ),
          title: GestureDetector(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: Colors.black),
            ),
          ),
          onTap: () {
            onTap();
          },
        ),
        const Divider(
          color: Color(0xFFE7F0F0),
          thickness: 2,
          endIndent: 70,
          indent: 14,
        ),
      ],
    );
  }
  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: SvgPicture.asset(AppAssets.icZstoreLogoSvg),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'Would you like to Logout?',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child:  Text('Yes',style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).primaryColor)),
                onPressed: () async {
                  print('Confirmed');
                  DBHelper db = sl();
                  await db.deleteAll();
                  authViewModel.logoutUser(context);
                  appState.currentAction = PageAction(
                      state: PageState.replaceAll,
                      page: PageConfigs.loginPageConfig);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child:  Text('No',style: TextStyle(color: Colors.red),),
                onPressed: () {
                  print('Cancel');
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

}
