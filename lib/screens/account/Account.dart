import 'package:flutter/material.dart';

import 'components/body.dart';

class Account extends StatelessWidget {
  static String routeName = "/account";

  const Account({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dashboard'),
      ),
      body: const Body(),
    );
  }
}
