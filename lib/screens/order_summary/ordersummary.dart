import 'package:flutter/material.dart';

import 'components/body.dart';

class Ordersummary extends StatelessWidget {
  static String routeName = "/ordersummary";

  const Ordersummary({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
