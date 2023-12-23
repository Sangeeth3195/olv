import 'package:flutter/material.dart';

import 'components/body.dart';

class Orderdetails extends StatelessWidget {

  const Orderdetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black,size: 20),
        title: const Text('Order Details',style: TextStyle(color: Colors.black,fontSize: 16),),
      ),
      body: const Body(),
    );
  }
}
