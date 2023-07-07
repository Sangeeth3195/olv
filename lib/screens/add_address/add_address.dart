import 'package:flutter/material.dart';

import 'components/body.dart';

class AddAddress extends StatelessWidget {
  static String routeName = "/addaddress";

  const AddAddress({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
      ),
      body: const Body(),
    );
  }
}
