import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/constants/app_url.dart';
import 'package:zstore_flutter/features/home/presentation/home_view_model/home_view_model.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/theme/app_theme.dart';
import '../../../../../core/widgets/custom/custom_app_bar.dart';

enum RequestType { lamp, candle }

class CategoriesPage extends StatelessWidget {
  CategoriesPage({Key? key}) : super(key: key);

  HomeViewModel homeViewModel = sl();

  @override
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: homeViewModel, child: const CategoriesPageContent());
  }
}

class CategoriesPageContent extends StatefulWidget {
  const CategoriesPageContent({Key? key}) : super(key: key);

  @override
  State<CategoriesPageContent> createState() => _CategoriesPageContentState();
}

class _CategoriesPageContentState extends State<CategoriesPageContent> {
  RequestType selectedType = RequestType.lamp;
  HomeViewModel homeViewModel = sl();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Categories',
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
        child: ValueListenableBuilder<bool>(
            valueListenable:
                context.read<HomeViewModel>().isGotCategoriesByCatIdNotifier,
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
                                //  'Lamp Collection',
                                context
                                    .read<HomeViewModel>()
                                    .getSubCategoriesByCategoryIdResponseModel!
                                    .data
                                    .category
                                    .name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                context
                                    .read<HomeViewModel>()
                                    .getSubCategoriesByCategoryIdResponseModel!
                                    .data
                                    .category
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
                                          context
                                              .read<HomeViewModel>()
                                              .getSubCategoriesByCategoryIdResponseModel!
                                              .data
                                              .category
                                              .icon,
                                      fit: BoxFit.contain,
                                    ),
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                height: 35.h,
                                child: ListView.builder(
                                    itemCount: context
                                        .read<HomeViewModel>()
                                        .getSubCategoriesByCategoryIdResponseModel!
                                        .data
                                        .subcategories
                                        .length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              setState(() {
                                                currentIndex = index;
                                                print(context
                                                    .read<HomeViewModel>()
                                                    .getSubCategoriesByCategoryIdResponseModel!
                                                    .data
                                                    .subcategories
                                                    .elementAt(index)
                                                    .id);
                                                context
                                                    .read<HomeViewModel>()
                                                    .getProductsBySubCategory(
                                                        subCategoryId: context
                                                            .read<
                                                                HomeViewModel>()
                                                            .getSubCategoriesByCategoryIdResponseModel!
                                                            .data
                                                            .subcategories
                                                            .elementAt(index)
                                                            .id);
                                                context
                                                    .read<HomeViewModel>()
                                                    .isGotProductByIdNotifier
                                                    .value = false;
                                              });
                                            },
                                            style: OutlinedButton.styleFrom(
                                              backgroundColor:
                                                  currentIndex == index
                                                      ? AppTheme
                                                          .appTheme.primaryColor
                                                      : Colors.white,
                                              side: BorderSide(
                                                  width: 0.7,
                                                  color: AppTheme
                                                      .appTheme.primaryColor),
                                            ),
                                            child: Text(
                                              context
                                                  .read<HomeViewModel>()
                                                  .getSubCategoriesByCategoryIdResponseModel!
                                                  .data
                                                  .subcategories
                                                  .elementAt(index)
                                                  .name,
                                              //context.read<HomeViewModel>().getSubCategoriesByCategoryIdResponseModel!.data.subcategories.first.name,
                                              style: TextStyle(
                                                  color: currentIndex == index
                                                      ? Colors.white
                                                      : AppTheme.appTheme
                                                          .primaryColor,
                                                  fontSize: 12.sp),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 10.h,
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
                        child: ValueListenableBuilder<bool>(
                          valueListenable: context
                              .read<HomeViewModel>()
                              .isGotProductsBySubCategoryNotifier,
                          builder: (_, value, __) {
                            if (value) {
                              return Center(
                                  child: CircularProgressIndicator.adaptive(
                                backgroundColor: AppTheme.appTheme.primaryColor,
                              ));
                            } else {
                              return context
                                              .read<HomeViewModel>()
                                              .getProductsBySubCategoriesResponseModel ==
                                          null ||
                                      context
                                          .read<HomeViewModel>()
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
                                  : Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h,
                                                horizontal: 25.w),
                                            child: Text(
                                              context
                                                  .read<HomeViewModel>()
                                                  .getProductsBySubCategoriesResponseModel!
                                                  .data
                                                  .subcategory
                                                  .name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 5.w),
                                            child: GridView.builder(
                                              padding: EdgeInsets
                                                  .zero, // set padding to zero,
                                              itemCount: context
                                                  .read<HomeViewModel>()
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
                                                              productId: context
                                                                  .read<
                                                                      HomeViewModel>()
                                                                  .getProductsBySubCategoriesResponseModel!
                                                                  .data
                                                                  .products[
                                                                      index]
                                                                  .id);
                                                      print(context
                                                          .read<HomeViewModel>()
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
                                                          context
                                                              .read<
                                                                  HomeViewModel>()
                                                              .getProductsBySubCategoriesResponseModel!
                                                              .data
                                                              .products[index]
                                                              .thumbnail,
                                                      text: context
                                                          .read<HomeViewModel>()
                                                          .getProductsBySubCategoriesResponseModel!
                                                          .data
                                                          .products[index]
                                                          .title,
                                                      amount: context
                                                          .read<HomeViewModel>()
                                                          .getProductsBySubCategoriesResponseModel!
                                                          .data
                                                          .products[index]
                                                          .price
                                                          .toString(),
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
                                    );
                            }
                          },
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

Widget productsList(
    {required BuildContext context,
    required String leadingIcon,
    required String text,
    required String amount}) {
  return SizedBox(
    width: 160.w,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      color: Colors.white,
      elevation: 10,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                leadingIcon,
                fit: BoxFit.cover,
                height: 160.h,
              ),
            ),
          ),
          Expanded(
            child: Text(text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 12.sp,
                    )),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(amount,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent)),
        ],
      ),
    ),
  );
}
