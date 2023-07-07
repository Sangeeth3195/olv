import 'package:flutter/widgets.dart';
import 'package:omaliving/screens/Information/information.dart';
import 'package:omaliving/screens/account/Account.dart';
import 'package:omaliving/screens/add_address/add_address.dart';
import 'package:omaliving/screens/address/address.dart';
import 'package:omaliving/screens/cart/cart_screen.dart';
import 'package:omaliving/screens/checkout/Checkout.dart';
import 'package:omaliving/screens/forgot_password/forgot_password_screen.dart';
import 'package:omaliving/screens/homescreen/homescreen.dart';
import 'package:omaliving/screens/my_orders/my_orders.dart';
import 'package:omaliving/screens/newsletter/news_letter.dart';
import 'package:omaliving/screens/order_summary/ordersummary.dart';
import 'package:omaliving/screens/product_listing/Product_Listing.dart';
import 'package:omaliving/screens/profile/profile_screen.dart';
import 'package:omaliving/screens/settings/settings.dart';
import 'package:omaliving/screens/sign_in/sign_in_screen.dart';
import 'package:omaliving/screens/webview/WebView.dart';
import 'package:omaliving/screens/wishlist/wishlist.dart';
import 'package:omaliving/splash.dart';
import 'screens/sign_up/sign_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ProductListing.routeName: (context) => const ProductListing(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  MyOrders.routeName: (context) => const MyOrders(),
  WebView.routeName: (context) => const WebView(),
  Ordersummary.routeName: (context) => const Ordersummary(),
  Checkout.routeName: (context) => const Checkout(),
  HomeScreen.routeName: (context) => const HomeScreen(),

  '/addaddress': (context) => const AddAddress(),
  '/account': (context) => const Account(),
  '/wishlist': (context) => const Wishlist(),
  '/CartScreen': (context) => const CartScreen(),
  '/information': (context) => const Information(),
  '/address': (context) => const Address(),
  '/newsletter': (context) => const Newsletter(),
  '/settings': (context) => const Settings(),

};
