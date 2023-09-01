import 'dart:async';
import 'package:flutter/material.dart';
import 'package:omaliving/MainLayout.dart';
import 'package:omaliving/components/size_config.dart';
import 'package:omaliving/screens/settings/settings.dart';
import 'package:omaliving/screens/wishlist/wishlist.dart';

import 'demo/btm.dart';
import 'constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String routeName = "/splash";

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    Settings()))); // BottomNavbar
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: headingColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(color: headingColor),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/logo_white.png',
                        height: 200, width: 200),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
