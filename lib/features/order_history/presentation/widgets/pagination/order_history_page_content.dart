import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zstore_flutter/features/order_history/presentation/widgets/pagination/cardclass.dart';
import '../../../../../core/constants/app_url.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/widgets/custom/custom_app_bar.dart';
import '../../order_history_view_model/order_history_view_model.dart';

class OrderHistoryPage extends StatelessWidget {
  OrderHistoryPage({Key? key}) : super(key: key);
  final OrderHistoryViewModel orderHistoryViewModel = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: orderHistoryViewModel,
      child: const OrderHistoryPageContent(),
    );
  }
}

class OrderHistoryPageContent extends StatefulWidget {
  const OrderHistoryPageContent({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPageContent> createState() =>
      _OrderHistoryPageContentState();
}

class _OrderHistoryPageContentState extends State<OrderHistoryPageContent> {
  final OrderHistoryViewModel orderHistoryViewModel = sl();

  @override
  void initState() {
    orderHistoryViewModel.getOrderHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Order History',
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ValueListenableBuilder<bool>(
              valueListenable: context
                  .read<OrderHistoryViewModel>()
                  .isGotOrderHistoryNotifier,
              builder: (context, loading, __) {
                if (loading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else {
                  return orderHistoryViewModel.getOrderHistoryResponseModel ==
                              null ||
                          orderHistoryViewModel
                              .getOrderHistoryResponseModel!.data.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text('No Order Found Yet 😌',
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                                'Explore products and shop your\nfavourite items',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subtitle2),
                          ],
                        )
                      : Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ValueListenableBuilder<bool>(
                                valueListenable: orderHistoryViewModel
                                    .isClearOrderHistoryNotifier,
                                builder: (context, loading, __) {
                                  return GestureDetector(
                                    onTap: () {
                                      orderHistoryViewModel.clearOrderHistory();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      child: const Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          'Clear All History',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            Expanded(
                              child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: orderHistoryViewModel
                                          .getOrderHistoryResponseModel!
                                          .data
                                          .length,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(), // new

                                      itemBuilder: (_, index) {
                                        return Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: GestureDetector(
                                              child: SizedBox(
                                                height: 85.h,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                      color: Color(0xFFC6F5F5),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0.r),
                                                  ),
                                                  child: zStoreCard(
                                                    context: context,
                                                    leadingIcon: AppUrl.fileBaseUrl+
                                                    orderHistoryViewModel
                                                        .getOrderHistoryResponseModel!
                                                        .data[index].thumbnail,
                                                    titleOrder: 'Order ID',
                                                    titlePlacedOn: 'Placed On',
                                                    titleStatus: 'Status',
                                                    subtitleOrderId:
                                                        orderHistoryViewModel
                                                            .getOrderHistoryResponseModel!
                                                            .data[index]
                                                            .orderId,
                                                    subtitleDate:
                                                        orderHistoryViewModel
                                                            .getOrderHistoryResponseModel!
                                                            .data[index]
                                                            .placedOn,
                                                    subtitleStatus:
                                                        orderHistoryViewModel
                                                            .getOrderHistoryResponseModel!
                                                            .data[index]
                                                            .status,
                                                  ),
                                                ),
                                              ),
                                              onTap: () async{
                                              await  orderHistoryViewModel.getOrderHistoryDetails(orderId: orderHistoryViewModel
                                                    .getOrderHistoryResponseModel!
                                                    .data[index].id);

                                                context
                                                    .read<
                                                        OrderHistoryViewModel>()
                                                    .moveToOrderHistoryDetailPage();
                                              },
                                            ));
                                      })),
                            )
                          ],
                        );
                }
              }),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
