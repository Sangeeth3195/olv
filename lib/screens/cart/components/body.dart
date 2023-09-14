import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Cart.dart';
import 'package:provider/provider.dart';

import '../../../components/default_button.dart';
import '../../../components/size_config.dart';
import '../../checkout/Checkout.dart';
import '../../provider/provider.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10)),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: demoCarts.length,
                    itemBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: CartCard(),
                    ),
                  )),

              Container(
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
                      const Row(
                        children: [
                          Text(
                            "Apply Coupon code",
                            style: TextStyle(
                              fontSize: 14.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      const Row(
                        children: [
                          Text("Enter coupon code"),
                          SizedBox(width: 10),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      const Row(
                        children: [
                          Text(
                            "Payment Summary",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        children: <Widget>[
                          Expanded(
                            // Place `Expanded` inside `Row`
                            child: SizedBox(
                              height: 15, // <-- Your height
                              child: Text(
                                'Subtotal',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30, // <-- Your height
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(children: [
                                Text(
                                  '₹ 1,298',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: <Widget>[
                          Expanded(
                            // Place `Expanded` inside `Row`
                            child: SizedBox(
                              height: 15, // <-- Your height
                              child: Text(
                                'Standard Shipping',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30, // <-- Your height
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(children: [
                                Text(
                                  '₹ 500',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: <Widget>[
                          Expanded(
                            // Place `Expanded` inside `Row`
                            child: SizedBox(
                              height: 15, // <-- Your height
                              child: Text(
                                'Discount',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30, // <-- Your height
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(children: [
                                Text(
                                  '- ₹ 200',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        // color: const Color(0xFFFFF2E1),
                        color: kPrimaryLightColor,
                        height: 50,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                // Place `Expanded` inside `Row`
                                child: SizedBox(
                                  height: 15, // <-- Your height
                                  child: Text(
                                    'Order Total',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30, // <-- Your height
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(children: [
                                    Text(
                                      '₹ 1,598',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: DefaultButton(
                          text: "Continue to Checkout",
                          press: () {
                            final myProvider =
                                Provider.of<MyProvider>(context, listen: false);
                            myProvider.navBar = true;
                            myProvider.notifyListeners();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Checkout()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
