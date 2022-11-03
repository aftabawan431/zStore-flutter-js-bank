import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zstore_flutter/core/utils/extension/extensions.dart';
import 'package:zstore_flutter/core/widgets/dashboard_drawer.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_page_content/forget_password_wrapper/otp_screen_content.dart';
import 'package:zstore_flutter/features/authentication/presentation/auth_page_content/register_page_content.dart';
import 'package:zstore_flutter/features/feedback/presentation/widgets/feedback_page_content.dart';
import 'package:zstore_flutter/features/home/presentation/widgets/pagination/add_to_cart_page.dart';
import 'package:zstore_flutter/features/home/presentation/widgets/pagination/checkout_page.dart';
import 'package:zstore_flutter/features/home/presentation/widgets/pagination/products_by_sub_categories.dart';
import 'package:zstore_flutter/features/home/presentation/widgets/pagination/home_page.dart';
import 'package:zstore_flutter/features/home/presentation/widgets/pagination/new_shipping_address_page.dart';
import 'package:zstore_flutter/features/home/presentation/widgets/pagination/payment_details_page.dart';
import 'package:zstore_flutter/features/home/presentation/widgets/pagination/status_page.dart';
import 'package:zstore_flutter/features/my_favrouits/presentation/widgets/my_favrouits_page_content.dart';
import 'package:zstore_flutter/features/my_membership/presentation/widgets/my_membership_page_content.dart';
import 'package:zstore_flutter/features/my_points/presentation/widgets/pagination/my_points_page_content.dart';
import 'package:zstore_flutter/features/new_order/presentation/widgets/pagination/order_tracking_map_screen.dart';
import 'package:zstore_flutter/features/order_history/presentation/widgets/pagination/order_history_page_content.dart';
import 'package:zstore_flutter/features/order_history/presentation/widgets/pagination/order_history_details.dart';
import 'package:zstore_flutter/features/order_history/presentation/widgets/pagination/order_tracking.dart';
import 'package:zstore_flutter/features/order_tracking/presentation/widgets/tracking_order_page.dart';
import 'package:zstore_flutter/features/profile/presentation/widgets/pagination/update_profile_page_content.dart';
import '../../features/authentication/presentation/auth_page_content/Login_page_content.dart';
import '../../features/authentication/presentation/auth_page_content/forget_password_wrapper/forget_password_confirm_password_page_content.dart';
import '../../features/authentication/presentation/auth_page_content/forget_password_wrapper/forget_password_email_page_content.dart';
import '../../features/dashboard/presentation/widgets/dashboard_page_content.dart';
import '../../features/dashboard/presentation/widgets/notifications_page_content.dart';
import '../../features/home/presentation/widgets/pagination/Categories_page.dart';
import '../../features/home/presentation/widgets/pagination/product_details_page.dart';
import '../../features/profile/presentation/widgets/pagination/profile_page_content.dart';
import '../../features/reviews/presentation/widgets/reviews_page_content.dart';
import '../../features/reviews/presentation/widgets/see_reveiw_details_content.dart';
import '../../features/splash_screen/presentation/pages/splash_screen.dart';
import '../utils/enums/page_state_enum.dart';
import '../utils/globals/globals.dart';
import 'app_state.dart';
import 'pages.dart';

BuildContext?
    globalHomeContext; // doing this to pop the bottom sheet on home screen

class CustomRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  late final AppState appState;
  final List<Page> _pages = [];
  late BackButtonDispatcher backButtonDispatcher;

  List<MaterialPage> get pages => List.unmodifiable(_pages);

  CustomRouterDelegate(this.appState) {
    appState.addListener(() {
      notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Faulty Code will need to find a way to solve it
    appState.globalErrorShow = (value) {
      context.show(message: value);
    };

    return Container(
      key: ValueKey(pages.last.name),
      child: Navigator(
        key: navigatorKeyGlobal,
        onPopPage: _onPopPage,
        pages: buildPages(),
      ),
    );
  }

  List<Page> buildPages() {
    switch (appState.currentAction.state) {
      case PageState.none:
        break;
      case PageState.addPage:
        addPage(appState.currentAction.page!);
        break;
      case PageState.remove:
        removePage(appState.currentAction.page!);
        break;

      case PageState.pop:
        pop();
        break;
      case PageState.addAll:
        // TODO: Handle this case.
        break;
      case PageState.addWidget:
        pushWidget(
            appState.currentAction.widget!, appState.currentAction.page!);
        break;
      case PageState.replace:
        replace(appState.currentAction.page!);
        break;
      case PageState.replaceAll:
        replaceAll(appState.currentAction.page!);
        break;
    }
    return List.of(_pages);
  }

  void pushWidget(Widget child, PageConfiguration newRoute) {
    _addPageData(child, newRoute);
  }

  void replaceAll(PageConfiguration newRoute) {
    _pages.clear();
    setNewRoutePath(newRoute);
  }

  void replace(PageConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  void removePage(PageConfiguration page) {
    if (_pages.isEmpty) {
      pages.remove(page);
    }
  }

  /// This method adds pages based on the PageConfig received
  /// [Input]: [PageConfiguration]
  void addPage(PageConfiguration pageConfig) {
    final shouldAddPage =
        _pages.isEmpty || (_pages.last.name != pageConfig.path);

    if (shouldAddPage) {
      switch (pageConfig.uiPage) {
        case Pages.splashPage:

          _addPageData(const SplashPage(), pageConfig);
          // _addPageData(DashboardPage(), pageConfig);
          break;

        case Pages.loginPage:
          _addPageData(LoginPage(), pageConfig);
          break;
        case Pages.registrationPage:
          _addPageData(RegistrationPage(), pageConfig);
          break;
        case Pages.forgetEmailPage:
          _addPageData(ForgetEnterEmailPage(), pageConfig);
          break;
        case Pages.otpPage:
          _addPageData(OtpPage(), pageConfig);
          break;
        case Pages.forgetPasswordPage:
          _addPageData(ForgetConfirmPasswordPage(), pageConfig);
          break;
        case Pages.dashboardPage:
          _addPageData(DashboardPage(), pageConfig);
          break;
        case Pages.profilePage:
          _addPageData(ProfilePage(), pageConfig);
          break;
        case Pages.updateProfilePage:
          _addPageData(UpdateProfilePage(), pageConfig);
          break;
        case Pages.MenuPage:
          _addPageData(DashboardDrawerMenuWidget(), pageConfig);
          break;
        case Pages.orderHistoryPage:
          _addPageData(OrderHistoryPage(), pageConfig);
          break;
        case Pages.orderHistoryDetailPage:
          _addPageData(OrderHistoryDetailPage(), pageConfig);
          break;
        case Pages.orderTrackingPage:
          _addPageData(OrderTrackingPage(), pageConfig);
          break;
        case Pages.myPointsPage:
          _addPageData(MyPointsPage(), pageConfig);
          break;
        case Pages.homePage:
          _addPageData(HomePage(), pageConfig);
          break;
        case Pages.productsBySubCategoriesPage:
          _addPageData(ProductsBySubCategoriesPage(), pageConfig);
          break;
        case Pages.paymentDetails:
          _addPageData(PaymentDetailsPage(), pageConfig);
          break;
        case Pages.productDetails:
          _addPageData(ProductDetailsPage(), pageConfig);
          break;
        case Pages.checkoutPage:
          _addPageData(CheckoutPage(), pageConfig);
          break;
        case Pages.status:
          _addPageData(StatusPage(), pageConfig);

          break;
        case Pages.addToCartPage:
          _addPageData(AddToCartPage(), pageConfig);
          break;
        case Pages.feedbackPage:
          _addPageData(FeedBackPage(), pageConfig);
          break;
        case Pages.favouritesPage:
          _addPageData(MyFavouritePage(), pageConfig);
          break;
          case Pages.membershipPage:
          _addPageData(MyMembershipPage(), pageConfig);
          break;
        case Pages.newShippingAddress:
          _addPageData(NewShippingAddressPage(), pageConfig);
          break;
          case Pages.myPointsPage:
          _addPageData(MyPointsPage(), pageConfig);
          break;
        case Pages.reviewPage:
          _addPageData(ReviewsPage(), pageConfig);
          break;
          case Pages.categoriesPage:
          _addPageData(CategoriesPage(), pageConfig);
          break;
          case Pages.map:
          _addPageData(MapPage(), pageConfig);
          break;
          case Pages.seeProductReviewDetailsPage:
          _addPageData(SeeReviewDetails(), pageConfig);
          break;
          case Pages.notificationsPage:
          _addPageData(NotificationsPageContent(), pageConfig);
          break;
      }
    }
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    _pages.add(
      _createPage(child, pageConfig),
    );
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
        child: child,
        key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);

    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  void pop() {
    if (globalHomeContext != null) {
      Navigator.of(globalHomeContext!).pop();
      globalHomeContext = null;
      return;
    }
    if (canPop()) {
      _removePage(_pages.last as MaterialPage);
    } else {
      // if (_pages.last.name != PagePaths.authWrapperPagePath) {
      //   _homeViewModel.onBottomNavTap(0);
      // }
    }
  }

  void _removePage(MaterialPage page) {
    _pages.remove(page);
    // notifyListeners();
  }

  bool canPop() {
    return _pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(_pages.last as MaterialPage);
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    final shouldAddPage =
        _pages.isEmpty || (_pages.last.name != configuration.path);

    if (!shouldAddPage) {
      return SynchronousFuture(null);
    }
    _pages.clear();
    addPage(configuration);

    return SynchronousFuture(null);
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => navigatorKeyGlobal;
}
