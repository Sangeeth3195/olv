import 'package:flutter/material.dart';
import 'package:omaliving/screens/order_summary/ordersummary.dart';

import '../../components/default_button.dart';
import '../../components/size_config.dart';
import '../../constants.dart';
import '../cart/components/check_out_card.dart';
import '../order_details/orderdetails.dart';
import 'components/body.dart';

/*class Checkout extends StatelessWidget {
  static String routeName = "/checkout";

  const Checkout({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: AppBar(),
      body: const Body(),
      // bottomNavigationBar: CheckoutCard(),
    );
  }
}

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(10),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      "₹ 1,598",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    // Place 2 `Expanded` mean: they try to get maximum size and they will have same size
                    child: SizedBox(
                      height: 40, // <-- Your height
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: headingColor,
                          side: const BorderSide(color: Colors.grey, width: 1.0),
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontStyle: FontStyle.normal),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Ordersummary()),
                          );
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/


class Checkout extends StatelessWidget {
  static String routeName = "/ordersummary";

  const Checkout({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }
}

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(10),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    "₹ 1,598",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  // Place 2 `Expanded` mean: they try to get maximum size and they will have same size
                  child: SizedBox(
                    height: 40, // <-- Your height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: headingColor,
                        side: const BorderSide(color: Colors.grey, width: 1.0),
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                        // shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Ordersummary()),
                        );
                      },
                      child: const Text(
                        'Continue to payment',
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}