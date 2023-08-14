import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Cart.dart';

import '../../../components/size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        child: ListView.builder(
          itemCount: demoCarts.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: CartCard(cart: demoCarts[index]),
          ),
        ));
  }
}
