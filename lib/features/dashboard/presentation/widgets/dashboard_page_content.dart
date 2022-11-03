import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:zstore_flutter/core/constants/app_assets.dart';
import 'package:zstore_flutter/core/utils/theme/app_theme.dart';
import 'package:zstore_flutter/features/home/presentation/widgets/pagination/add_to_cart_page.dart';
import 'package:zstore_flutter/features/home/presentation/widgets/pagination/home_page.dart';
import 'package:zstore_flutter/features/my_favrouits/presentation/widgets/my_favrouits_page_content.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/widgets/dashboard_drawer.dart';
import '../../../authentication/presentation/auth_view_model/authentication_view_model.dart';
import '../../../home/presentation/home_view_model/cart_provider.dart';
import '../../../home/presentation/home_view_model/home_view_model.dart';
import '../../../profile/presentation/widgets/pagination/profile_page_content.dart';
import '../dashboard_view_model/dashboard_view_model.dart';

PersistentBottomSheetController? globalBottomSheetController;
final ZoomDrawerController z = ZoomDrawerController();

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final AuthViewModel _viewModel = sl();
  final DashboardViewModel _viewModel2 = sl();
  final HomeViewModel _viewModel3 = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: _viewModel),
            ChangeNotifierProvider.value(value: _viewModel2),
            ChangeNotifierProvider.value(value: _viewModel3),
          ],
          child: const DashboardPageContent(),
        ));
  }
}

class DashboardPageContent extends StatefulWidget {
  const DashboardPageContent({Key? key}) : super(key: key);

  @override
  _DashboardPageContentState createState() => _DashboardPageContentState();
}

class _DashboardPageContentState extends State<DashboardPageContent> {
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
        child: ZoomDrawer(
          controller: z,
          borderRadius: 24,
          style: DrawerStyle.defaultStyle,
          showShadow: true,
          openCurve: Curves.fastOutSlowIn,
          slideWidth: 265.w,
          duration: const Duration(milliseconds: 200),
          mainScreen: const Body(),
          menuScreen: DashboardDrawerMenuWidget(),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: -1.0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return TwoPanels(
      controller: controller,
    );
  }
}

class TwoPanels extends StatefulWidget {
  final AnimationController controller;

  const TwoPanels({Key? key, required this.controller}) : super(key: key);

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> with TickerProviderStateMixin {
  static const _headerHeight = 32.0;

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final _height = constraints.biggest.height;
    final _backPanelHeight = _height - _headerHeight;
    const _frontPanelHeight = -_headerHeight;

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(
        0.0,
        _backPanelHeight,
        0.0,
        _frontPanelHeight,
      ),
      end:  RelativeRect.fromLTRB(0.0, 100.h, 0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.linear),
    );
  }

  @override
  void initState() {
    pageController = PageController();
    currentIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  late PageController pageController;
  List<String> pages = ['Home', 'My Favorite', 'Cart', 'Profile'];
  @override
  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h), // here the desired height

        child: AppBar(
            centerTitle: true,
            toolbarHeight: 120, // Set this height

            backgroundColor: Color(0xFFE1F5F5),
            leading: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: GestureDetector(
                onTap: () {
                  z.toggle!();
                },
                child: Card(
                  elevation: 2,
                  child: Container(
                    height: 30.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      gradient: const LinearGradient(
                          colors: [Colors.white, Colors.white]),
                    ),
                    child: Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ),
            title: ValueListenableBuilder<String>(
                valueListenable:
                    context.read<DashboardViewModel>().dashboardAppbarTitle,
                builder: (_, title, __) {
                  return Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontSize: 15.h),
                  );
                }),
            actions: [
              GestureDetector(
                onTap: () {
                  DashboardViewModel dashboardViewModel = sl();
                  dashboardViewModel.moveToNotificationPage();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      height: 23.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        gradient: const LinearGradient(
                            colors: [Colors.white, Colors.white]),
                      ),
                      child: Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
                // child: SvgPicture.asset(trailingIcon!),
              ),
            ]),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
        children: <Widget>[
          HomePage(),
          MyFavouritePage(),
          AddToCartPage(),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: context.read<DashboardViewModel>().pageIndex,
        builder: (_, index, __) {
          return BottomNavyBar(
            showElevation: true,
            selectedIndex: currentIndex,
            onItemSelected: (index) {
              setState(() => currentIndex = index);
              pageController.jumpToPage(index);
              context.read<DashboardViewModel>().dashboardAppbarTitle.value =
                  pages[index];
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                  textAlign: TextAlign.center,
                  activeColor: AppTheme.appTheme.primaryColor,
                  inactiveColor: Colors.grey,
                  title: Text('Home'),
                  icon: SvgPicture.asset(AppAssets.icHomeSvg)),
              BottomNavyBarItem(
                  textAlign: TextAlign.center,
                  activeColor: AppTheme.appTheme.primaryColor,
                  inactiveColor: Colors.grey,
                  title: Text('Favourite'),
                  icon: SvgPicture.asset(AppAssets.icFavouriteSvg)),
              BottomNavyBarItem(
                textAlign: TextAlign.center,
                activeColor: AppTheme.appTheme.primaryColor,
                inactiveColor: Colors.grey,
                title: const Text('Cart'),
                icon: Center(
                  child: Consumer<CartProvider>(
                      builder: (context, value, child) {
                      return Badge(
                        position: BadgePosition.topStart(top: -20, start: 10),
                        stackFit: StackFit.loose,
                        showBadge: value.getCounter() ==0? false : true,
                        // showBadge:  false,
                        badgeContent:
                             Text(value.getCounter().toString(),
                                style: const TextStyle(color: Colors.white)),

                        animationType: BadgeAnimationType.fade,
                        animationDuration: const Duration(milliseconds: 100),
                        child: Icon(Icons.shopping_cart_outlined,color: Colors.black54,size: 18.sp,),
                      );
                    }
                  ),
                ),
              ),
              BottomNavyBarItem(
                  textAlign: TextAlign.center,
                  activeColor: AppTheme.appTheme.primaryColor,
                  inactiveColor: Colors.grey,
                  title: const Text('Profile'),
                  icon: SvgPicture.asset(
                    AppAssets.icPersonSvg,
                    color: Colors.black,
                  )),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}
