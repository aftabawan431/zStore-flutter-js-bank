import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/features/home/presentation/widgets/pagination/shimmer_loading_pages/dashboard_shimmer_loading.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_url.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../home_view_model/home_view_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeViewModel homeViewModel = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: homeViewModel,
      builder: (context, snapshot) {
        return const HomePageContent();
      },
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  HomeViewModel homeViewModel = sl();
  @override
  void initState() {
    getValues();
    super.initState();
  }

  getValues() async {
    await homeViewModel.getCategoriesAndProductsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssets.backgroundImagePNG),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: ValueListenableBuilder<bool>(
              valueListenable: homeViewModel.isGotDetailsNotifier,
              builder: (context, loading, ch) {
                if (loading) {
                  return const DashboardShimmerLoading();
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 5.h),
                        child: Container(
                          height: 80.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0.r),
                            child: Image.asset(
                              AppAssets.mountainlandscapePNG,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      barContainer(),
                      SizedBox(
                        height: 10.h,
                      ),
                      titleText(
                        context: context,
                        title: 'Trends',
                      ),
                      SizedBox(
                        height: 170.h,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: ListView.builder(
                            itemCount: homeViewModel
                                .dashboardDetails!.data.products.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  context.read<HomeViewModel>().getProductById(
                                      productId: homeViewModel.dashboardDetails!
                                          .data.products[index].id);
                                  context
                                      .read<HomeViewModel>()
                                      .moveToProductDetails();
                                },
                                child: imageListView(
                                    image: AppUrl.fileBaseUrl +
                                        homeViewModel.dashboardDetails!.data
                                            .products[index].thumbnail),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      titleText(context: context, title: 'Shop Collection'),
                      SizedBox(
                        width: double.infinity,
                        height: 300.h,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeViewModel
                              .dashboardDetails!.data.subcategories.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250.w,
                                  childAspectRatio: 3 / 3.1,
                                  crossAxisSpacing: 2.w,
                                  mainAxisSpacing: 1.w),
                          itemBuilder: (context, index) {
                            return GridTile(
                                child: subCategories(
                                    context: context,
                                    image: AppUrl.fileBaseUrl +
                                        homeViewModel.dashboardDetails!.data
                                            .subcategories[index].icon,
                                    mainTitle: homeViewModel.dashboardDetails!
                                        .data.subcategories[index].name,
                                    subtitle: homeViewModel.dashboardDetails!
                                        .data.subcategories[index].description,
                                    onPressed: () {
                                      context
                                          .read<HomeViewModel>()
                                          .getProductsBySubCategory(
                                              subCategoryId: homeViewModel
                                                  .dashboardDetails!
                                                  .data
                                                  .subcategories[index]
                                                  .id);
                                      print("this is id of subcategory " +
                                          context
                                              .read<HomeViewModel>()
                                              .dashboardDetails!
                                              .data
                                              .subcategories[index]
                                              .id);
                                      context
                                          .read<HomeViewModel>()
                                          .moveToProductsBySubCategoriesPage();
                                    }));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                            height: 7.h,
                            thickness: 5,
                            indent: 20,
                            endIndent: 5,
                            color: Color(0xFF1CB5B5),
                          )),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                              padding: const EdgeInsets.only(right: 40),
                              child: Text(
                                "Categories",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              )),
                        ],
                      ),
                      SizedBox(
                        // width: double.infinity,
                        height: 100.h,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeViewModel
                              .dashboardDetails!.data.categories.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250.w,
                                  childAspectRatio: 1 / 2.5,
                                  crossAxisSpacing: 2.w,
                                  mainAxisSpacing: 1.w),
                          itemBuilder: (context, index) {
                            return GridTile(
                              child: categoryCard(
                                context: context,
                                image: AppUrl.fileBaseUrl +
                                    homeViewModel.dashboardDetails!.data
                                        .categories[index].icon,
                                title: homeViewModel.dashboardDetails!.data
                                    .categories[index].name,
                                onPressed: () async {
                                  homeViewModel.getSubCategoriesByCategoryId(
                                      categoryId: homeViewModel
                                          .dashboardDetails!
                                          .data
                                          .categories[index]
                                          .id);

                                  print("this is error" +
                                      homeViewModel.dashboardDetails!.data
                                          .subcategories[index].id);
                                  await homeViewModel.getProductsBySubCategory(
                                      subCategoryId: homeViewModel
                                          .dashboardDetails!
                                          .data
                                          .subcategories[index]
                                          .id);

                                  context
                                      .read<HomeViewModel>()
                                      .moveToCategoriesPage();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget categoryCard(
      {required BuildContext context,
      required String image,
      required VoidCallback? onPressed,
      required String title}) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: SizedBox(
            height: 100.h,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r), // Image border
                  child: Container(
                    width: 80.w,
                   child: CachedNetworkImage(
                        placeholder: (context, url) =>   Container(
                          width: 80.w,
                          color: Colors.grey.withOpacity(.3),
                        ),
                        imageUrl:image,
                        fit: BoxFit.fill
                    ),

                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget barContainer() {
    return SizedBox(
      width: 250.w,
      height: 30.h,
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search,
            color: Color(0xFF1CB5B5),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.r),
            borderSide: const BorderSide(
              color: Color(0xFF989393),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.r),
            borderSide: BorderSide(
              color: const Color(0xFF989393),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.r),
            borderSide: const BorderSide(
              color: Color(0xFF989393),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.r),
            borderSide: const BorderSide(
              color: Color(0xFF989393),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageListView({required String image}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: SizedBox.fromSize(
              child: SizedBox(
            width: 130.w,
            child: CachedNetworkImage(
              placeholder: (context, url) =>   Container(
                width: 130.w,
                color: Colors.grey.withOpacity(.3),
              ),
              imageUrl:image,
                fit: BoxFit.fill
            ),
          ))),
    );
  }

  Widget titleText({
    required BuildContext context,
    required String title,
  }) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 20),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold)),
    );
  }

  Widget subCategories({
    required BuildContext context,
    required String image,
    required String mainTitle,
    required String subtitle,
    required VoidCallback? onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 150.h,
            width: 150.w,
            child: SizedBox.fromSize(
              child:CachedNetworkImage(
                  placeholder: (context, url) =>   Container(
                      height: 150.h,
                      width: 150.w,
                    color: Colors.grey.withOpacity(.3),
                  ),
                  imageUrl:image,
                  fit: BoxFit.fill
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              alignment: Alignment.center,
              width: 130.w,
              color: Colors.black.withOpacity(0.6),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      mainTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 8.sp,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 8.sp,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      width: 80.w,
                      height: 20.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: onPressed,
                        child: Text(
                          'Buy Now',
                          style: TextStyle(fontSize: 8.sp, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          //),
        ],
      ),
    );
  }
}
