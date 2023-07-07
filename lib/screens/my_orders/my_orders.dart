import 'package:flutter/material.dart';

import 'components/body.dart';

class MyOrders extends StatelessWidget {
  static String routeName = "/myorders";

  const MyOrders({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body:const Body(),
    );
  }
}
