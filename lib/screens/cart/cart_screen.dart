import 'package:flutter/material.dart';

import '../../models/Cart.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
        bottomNavigationBar: CheckoutCard(),
    );
  }

}


