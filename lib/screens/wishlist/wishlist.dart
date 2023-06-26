import 'package:flutter/material.dart';

import 'components/body.dart';

class Wishlist extends StatelessWidget {
  static String routeName = "/wishlist";

  const Wishlist({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
