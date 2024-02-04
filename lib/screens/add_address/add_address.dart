import 'package:flutter/material.dart';

import '../../models/CustomerModel.dart';
import 'components/body.dart';

class AddAddress extends StatelessWidget {
  static String routeName = "/addaddress";
  final Address? arguments;

  const AddAddress({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        title: const Text(
          'Add Address',
          style: TextStyle(fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.black),
        ),
      ),
      body: Body(
        arguments: arguments,
      ),
    );
  }
}
