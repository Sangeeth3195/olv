import 'package:flutter/material.dart';

import 'components/body.dart';

class MyOrders extends StatelessWidget {

  const MyOrders({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black,size: 20) ,
        title: const Text(
          'My Orders',
          style: TextStyle(fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.black),
        ),
      ),
      body:const Body(),
    );
  }
}
