import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../models/Cart.dart';
import '../../../components/size_config.dart';
import '../../checkout/Checkout.dart';
import '../../provider/provider.dart';

class CartCard extends StatefulWidget {
  const CartCard({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<CartCard> {
  Widget showWidget(int qty) {
    if (qty == 0) {
      return TextButton(
        child: const Text(
          'Add Item',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        onPressed: () {},
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(
              Icons.remove,
              color: blackColor,
            ),
            onPressed: () {},
          ),
          const Text('14'),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.black54,
            ),
            onPressed: () {},
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                child: AspectRatio(
                  aspectRatio: 0.80,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.network(
                        'https://www.omaliving.com/media/catalog/product/cache/0141941aeb4901c5334e6ba10ea3844d/I/T/ITEM-007993_3_1.png'),
                  ),
                ),
              ),
              Expanded(
                child: buildProductInfo(),
              ),
            ],
          ),

         /* Container(
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
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    color: const Color(0xFFFFF2E1),
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
                                    color: Colors.black, fontWeight: FontWeight.bold),
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
                        final myProvider = Provider.of<MyProvider>(
                            context,
                            listen: false);
                        myProvider.navBar=true;
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
          ),*/
        ],
      ),
    );
  }

  Padding buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Scheffera potted plant',
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              const Expanded(
                // Place `Expanded` inside `Row`
                child: SizedBox(
                  height: 15, // <-- Your height
                  child: Text(
                    '₹ 1,298',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: SizedBox(
                    height: 30, // <-- Your height
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            child: const Text('-'),
                          ),
                        ),
                        Container(
                          width: 20,
                          alignment: Alignment.center,
                          child: const Text('2'),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            child: const Text('+'),
                          ),
                        ),
                      ]),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: <Widget>[
              Expanded(
                // Place `Expanded` inside `Row`
                child: Row(
                  children: [
                    Text(
                      'Move to wishlist |',
                      style: TextStyle(color: headingColor, fontSize: 13),
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      size: 14,
                      color: headingColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
                height: 0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: headingColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Remove',
                    style: TextStyle(
                        color: headingColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
