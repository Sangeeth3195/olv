import 'package:flutter/material.dart';

import 'components/body.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  static String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Settings',style: TextStyle(color: Colors.black),),
      ),
      body: const Body(),
    );
  }
}
