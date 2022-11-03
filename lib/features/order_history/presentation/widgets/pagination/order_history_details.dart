import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zstore_flutter/features/order_history/presentation/widgets/pagination/cardclass.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_url.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/widgets/custom/custom_app_bar.dart';
import '../../order_history_view_model/order_history_view_model.dart';

class OrderHistoryDetailPage extends StatelessWidget {
  OrderHistoryDetailPage({Key? key}) : super(key: key);
  final OrderHistoryViewModel orderHistory = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: orderHistory,
      child:  OrderHistoryDetailPageContent(),
    );
  }
}

class OrderHistoryDetailPageContent extends StatelessWidget {
   OrderHistoryDetailPageContent({Key? key}) : super(key: key);
  final OrderHistoryViewModel orderHistoryViewModel = sl();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ORDER HISTORY Details',
        color: kCyanColor,
      ),
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.backgroundImagePNG),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ValueListenableBuilder<bool>(
                valueListenable: context
                    .read<OrderHistoryViewModel>()
                    .isGotOrderHistoryDetailsNotifier,
                builder: (context, loading, __) {
                  if (loading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }else{
                    return orderHistoryViewModel.getOrderHistoryDetailsResponseModel ==
                        null ||
                        orderHistoryViewModel
                            .getOrderHistoryDetailsResponseModel!.data.product.isEmpty
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text('No Order Details Found Yet 😌',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    )
                        :Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 85.h,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: Color(0xFFC6F5F5),
                                      ),
                                      borderRadius: BorderRadius.circular(15.0.r),
                                    ),
                                    child: zStoreCard(
                                      context: context,
                                      leadingIcon: AppUrl.fileBaseUrl+
                                          orderHistoryViewModel
                                              .getOrderHistoryDetailsResponseModel!
                                              .data.productThumbnail,
                                      titleOrder: 'Order ID',
                                      titlePlacedOn: 'Placed On',
                                      titleStatus: 'Status',
                                      subtitleOrderId:
                                      orderHistoryViewModel
                                          .getOrderHistoryDetailsResponseModel!
                                          .data.id,
                                      subtitleDate:
                                      orderHistoryViewModel
                                          .getOrderHistoryDetailsResponseModel!
                                          .data.placedOn,
                                      subtitleStatus:
                                      orderHistoryViewModel
                                          .getOrderHistoryDetailsResponseModel!
                                          .data.status,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Text(
                                  'Order Details',
                                  style:
                                  Theme.of(context).textTheme.headline6?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                    color: const Color(0xFF1CB5B5),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: orderHistoryViewModel
                                      .getOrderHistoryDetailsResponseModel!
                                      .data.product.length,
                              itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        height: 140.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.r),
                                          color: const Color(0xFFC6F5F5).withOpacity(0.2),
                                          border: Border.all(
                                            color: const Color(
                                                0xFFC6F5F5), // red as border color
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              detailItem(
                                                  context: context,
                                                  title: 'Category',
                                                  detail:  orderHistoryViewModel
                                                      .getOrderHistoryDetailsResponseModel!
                                                      .data.product[index].productCategory,),
                                              detailItem(
                                                  context: context,
                                                  title: 'Product',
                                                  detail:  orderHistoryViewModel
                                                      .getOrderHistoryDetailsResponseModel!
                                                      .data.product[index].productName,),
                                              detailItem(
                                                  context: context,
                                                  title: 'Quantity',
                                                  detail: orderHistoryViewModel
                                                      .getOrderHistoryDetailsResponseModel!
                                                      .data.product[index].quantity.toString(),),
                                              detailItem(
                                                  context: context,
                                                  title: 'Price',
                                                  detail:  orderHistoryViewModel
                                                      .getOrderHistoryDetailsResponseModel!
                                                      .data.product[index].productPrice.toString(),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }

              }
            ),
          )),
    );
  }

  Widget detailItem(
      {required BuildContext context,
      required String title,
      required String detail}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(title, style: Theme.of(context).textTheme.bodyText2)),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(detail,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.grey),
                  textAlign: TextAlign.end),
            ),
          ),
        ],
      ),
    );
  }
}
