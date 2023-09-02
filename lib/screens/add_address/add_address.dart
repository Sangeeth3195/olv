import 'package:flutter/material.dart';

import '../../models/CustomerModel.dart';
import 'components/body.dart';

class AddAddress extends StatelessWidget {
  static String routeName = "/addaddress";

  const AddAddress({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black,size: 20),
        title: const Text(
          'Add Address',
          style: TextStyle(color: Colors.black,fontSize: 16),
        ),
      ),
      body:  Body( arguments: ModalRoute.of(context)!.settings.arguments as Address?,),
    );
  }
}
