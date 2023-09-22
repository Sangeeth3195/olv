import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:omaliving/screens/order_details/orderdetails.dart';
import 'package:omaliving/screens/order_summary/ordersummary.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset("assets/animation_llup0q68.json", repeat: false),
            const SizedBox(
              height: 0,
            ),
            const Text(
              'Your order has been Successfully Placed',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Order ID: OMA000000933',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, right: 15.0, bottom: 0.0, left: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    backgroundColor: headingColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                  ),
                  onPressed: () {
                   /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Orderdetails()),
                    );*/
                  },
                  child: const Text(
                    'Continue Shopping',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),

          ]),
    );
  }
}
