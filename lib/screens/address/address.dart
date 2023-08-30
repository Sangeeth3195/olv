import 'package:flutter/material.dart';

import 'components/body.dart';

class Address extends StatelessWidget {
  static String routeName = "/address";

  const Address({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black,size: 20),
        title: const Text(
          'Address',
          style: TextStyle(color: Colors.black,fontSize: 16),
        ),
      ),
      body: const Body(),
    );
  }
}
