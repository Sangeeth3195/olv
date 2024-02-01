import 'package:flutter/material.dart';

import 'components/body.dart';

class Account extends StatelessWidget {
  static String routeName = "/account";

  const Account({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        title: const Text(
          'Profile',
          style: TextStyle(fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/edit.png',
                width: 18,
                height: 18,
              ))
        ],
      ),
      body: const Body(),
    );
  }
}
