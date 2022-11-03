import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/widgets/custom/continue_button.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/theme/app_theme.dart';
import '../../../../../core/widgets/custom/custom_app_bar.dart';
import '../../home_view_model/cart_provider.dart';
import '../../home_view_model/db_helper.dart';
import '../../home_view_model/home_view_model.dart';

class AddToCartPage extends StatelessWidget {
  AddToCartPage({Key? key}) : super(key: key);

  final HomeViewModel homeProvider = sl();
  CartProvider cartProvider = sl();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: homeProvider,
        ),
        ChangeNotifierProvider.value(
          value: cartProvider,
        ),
      ],
      child: AddToCartScreenContent(),
    );
  }
}

class AddToCartScreenContent extends StatefulWidget {
  AddToCartScreenContent({Key? key}) : super(key: key);

  @override
  State<AddToCartScreenContent> createState() => _AddToCartScreenContentState();
}

class _AddToCartScreenContentState extends State<AddToCartScreenContent> {
  DBHelper dbHelper = sl();
  CartProvider cart = sl();
  @override
  void initState() {
    cart.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.backgroundImagePNG),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<CartProvider>(builder: (_, cartProvider, __) {
          return ValueListenableBuilder<bool>(
              valueListenable: context.read<CartProvider>().isLoadingNotifier,
              builder: (_, val, __) {
                if (val) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else {
                  if (cartProvider.cart.isEmpty) {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text('Your cart is empty 😌',
                              style: Theme.of(context).textTheme.headline6),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              'Explore products and shop your\nfavourite items',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle2)
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          height: 572.h,
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
                                // SizedBox(height: 30.h),
                                // zStoreMenuAppBar(context: context,   title: 'Add to Cart',),
                                SizedBox(height: 10.h),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Select Quantity',
                                    style: AppTheme
                                        .appTheme.textTheme.subtitle1!
                                        .copyWith(fontSize: 20.sp),
                                  ),
                                ),

                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  // removeBottom: true,
                                  child: ListView.builder(
                                      itemCount: cartProvider.cart.length,
                                      shrinkWrap: true,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Card(
                                            elevation: 5,
                                            // borderRadius: BorderRadius.circular(10.r),
                                            child: Container(
                                              height: 90.h,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50.r),
                                                              ),
                                                              height: 90.h,
                                                              width: 80.w,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r),
                                                                child: Image
                                                                    .network(
                                                                  cartProvider
                                                                      .cart[
                                                                          index]
                                                                      .image
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              cartProvider
                                                                  .cart[index]
                                                                  .productName
                                                                  .toString(),
                                                              style: AppTheme
                                                                  .appTheme
                                                                  .textTheme
                                                                  .subtitle2!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14.sp),
                                                            ),
                                                            // Text(
                                                            //   'Candle Lamp',
                                                            //   style: AppTheme
                                                            //       .appTheme
                                                            //       .textTheme
                                                            //       .subtitle2!
                                                            //       .copyWith(
                                                            //     fontSize: 14.sp,
                                                            //   ),
                                                            // ),
                                                            Text(
                                                              '${cartProvider.cart[index].productPrice! * cartProvider.cart[index].quantity!} Rs',
                                                              style: AppTheme
                                                                  .appTheme
                                                                  .textTheme
                                                                  .subtitle2!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Colors
                                                                          .black54),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                  Row(
                                                    children: [
                                                      const VerticalDivider(
                                                        width: 20,
                                                        thickness: 1,
                                                        indent: 8,
                                                        endIndent: 8,
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                cartProvider
                                                                    .addQuantity(
                                                                        index);
                                                              },
                                                              child: Container(
                                                                height: 20.h,
                                                                width: 20.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.r),
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 16.sp,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              cartProvider
                                                                  .cart[index]
                                                                  .quantity
                                                                  .toString(),
                                                              style: AppTheme
                                                                  .appTheme
                                                                  .textTheme
                                                                  .subtitle2!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14.sp),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                cartProvider
                                                                    .removeQuantity(
                                                                        index);
                                                              },
                                                              child: Container(
                                                                height: 20.h,
                                                                width: 20.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.r),
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 15.sp,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Expanded(child: Container()),
                                const Divider(
                                  thickness: 1,
                                  indent: 8,
                                  endIndent: 8,
                                  color: Colors.grey,
                                ),

                                Consumer<CartProvider>(
                                    builder: (context, value, child) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: detailItem(
                                            context: context,
                                            title: 'Delivery Charges',
                                            detail: 230),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: detailItem(
                                          context: context,
                                          title: 'Total',
                                          detail: cartProvider
                                              .getTotalPriceReduced(),
                                        ),
                                      )
                                    ],
                                  );
                                }),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ContinueButton(
                                  text: 'Checkout',
                                  onPressed: () {
                                    context
                                        .read<HomeViewModel>()
                                        .addressController
                                        .clear();
                                    // dbHelper.deleteAll();
                                    // cartProvider.deleteAll();
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => const OrderTrackingPage()),
                                    // );
                                    // var json=jsonEncode(cartProvider.cart
                                    //     .map((e) => Product(
                                    //     productId: e.productId!,
                                    //     quantity: e.quantity.toString(),
                                    //     price: e.productPrice!,
                                    //     sku: e.sku!))
                                    //     .toList());
                                    // print(json);
                                    context
                                        .read<HomeViewModel>()
                                        .moveToNewShipping();
                                  }),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                }
              });
        }));
  }
}
