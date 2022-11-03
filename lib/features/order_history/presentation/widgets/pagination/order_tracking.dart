import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/widgets/custom/custom_app_bar.dart';
import '../../order_history_view_model/order_history_view_model.dart';


class TrackingOrderPage extends StatelessWidget {
  TrackingOrderPage({Key? key}) : super(key: key);
  final OrderHistoryViewModel trackOrder = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: trackOrder, child: const OrderTrackingPageContent(),);
  }
}
class OrderTrackingPageContent extends StatelessWidget {
  const OrderTrackingPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssets.backgrounddarkImagePNG),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(height: 30.h,),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: zStoreAppBar(context: context,   title: 'Order Tracking', leadingIcon: '',),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 180, 10),
              child:ListView(
shrinkWrap: true,
                children: [

                  Container(
                    padding: EdgeInsets.fromLTRB(10, 3, 0, 3),
                    child:
                    Text('Choose your Partner',
                      style:Theme.of(context)
                          .textTheme.bodySmall
                          ?.copyWith(fontSize: 16.sp,color: Colors.black54,fontWeight: FontWeight.bold),
                      ) ,),
                   SizedBox(height: 30.h,),
                  _orderTrackingCard(context: context, imageIcon: AppAssets.icTcsSvg),
                  _orderTrackingCard(context: context, imageIcon: AppAssets.icFedexSvg),
                  _orderTrackingCard(context: context, imageIcon: AppAssets.icSpeedexSvg),
                  _orderTrackingCardPng(context: context, imageIconPng: AppAssets.mPPNG),
                  _orderTrackingCardPng(context: context, imageIconPng: AppAssets.leopardPNG),
                  _orderTrackingCardPng(context: context, imageIconPng: AppAssets.dhlPNG),
                  _orderTrackingCardPng(context: context, imageIconPng: AppAssets.dcsPNG),
                 // Image.asset(AppAssets.mPPNG,),



                ],
              ),),
          ],
        ),
      ),

    );
  }
  Widget _orderTrackingCard({required BuildContext  context,required String imageIcon,}) {
    return Column(
      children:[
        SizedBox(height: 10.h,),
        SvgPicture.asset(imageIcon,),

        SizedBox(height: 10.h,),
        const Divider(color: Color(0xFFC6F5F5),
          thickness: 2,
          endIndent: 10,
          indent: 14,),
      ],

    );


  }

  Widget _orderTrackingCardPng({required BuildContext  context,required String imageIconPng,}) {
    return Column(
      children:[
SizedBox(height: 10.h,),
       Image.asset(imageIconPng,),
        SizedBox(height: 10.h,),
        const Divider(color: Color(0xFFC6F5F5),
          thickness: 2,
          endIndent: 10,
          indent: 14,),
      ],

    );


  }

}

