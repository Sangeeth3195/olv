import 'package:flutter/material.dart';

import 'components/body.dart';

class Information extends StatelessWidget {
  static String routeName = "/information";

  const Information({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black,size: 20),
        title: const Text(
          'Account Information',
          style: TextStyle(color: Colors.black,fontSize: 16),
        ),
      ),
      body: const Body(),
    );
  }
}
