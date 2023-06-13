import 'package:flutter/widgets.dart';
import 'package:omaliving/screens/cart/cart_screen.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/forgot_password/forgot_password_screen.dart';
import 'package:omaliving/screens/home/home_screen.dart';
import 'package:omaliving/screens/sign_in/sign_in_screen.dart';
import 'package:omaliving/splash.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  // LoginSuccessScreen.routeName: (context) => LoginSuccessScreenScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  // OtpScreen.routeName: (context) => OtpScreen(),
  // HomeScreen.routeName: (context) => const HomeScreen(),
  // DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
};
