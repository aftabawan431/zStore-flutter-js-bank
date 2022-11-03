import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';
import 'package:zstore_flutter/core/constants/app_url.dart';
import 'package:zstore_flutter/features/my_favrouits/presentation/widgets/my_favorites_loading_item.dart';
import '../../../../core/utils/globals/globals.dart';
import '../my_favrouits_view_model/my_favrouits_view_model.dart';
class MyFavouritePage extends StatelessWidget {
  MyFavouritePage({Key? key}) : super(key: key);
  final FavouriteViewModel _favProvider = sl();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _favProvider, child: MyFavouritePageContent());
  }
}
class MyFavouritePageContent extends StatefulWidget {
  MyFavouritePageContent({Key? key}) : super(key: key);
  @override
  State<MyFavouritePageContent> createState() => _MyFavouritePageContentState();
}
class _MyFavouritePageContentState extends State<MyFavouritePageContent> {
  int a = 1;
  FavouriteViewModel favouriteViewModel = sl();
  getFav() async {
    await favouriteViewModel.getFavourites();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFav();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssets.backgroundImagePNG),
              fit: BoxFit.cover),
        ),
        child: Consumer<FavouriteViewModel>(
            builder: (BuildContext context, provider, __) {
              return ValueListenableBuilder<bool>(
                  valueListenable: context
                      .read<FavouriteViewModel>()
                      .isGetFavourites,
                  builder: (_, val, __) {
                    if (val) {
                      return  const MyFavoritesLoadingItem();
                    }
                    else {
                      if (provider.getFavoritesResponseModel!.data.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text('No Favourite Product 😌',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline6),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                                'Explore products and shop your\nfavourite items',
                                textAlign: TextAlign.center,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2)
                          ],
                        );
                      }
                      else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 20.h),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      topRight: Radius.circular(50.0),
                                    )),
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                      itemCount: favouriteViewModel
                                          .getFavoritesResponseModel!.data.length,
                                      shrinkWrap: true,
// physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 22, right: 22),
                                          child: Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10.r)),
                                            child: Container(
                                              height: 80.h,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(20.r),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10.r),
                                                              ),
                                                              height: 80.h,
                                                              width: 80.w,
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 1,
                                                                  top: 1,
                                                                  bottom: 1),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10.r),
                                                                child: Image
                                                                    .network(
                                                                  AppUrl
                                                                      .fileBaseUrl +
                                                                      favouriteViewModel
                                                                          .getFavoritesResponseModel!
                                                                          .data
                                                                          .elementAt(
                                                                          index)
                                                                          .product
                                                                          .thumbnail,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              )),
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                const Padding(
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                        4)),
                                                                Text(
                                                                  favouriteViewModel
                                                                      .getFavoritesResponseModel!
                                                                      .data
                                                                      .elementAt(index)
                                                                      .product
                                                                      .name.length > 18
                                                                      ? '${favouriteViewModel
                                                                      .getFavoritesResponseModel!
                                                                      .data
                                                                      .elementAt(index)
                                                                      .product
                                                                      .name.substring(0, 18)}...'
                                                                      : favouriteViewModel
                                                                      .getFavoritesResponseModel!
                                                                      .data
                                                                      .elementAt(index)
                                                                      .product
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      fontSize: 12.sp),
                                                                ),
                                                                SizedBox(
                                                                  height: 8.h,
                                                                ),
                                                                Text(
                                                                  favouriteViewModel
                                                                      .getFavoritesResponseModel!
                                                                      .data
                                                                      .elementAt(
                                                                      index)
                                                                      .product
                                                                      .actualPrice,
                                                                  style: TextStyle(
                                                                      fontSize: 14
                                                                          .sp,
                                                                      color: Colors
                                                                          .black38,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        right: 15, top: 4),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        IconButton(onPressed: () {
                                                          favouriteViewModel
                                                              .delFavourites(
                                                              favouriteId:
                                                              favouriteViewModel
                                                                  .getFavoritesResponseModel!
                                                                  .data
                                                                  .elementAt(
                                                                  index)
                                                                  .id);
                                                        },
                                                            icon: Icon(Icons
                                                                .favorite,
                                                              color: Colors
                                                                  .redAccent,
                                                              size: 32.sp,
                                                            )),
                                                        // height: 30.h,
                                                        // width: 15.w,
                                                        //),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }
                  });
            }
        ),
      ),
    );
  }
}