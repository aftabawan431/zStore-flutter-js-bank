import 'package:zstore_flutter/core/router/models/page_keys.dart';
import 'package:zstore_flutter/core/router/models/page_paths.dart';

import '../pages.dart';

class PageConfigs {
  static PageConfiguration splashPageConfig = const PageConfiguration(
      key: PageKeys.splashPageKey,
      path: PagePaths.splashPagePath,
      uiPage: Pages.splashPage);

  static PageConfiguration loginPageConfig = const PageConfiguration(
      key: PageKeys.loginPageKey,
      path: PagePaths.loginPathPath,
      uiPage: Pages.loginPage);
  static PageConfiguration registrationPageConfig = const PageConfiguration(
      key: PageKeys.registrationPageKey,
      path: PagePaths.registrationPath,
      uiPage: Pages.registrationPage);
  static PageConfiguration orderTrackingPageConfig = const PageConfiguration(
      key: PageKeys.orderTrackingPageKey,
      path: PagePaths.orderTrackingPagePath,
      uiPage: Pages.orderTrackingPage);
  static PageConfiguration categoriesPageConfig = const PageConfiguration(
      key: PageKeys.categoriesPageKey,
      path: PagePaths.categoriesPagePath,
      uiPage: Pages.categoriesPage);

  static PageConfiguration forgetConfirmPasswordPageConfig =
      const PageConfiguration(
          key: PageKeys.forgetConfirmPasswordPageKey,
          path: PagePaths.forgetPasswordPagePath,
          uiPage: Pages.forgetPasswordPage);
  static PageConfiguration forgetPasswordEmailPageConfig =
      const PageConfiguration(
          key: PageKeys.forgetPasswordEmailPageKey,
          path: PagePaths.forgetEmailPagePath,
          uiPage: Pages.forgetEmailPage);

  static PageConfiguration otpPageConfig = const PageConfiguration(
      key: PageKeys.otpPageKey,
      path: PagePaths.otpPagePath,
      uiPage: Pages.otpPage);
  static PageConfiguration dashboardPageConfig = const PageConfiguration(
      key: PageKeys.dashBoardPageKey,
      path: PagePaths.dashboardPagePath,
      uiPage: Pages.dashboardPage);
  static PageConfiguration profileConfig = const PageConfiguration(
      key: PageKeys.profilePageKey,
      path: PagePaths.profilePagePath,
      uiPage: Pages.profilePage);
  static PageConfiguration addToCartConfig = const PageConfiguration(
      key: PageKeys.addToCartPageKey,
      path: PagePaths.addToCartPagePath,
      uiPage: Pages.addToCartPage);
  static PageConfiguration checkoutConfig = const PageConfiguration(
      key: PageKeys.checkoutPageKey,
      path: PagePaths.checkoutPagePath,
      uiPage: Pages.checkoutPage);
  static PageConfiguration productsBySubCategoriesConfig = const PageConfiguration(
      key: PageKeys.homeDecorPageKey,
      path: PagePaths.homeDecorPagePath,
      uiPage: Pages.productsBySubCategoriesPage);
  static PageConfiguration homePageConfig = const PageConfiguration(
      key: PageKeys.homePageKey,
      path: PagePaths.homePagePath,
      uiPage: Pages.homePage);
  static PageConfiguration paymentDetailsConfig = const PageConfiguration(
      key: PageKeys.paymentDetailsPageKey,
      path: PagePaths.paymentDetailsPagePath,
      uiPage: Pages.paymentDetails);
  static PageConfiguration productDetailsConfig = const PageConfiguration(
      key: PageKeys.productDetailsPageKey,
      path: PagePaths.productDetailsPagePath,
      uiPage: Pages.productDetails);
  static PageConfiguration statusConfig = const PageConfiguration(
      key: PageKeys.statusPageKey,
      path: PagePaths.statusPagePath,
      uiPage: Pages.status);
  static PageConfiguration MenuConfig = const PageConfiguration(
      key: PageKeys.MenuPageKey,
      path: PagePaths.MenuPagePath,
      uiPage: Pages.MenuPage);
  static PageConfiguration orderHistoryConfig = const PageConfiguration(
      key: PageKeys.orderHistoryPageKey,
      path: PagePaths.orderHistoryPagePath,
      uiPage: Pages.orderHistoryPage);
  static PageConfiguration orderHistoryDetailConfig = const PageConfiguration(
      key: PageKeys.orderHistoryDetailPageKey,
      path: PagePaths.orderHistoryDetailPagePath,
      uiPage: Pages.orderHistoryDetailPage);
  static PageConfiguration myPointsConfig = const PageConfiguration(
      key: PageKeys.myPointsPageKey,
      path: PagePaths.myPointsPagePath,
      uiPage: Pages.myPointsPage);
  static PageConfiguration updateProfileConfig = const PageConfiguration(
      key: PageKeys.updateProfilePageKey,
      path: PagePaths.updateProfilePagePath,
      uiPage: Pages.updateProfilePage);
  static PageConfiguration newShippingAddressConfig = const PageConfiguration(
      key: PageKeys.newShippingAddressPageKey,
      path: PagePaths.newShippingAddressPagePath,
      uiPage: Pages.newShippingAddress);
  static PageConfiguration feedbackConfig = const PageConfiguration(
      key: PageKeys.feedbackPageKey,
      path: PagePaths.feedbackPagePath,
      uiPage: Pages.feedbackPage);
  static PageConfiguration favouritesConfig = const PageConfiguration(
      key: PageKeys.myFavouritePageKey,
      path: PagePaths.favouritesPagePath,
      uiPage: Pages.favouritesPage);
  static PageConfiguration reviewScreenPage = const PageConfiguration(
      key: PageKeys.reviewPageKey,
      path: PagePaths.reviewScreenPagePath,
      uiPage: Pages.reviewPage);
  static PageConfiguration myMembershipScreenPage = const PageConfiguration(
      key: PageKeys.myMembershipPageKey,
      path: PagePaths.myMembershipPagePath,
      uiPage: Pages.membershipPage);
  static PageConfiguration mapScreenPage = const PageConfiguration(
      key: PageKeys.mapPageKey,
      path: PagePaths.mapPagePath,
      uiPage: Pages.map);
  static PageConfiguration seeReviewDetailsPage = const PageConfiguration(
      key: PageKeys.seeProductReviewDetailsPageKey,
      path: PagePaths.seeProductReviewDetailsPagePath,
      uiPage: Pages.seeProductReviewDetailsPage);
  static PageConfiguration notificationPage = const PageConfiguration(
      key: PageKeys.notificationPageKey,
      path: PagePaths.notificationPagePath,
      uiPage: Pages.notificationsPage);
}
