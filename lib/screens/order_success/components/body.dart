import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {

  const Body(String text, {super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  SharedPreferences? prefs;
  String? orderID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    prefs =
    await SharedPreferences.getInstance();

    orderID = prefs!.getString('order_ID') ?? '';

    print('orderID');
    print(orderID);
  }

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
              "Order ID: ",
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

                    context.go('/home');

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
