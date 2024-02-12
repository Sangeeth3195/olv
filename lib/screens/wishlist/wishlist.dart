import 'package:flutter/material.dart';

import 'components/body.dart';

class Wishlist extends StatelessWidget {
  static String routeName = "/wishlist";

  const Wishlist({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black,size: 20) ,
        title: const Text(
          'My Wishlist',
          style: TextStyle(fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}
