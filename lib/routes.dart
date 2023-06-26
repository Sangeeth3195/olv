import 'package:flutter/widgets.dart';
import 'package:omaliving/screens/address/address.dart';
import 'package:omaliving/screens/cart/cart_screen.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/forgot_password/forgot_password_screen.dart';
import 'package:omaliving/screens/home/home_screen.dart';
import 'package:omaliving/screens/my_orders/my_orders.dart';
import 'package:omaliving/screens/newsletter/news_letter.dart';
import 'package:omaliving/screens/profile/profile_screen.dart';
import 'package:omaliving/screens/settings/settings.dart';
import 'package:omaliving/screens/sign_in/sign_in_screen.dart';
import 'package:omaliving/screens/wishlist/wishlist.dart';
import 'package:omaliving/splash.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  // OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  // DetailsScreen.routeName: (context) => const DetailsScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  Address.routeName: (context) => const Address(),
  Newsletter.routeName: (context) => const Newsletter(),
  Wishlist.routeName: (context) => const Wishlist(),
  MyOrders.routeName: (context) => const MyOrders(),
  Settings.routeName: (context) => const Settings(),
};
