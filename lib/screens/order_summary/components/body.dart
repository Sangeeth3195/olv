import 'package:flutter/material.dart';
import 'package:omaliving/constants.dart';

import '../../../components/size_config.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

enum Fruit { apple, banana }

class _BodyState extends State<Body> {
  final Fruit _fruit = Fruit.apple;

  final List<String> items = List<String>.generate(5, (i) => '$i');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: Text(
              'Delivery',
              style:
                  TextStyle(color: headingColor, fontWeight: FontWeight.bold,fontSize: 15),
            ),
          ),
          /*const Text(
            'Delivery',
            style: TextStyle(color: headingColor, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Delivery to Home',
            style: TextStyle(color: headingColor, fontWeight: FontWeight.bold),
          ),*/
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivering to Home",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 13),
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
                        'https://www.omaliving.com/media/catalog/product/cache/7a4073f8d3c05bd8cd3f989ce9c9cc9f/I/T/ITEM-010709_4.png'),
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Scheffera potted plant',
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Text('₹ 1,298', style: TextStyle(color: Colors.black,fontSize: 13,),),
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
                        'https://www.omaliving.com/media/catalog/product/cache/7a4073f8d3c05bd8cd3f989ce9c9cc9f/I/T/ITEM-010709_4.png'),
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Scheffera potted plant',
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    '₹ 1,298',
                    style: TextStyle(fontSize: 13, color: Colors.black),
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
                        'https://www.omaliving.com/media/catalog/product/cache/7a4073f8d3c05bd8cd3f989ce9c9cc9f/I/T/ITEM-010709_4.png'),
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Scheffera potted plant',
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    '₹ 1,298',
                    style: TextStyle(fontSize: 13, color: Colors.black),
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
                        'https://www.omaliving.com/media/catalog/product/cache/7a4073f8d3c05bd8cd3f989ce9c9cc9f/I/T/ITEM-010709_4.png'),
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Scheffera potted plant',
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    '₹ 1,298',
                    style: TextStyle(fontSize: 13,color: Colors.black),
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
                      'Subtotal1',
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
        ],
      ),
    );
  }
}
