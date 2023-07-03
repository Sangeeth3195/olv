import 'package:flutter/material.dart';

import 'components/body.dart';

class Checkout extends StatelessWidget {
  static String routeName = "/checkout";

  const Checkout({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
