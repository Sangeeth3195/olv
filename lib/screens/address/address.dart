import 'package:flutter/material.dart';

import 'components/body.dart';

class AddEditAddress extends StatelessWidget {
  static String routeName = "/address";

  const AddEditAddress({super.key});
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
          style: TextStyle(fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.black),
        ),
      ),
      body: const Body(),
    );
  }
}
