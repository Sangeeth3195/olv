import 'package:flutter/material.dart';

import 'components/body.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  static String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 18),
        title: const Text(
          'Settings',
          style: TextStyle(
              fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Colors.black
             // color: Colors.black, fontSize: 14
          ),
        ),
      ),
      body: const Body(),
    );
  }
}
