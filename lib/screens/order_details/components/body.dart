import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/screens/address/address.dart';

import '../../../components/size_config.dart';
import '../../my_orders/Myorders.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: Text(
              'Delivery',
              style:
                  TextStyle(color: headingColor, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivering to Home",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "653 Nostrand Ave.\nBrooklyn, NY 11216",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            height: 1.5,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const ColoredBox(
            color: Color(0xFFFFFAF0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Image(
                    image: NetworkImage(
                        'https://staging2.omaliving.com/media/catalog/product/cache/e6afa270acd1ebb244ff9314a1640bb7/R/I/RI002927_3.png'),
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Scheffera potted plant',
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: Text('₹ 1,298'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                ListTile(
                  leading: Image(
                    image: NetworkImage(
                        'https://staging2.omaliving.com/media/catalog/product/cache/e6afa270acd1ebb244ff9314a1640bb7/R/I/RI002927_3.png'),
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Scheffera potted plant',
                    style: TextStyle(fontSize: 13),
                  ),
                  subtitle: Text(
                    '₹ 1,298',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                ListTile(
                  leading: Image(
                    image: NetworkImage(
                        'https://staging2.omaliving.com/media/catalog/product/cache/e6afa270acd1ebb244ff9314a1640bb7/R/I/RI002927_3.png'),
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Scheffera potted plant',
                    style: TextStyle(fontSize: 13),
                  ),
                  subtitle: Text(
                    '₹ 1,298',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                ListTile(
                  leading: Image(
                    image: NetworkImage(
                        'https://staging2.omaliving.com/media/catalog/product/cache/e6afa270acd1ebb244ff9314a1640bb7/R/I/RI002927_3.png'),
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Scheffera potted plant',
                    style: TextStyle(fontSize: 13),
                  ),
                  subtitle: Text(
                    '₹ 1,298',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: Row(
              children: [
                Text(
                  "Payment Summary",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: Row(
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
          ),
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: Row(
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
          ),
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: Row(
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
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: Container(
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
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyOrders()),
                );
              },
              child: Container(
                //width: 100.0,
                height: 45.0,
                decoration: BoxDecoration(
                  color: headingColor,
                  border: Border.all(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: const Center(
                  child: Text(
                    'Continue Shopping',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}