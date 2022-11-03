import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';

import '../../../../../core/constants/app_url.dart';
import '../../../../../core/utils/globals/globals.dart';

import '../../../../../core/widgets/custom/custom_app_bar.dart';
import '../../home_view_model/home_view_model.dart';
import 'Categories_page.dart';

class ProductsBySubCategoriesPage extends StatelessWidget {
  ProductsBySubCategoriesPage({Key? key}) : super(key: key);

  final HomeViewModel homeProvider = sl();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: homeProvider, child: ProductsBySubCategoriesPageContent());
  }
}

class ProductsBySubCategoriesPageContent extends StatefulWidget {
  ProductsBySubCategoriesPageContent({Key? key}) : super(key: key);
  @override
  State<ProductsBySubCategoriesPageContent> createState() =>
      _ProductsBySubCategoriesPageContentState();
}

class _ProductsBySubCategoriesPageContentState
    extends State<ProductsBySubCategoriesPageContent> {
  HomeViewModel homeViewModel = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar( title: 'Products',color: kCyanColor,),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssets.backgroundImagePNG),
              fit: BoxFit.cover),
        ),
        child: ValueListenableBuilder<bool>(
            valueListenable: context
                .read<HomeViewModel>()
                .isGotProductsBySubCategoryNotifier,
            builder: (_, value, __) {
              if (value) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [

                        Padding(
                          padding: EdgeInsets.only(left: 30.w, right: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                homeViewModel
                                    .getProductsBySubCategoriesResponseModel!
                                    .data
                                    .subcategory
                                    .name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                homeViewModel
                                    .getProductsBySubCategoriesResponseModel!
                                    .data
                                    .subcategory
                                    .description,
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black38),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                  height: 227.h,
                                  width: 350.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r),

                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0.r),
                                    child: Image.network(
                                      AppUrl.fileBaseUrl +
                                          homeViewModel
                                              .getProductsBySubCategoriesResponseModel!
                                              .data
                                              .subcategory
                                              .icon,
                                      fit: BoxFit.contain,
                                    ),
                                  )),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 50.h,),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 25.w),
                                child: Text(
                                  "Products",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                ),
                              ),
                            ),
                            homeViewModel
                                    .getProductsBySubCategoriesResponseModel!
                                    .data
                                    .products
                                    .isEmpty
                                ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text('No Product Found 😌',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                        'We are very sorry but this product is sold out',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),

                                  ],
                                )
                                : Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: GridView.builder(
                                        padding: EdgeInsets
                                            .zero, // set padding to zero,
                                        itemCount: homeViewModel
                                            .getProductsBySubCategoriesResponseModel!
                                            .data
                                            .products
                                            .length,

                                        // scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return GridTile(
                                            child: GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<HomeViewModel>()
                                                    .getProductById(
                                                        productId: homeViewModel
                                                            .getProductsBySubCategoriesResponseModel!
                                                            .data
                                                            .products[index]
                                                            .id);
                                                print(homeViewModel
                                                    .getProductsBySubCategoriesResponseModel!
                                                    .data
                                                    .products[index]
                                                    .id);
                                                context
                                                    .read<HomeViewModel>()
                                                    .moveToProductDetails();
                                              },
                                              child: productsList(
                                                context: context,
                                                leadingIcon: AppUrl
                                                        .fileBaseUrl +
                                                    homeViewModel
                                                        .getProductsBySubCategoriesResponseModel!
                                                        .data
                                                        .products[index]
                                                        .thumbnail,
                                                text: homeViewModel
                                                    .getProductsBySubCategoriesResponseModel!
                                                    .data
                                                    .products[index]
                                                    .title,
                                                amount: homeViewModel
                                                    .getProductsBySubCategoriesResponseModel!
                                                    .data
                                                    .products[index]
                                                    .price.toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 250.w,
                                                childAspectRatio: 1 / 1.4,
                                                crossAxisSpacing: 2.w,
                                                mainAxisSpacing: 1.w),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
