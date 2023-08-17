import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            SvgPicture.asset(
              "assets/icons/filter.svg",
            ),
            const SizedBox(
              height: 25,
            ),
            const Text('Your order has been Successfully Placed'),
            const SizedBox(
              height: 10,
            ),
            const Text('Order ID: OMA000000933'),
            const SizedBox(
              height: 20,
            ),
            Positioned(
              bottom: 10.0,
              top: 100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, right: 10.0, bottom: 0.0, left: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    backgroundColor: themecolor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(55)),
                  ),
                  onPressed: () {},
                  child: const Text('View Order Details'),
                ),
              ),
            ),
          ]),
    );
  }
}
