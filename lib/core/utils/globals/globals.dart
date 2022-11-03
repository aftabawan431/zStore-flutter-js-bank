import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../features/home/presentation/home_view_model/trackOrderModal.dart';

GlobalKey<NavigatorState> navigatorKeyGlobal = GlobalKey<NavigatorState>();
final sl = GetIt.instance;
final GlobalKey<ScaffoldMessengerState> snackbarKey =
GlobalKey<ScaffoldMessengerState>();
const String imgPath ='images/defaultprofile.jpg';
const Color? kCyanColor=Color(0xFFE1F5F5);

Color appGreenColor = const Color(0xFF2A9488);
Color scafoldBackgroundColor = const Color(0xFFFAF9F6);


final trackOrderList = [
  TrackOrderModal(
      icon: Icons.card_travel,
      title: "Ready to Pickup",
      subtitle: "Order from E-Commerce",
      time: "08.00"),
  TrackOrderModal(
      icon: Icons.person,
      title: "Order Processed",
      subtitle: "We are preparing your order",
      time: "09.50"),
  TrackOrderModal(
      icon: Icons.payment,
      title: "Payment Confirmed",
      subtitle: "Awaiting Confirmation",
      time: "11.30"),
  TrackOrderModal(
      icon: Icons.receipt,
      title: "Order Placed",
      subtitle: "We have received your order",
      time: "02.15"),
];