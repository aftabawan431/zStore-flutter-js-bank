import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'models/page_config.dart';
import 'models/page_paths.dart';
import 'pages.dart';

class CustomRouterParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty) {
      return SynchronousFuture(PageConfigs.splashPageConfig);
    }

    final path = '/' + uri.pathSegments[0];

    switch (path) {
      case PagePaths.splashPagePath:
        return SynchronousFuture(PageConfigs.splashPageConfig);
      default:
        return SynchronousFuture(PageConfigs.splashPageConfig);
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.splashPage:
        return const RouteInformation(location: PagePaths.splashPagePath);
      case Pages.loginPage:
        return const RouteInformation(location: PagePaths.loginPathPath);
      case Pages.registrationPage:
        return const RouteInformation(location: PagePaths.registrationPath);
      case Pages.forgetEmailPage:
        return const RouteInformation(location: PagePaths.forgetEmailPagePath);
      case Pages.otpPage:
        return const RouteInformation(location: PagePaths.otpPagePath);
      case Pages.forgetPasswordPage:
        return const RouteInformation(
            location: PagePaths.forgetPasswordPagePath);
      case Pages.dashboardPage:
        return const RouteInformation(location: PagePaths.dashboardPagePath);
      case Pages.profilePage:
        return const RouteInformation(location: PagePaths.profilePagePath);
      case Pages.updateProfilePage:
        return const RouteInformation(location: PagePaths.updateProfilePagePath);
      case Pages.MenuPage:
        return const RouteInformation(location: PagePaths.MenuPagePath);
      case Pages.orderHistoryPage:
        return const RouteInformation(location: PagePaths.orderHistoryPagePath);
      case Pages.orderHistoryDetailPage:
        return const RouteInformation(
            location: PagePaths.orderHistoryDetailPagePath);
      case Pages.orderTrackingPage:
        return const RouteInformation(
            location: PagePaths.orderTrackingPagePath);
      case Pages.myPointsPage:
        return const RouteInformation(location: PagePaths.myPointsPagePath);
      case Pages.addToCartPage:
        return const RouteInformation(location: PagePaths.addToCartPagePath);
      case Pages.checkoutPage:
        return const RouteInformation(location: PagePaths.checkoutPagePath);
      case Pages.productsBySubCategoriesPage:
        return const RouteInformation(location: PagePaths.homeDecorPagePath);
      case Pages.homePage:
        return const RouteInformation(location: PagePaths.homePagePath);
      case Pages.paymentDetails:
        return const RouteInformation(
            location: PagePaths.paymentDetailsPagePath);
      case Pages.feedbackPage:
        return const RouteInformation(location: PagePaths.feedbackPagePath);
      case Pages.reviewPage:
        return const RouteInformation(location: PagePaths.reviewScreenPagePath);
      case Pages.productDetails:
        return const RouteInformation(
            location: PagePaths.productDetailsPagePath);
      case Pages.favouritesPage:
        return const RouteInformation(location: PagePaths.favouritesPagePath);
        case Pages.membershipPage:
        return const RouteInformation(location: PagePaths.myMembershipPagePath);
      case Pages.status:
        return const RouteInformation(location: PagePaths.statusPagePath);
      case Pages.newShippingAddress:
        return const RouteInformation(
            location: PagePaths.newShippingAddressPagePath);
        case Pages.categoriesPage:
        return const RouteInformation(
            location: PagePaths.categoriesPagePath);

      case Pages.map:
        return const RouteInformation(location: PagePaths.mapPagePath);
        case Pages.seeProductReviewDetailsPage:
        return const RouteInformation(location: PagePaths.seeProductReviewDetailsPagePath);
      case Pages.notificationsPage:
        return const RouteInformation(location: PagePaths.notificationPagePath);
    }
  }
}
