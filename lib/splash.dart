import 'dart:async';
import 'package:flutter/material.dart';
import 'package:omaliving/screens/home/home_screen.dart';
import 'package:omaliving/components/size_config.dart';
import 'package:omaliving/screens/sign_in/sign_in_screen.dart';


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
        const Duration(seconds: 4),
        () =>Navigator.pushNamed(context, SignInScreen.routeName));

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/omalogo.png',
                        height: 220,
                        width: 220),
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


