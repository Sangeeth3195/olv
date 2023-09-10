import 'package:flutter/material.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/screens/address/address.dart';

import '../../../components/size_config.dart';
import '../../order_summary/ordersummary.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

enum Fruit { apple, banana }

class _BodyState extends State<Body> {
  Fruit? _fruit = Fruit.apple;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                    child: Text(
                      'Delivery',
                      style: TextStyle(
                          color: headingColor, fontWeight: FontWeight.bold),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Delivering to Home",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Text(
                                "653 Nostrand Ave.\nBrooklyn, NY 11216",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    height: 1.5,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Address()),
                                );
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Change Address |',
                                    style: TextStyle(
                                        color: headingColor, fontSize: 13),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_outlined,
                                    size: 13,
                                    color: headingColor,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                    child: Text(
                      'Shipping Method',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: const Text('Standard Shipping'),
                    leading: Radio<Fruit>(
                      value: Fruit.apple,
                      groupValue: _fruit,
                      onChanged: (Fruit? value) {
                        setState(() {
                          _fruit = value;
                        });
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 85),
                    child: Text(
                      '₹ 500',
                      style: TextStyle(
                          color: headingColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

            ])));
  }
}
