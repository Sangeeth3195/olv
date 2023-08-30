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
        iconTheme: const IconThemeData(color: Colors.black,size: 20),
        title: const Text('Settings',style: TextStyle(color: Colors.black,fontSize: 16),),
      ),
      body: const Body(),
    );
  }
}
