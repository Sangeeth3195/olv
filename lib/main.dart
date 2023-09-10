import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omaliving/MainLayout.dart';
import 'package:omaliving/app_router.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

void main() async{
  try {
  WidgetsFlutterBinding.ensureInitialized();


  if (Platform.isIOS) {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
  } else {
    await Firebase.initializeApp();
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: headingColor, // navigation bar color
    statusBarColor: headingColor, // status bar color
  ));
  } catch (e) {
    print(e);
  }

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]
  );
  runApp( MultiProvider(
    providers:[
      // Provider<MyProvider>(create: (_) => MyProvider()),
      // Provider<NavbarNotifier>(create: (_) => NavbarNotifier()),

      ChangeNotifierProvider(
          create: (context) => MyProvider(),
         ),
      ChangeNotifierProvider(
          create: (context) => NavbarNotifier(),
         ),
    ],
      child: const MyApp()
  ));
  configLoading();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        fontFamily: 'Gotham',
        primarySwatch: Colors.brown,
      ),
      // home: SplashScreen(),
      routerConfig: router,
      builder: EasyLoading.init(),
    );
  }
}


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..maskType = EasyLoadingMaskType.black
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorColor = headingColor
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
      Widget child,
      AnimationController controller,
      AlignmentGeometry alignment,
      ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
