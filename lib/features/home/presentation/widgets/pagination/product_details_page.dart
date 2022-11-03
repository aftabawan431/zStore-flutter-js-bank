import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:zstore_flutter/core/utils/extension/extensions.dart';
import 'package:zstore_flutter/features/my_favrouits/presentation/my_favrouits_view_model/my_favrouits_view_model.dart';
import 'package:zstore_flutter/features/reviews/presentation/reviews_view_model/reviews_view_model.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_url.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/globals/show_app_bar.dart';
import '../../../../../core/utils/theme/app_theme.dart';
import '../../../../../core/widgets/custom/custom_app_bar.dart';
import '../../../data/models/cart_model.dart';
import '../../../data/models/get_product_by_id_response_model.dart';
import '../../home_view_model/cart_provider.dart';
import '../../home_view_model/db_helper.dart';
import '../../home_view_model/home_view_model.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({Key? key}) : super(key: key);

  final HomeViewModel homeProvider = sl();
  FavouriteViewModel favouriteViewModel = sl();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: homeProvider),
      ChangeNotifierProvider.value(value: favouriteViewModel),
    ], child: ProductDetailsScreenContent());
  }
}

class ProductDetailsScreenContent extends StatefulWidget {
  ProductDetailsScreenContent({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreenContent> createState() =>
      _ProductDetailsScreenContentState();
}

class _ProductDetailsScreenContentState
    extends State<ProductDetailsScreenContent> {
  HomeViewModel homeViewModel = sl();
  int colorIndex = 0;
  FavouriteViewModel favouriteViewModel = sl();
  @override
  void initState() {
    context.read<HomeViewModel>().onErrorMessage = (value) => context.show(
        message: value.message, backgroundColor: value.backgroundColor);

    favouriteViewModel.getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Product Details',
        color: Colors.white,
      ),
      backgroundColor: Color(0xFFE1F5F5),
      body: ValueListenableBuilder<bool>(
          valueListenable:
              context.read<HomeViewModel>().isGotProductByIdNotifier,
          builder: (_, value, __) {
            if (value) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else {
              return ValueListenableBuilder<Variant?>(
                  valueListenable:
                      context.read<HomeViewModel>().additionalDescription,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 180.h,
                    ),
                    child: Html(
                      data: homeViewModel
                          .getProductByIdResponseModel!.data.description,
                    ),
                  ),
                  builder: (_, selected, ch) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
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
                                  SizedBox(height: 10.h),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.w, bottom: 5.h),
                                    child: Text(
                                      homeViewModel.getProductByIdResponseModel!
                                          .data.subcategory.name,
                                      style: AppTheme
                                          .appTheme.textTheme.headline6!
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 300.h,
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                        height: 300.h,
                                        enableInfiniteScroll: true,
                                        reverse: false,
                                        autoPlay: true,
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                      items: homeViewModel
                                          .getProductByIdResponseModel!
                                          .data
                                          .images
                                          .map<Widget>((i) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return SizedBox(
                                                height: 200.h,
                                                width: double.infinity,
                                                child: CachedNetworkImage(
                                                    placeholder: (context,
                                                            url) =>
                                                        Container(
                                                          color: Colors.grey
                                                              .withOpacity(.3),
                                                        ),
                                                    imageUrl:
                                                        AppUrl.fileBaseUrl + i,
                                                    fit: BoxFit.contain));
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: Text(
                                        homeViewModel
                                            .getProductByIdResponseModel!
                                            .data
                                            .title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                  Row(
                                    children: [
                                      homeViewModel.getProductByIdResponseModel!
                                                  .data.inStock ==
                                              true
                                          ? Text(
                                              ' In Stock',
                                              style: AppTheme
                                                  .appTheme.textTheme.subtitle2!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color: Colors.green),
                                            )
                                          : Text(
                                              ' Not In Stock',
                                              style: AppTheme
                                                  .appTheme.textTheme.subtitle2!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color: Colors.red),
                                            ),
                                      Expanded(child: Container()),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            child: const Text(
                                              'See Reviews',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            onTap: () {
                                              ReviewsViewModel reviewViewModel =
                                                  sl();
                                              print(
                                                  'this is actual product id ${homeViewModel.getProductByIdResponseModel!.data.id}');
                                              reviewViewModel.getAllReviews(
                                                  productId: homeViewModel
                                                      .getProductByIdResponseModel!
                                                      .data
                                                      .id);
                                              homeViewModel.moveToReviews();
                                            },
                                          ),
                                          Row(
                                            children: [
                                              RatingBarIndicator(
                                                rating: homeViewModel
                                                    .getProductByIdResponseModel!
                                                    .data
                                                    .ratingNumber
                                                    .toDouble(),
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                                direction: Axis.horizontal,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5.w, right: 5.w),
                                                child: Text(
                                                  homeViewModel
                                                      .getProductByIdResponseModel!
                                                      .data
                                                      .ratingCount
                                                      .toString(),
                                                  style: AppTheme.appTheme
                                                      .textTheme.subtitle2!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          color: Colors.black,
                                                          fontSize: 14.sp),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  ch!,
                                  Selector<HomeViewModel, int>(
                                    selector: (_, provider) =>
                                        provider.sizeIndex,
                                    builder: (_, myVal, __) {
                                      return selected!.size.isNotEmpty
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10.h),
                                              child: Row(
                                                children: [
                                                  Text('Choose a size: ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6),
                                                  SizedBox(
                                                    height: 40.h,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          selected.size.length,
                                                      itemBuilder:
                                                          (_, int index) {
                                                        return GestureDetector(
                                                            onTap: () {
                                                              homeViewModel
                                                                  .setSize(
                                                                      index);
                                                              homeViewModel.size = selected
                                                                  .size[
                                                              index];
                                                              print(homeViewModel.size);
                                                            },
                                                            child: Card(
                                                              color: myVal ==
                                                                      index
                                                                  ? Colors.grey
                                                                      .withOpacity(
                                                                          .1)
                                                                  : Colors
                                                                      .white,
                                                              child: SizedBox(
                                                                width: 40.w,
                                                                child: Center(
                                                                  child: Text(
                                                                      selected
                                                                          .size[
                                                                              index]
                                                                          .toString(),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline6),
                                                                ),
                                                              ),
                                                            ));
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container();
                                    },
                                  ),
                                  selected!.colorHex.isNotEmpty
                                      ? Row(
                                          children: [
                                            Text('Color: ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5.w),
                                              child: SizedBox(
                                                height: 30.h,
                                                // width: 20.w,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: homeViewModel
                                                        .getProductByIdResponseModel!
                                                        .data
                                                        .variant
                                                        .length,
                                                    itemBuilder: (_, index) {
                                                      return Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              context
                                                                  .read<
                                                                      HomeViewModel>()
                                                                  .additionalDescription
                                                                  .value = homeViewModel
                                                                      .getProductByIdResponseModel!
                                                                      .data
                                                                      .variant[
                                                                  index];

                                                              colorIndex =
                                                                  index;
                                                            },
                                                            child: colorIndex ==
                                                                    index
                                                                ? SimpleShadow(
                                                                    offset:
                                                                        Offset(
                                                                            2,
                                                                            2),
                                                                    sigma: 3,
                                                                    opacity:
                                                                        0.7,
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          30.w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Color(
                                                                            int.parse('0xff${homeViewModel.getProductByIdResponseModel!.data.variant[index].colorHex.split('#').last}')),
                                                                      ),
                                                                    ))
                                                                : Container(
                                                                    width: 22.w,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Color(
                                                                          int.parse(
                                                                              '0xff${homeViewModel.getProductByIdResponseModel!.data.variant[index].colorHex.split('#').last}')),
                                                                    ),
                                                                  ),
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          )
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 40.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rs. ${selected!.actualPrice.toString()}',
                                        style: AppTheme
                                            .appTheme.textTheme.headline6!
                                            .copyWith(
                                          fontSize: 16.sp,
                                          color: Colors.black54,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 2.w),
                                        child: Text(
                                          'Rs.${selected!.discountedPrice.toString()}',
                                          style: AppTheme
                                              .appTheme.textTheme.headline6!
                                              .copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Consumer2<HomeViewModel,
                                              FavouriteViewModel>(
                                          builder: (context, provider,
                                              Provider2, ch) {
                                        return IconButton(
                                          iconSize: 30.sp,
                                          icon: Icon(
                                            Provider2.getFavoritesResponseModel!
                                                        .data
                                                        .indexWhere((e) =>
                                                            e.product.id ==
                                                            homeViewModel
                                                                .getProductByIdResponseModel!
                                                                .data
                                                                .id) ==
                                                    -1
                                                ? Icons.favorite_border
                                                : Icons.favorite,
                                            color: Colors.redAccent,
                                          ),
                                          onPressed: () {
                                            Provider2.addToFavourite(
                                                productId: homeViewModel
                                                    .getProductByIdResponseModel!
                                                    .data
                                                    .id);
                                          },
                                        );
                                      }),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          DBHelper? dbHelper = DBHelper();
                                          print(homeViewModel
                                              .getProductByIdResponseModel!
                                              .data
                                              .name);
                                          dbHelper
                                              .insert(Cart(
                                            productId: homeViewModel
                                                .getProductByIdResponseModel!
                                                .data
                                                .id,
                                            productName: homeViewModel
                                                .getProductByIdResponseModel!
                                                .data
                                                .name,
                                            productPrice:
                                                selected!.discountedPrice,
                                            quantity: 1,
                                            image: AppUrl.fileBaseUrl +
                                                homeViewModel
                                                    .getProductByIdResponseModel!
                                                    .data
                                                    .thumbnail,
                                            sku: selected!.sku,
                                          ))
                                              .then((value) {
                                            cart.addCounter();
                                            ShowSnackBar.show(
                                                'Product is added to cart');
                                          }).onError((error, stackTrace) {
                                            print("error" + error.toString());
                                            ShowSnackBar.show(
                                                'Product is already added in cart',
                                                color: Colors.red);
                                          });
                                        },
                                        child: Container(
                                            height: 40.h,
                                            width: 140.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: AppTheme
                                                  .appTheme.primaryColor,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: AppTheme
                                                        .appTheme.primaryColor,
                                                    spreadRadius: 3),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SvgPicture.asset(
                                                  AppAssets.icCartSvg,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  'Add To Cart',
                                                  style: AppTheme.appTheme
                                                      .textTheme.subtitle2!
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
