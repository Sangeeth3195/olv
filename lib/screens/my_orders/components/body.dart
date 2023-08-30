import 'package:flutter/material.dart';
import 'package:omaliving/screens/recent_order/recentorder.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 0),
          /*const Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Text(
              'Delivery',
              style:
                  TextStyle(color: headingColor, fontWeight: FontWeight.bold),
            ),
          ),*/
          const SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SizedBox(
              height: 170,
              child: Card(
                color: const Color(0xFFFCF6FD),
                borderOnForeground: true,
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Order ID: 000000933",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Total: ₹ 1,598",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Order Status: Delivered",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "26 June 2023",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          /*const SizedBox(
                            width: 4,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('View Order'),
                          )*/
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "Ship To : Mohamed Maideen",
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
                          MaterialButton(
                            color: headingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Reorder",
                              style: TextStyle(color: Colors.white,fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          /* MaterialButton(
                            color: headingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "View Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),*/
                          OutlinedButton(
                            onPressed: () {

                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => RecentOrders()));
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('View Order',style: TextStyle(color: headingColor,fontSize: 13),),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SizedBox(
              height: 170,
              child: Card(
                color: const Color(0xFFFCF6FD),
                borderOnForeground: true,
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Order ID: 000000933",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Total: ₹ 1,598",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Order Status: Delivered",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "26 June 2023",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          /*const SizedBox(
                            width: 4,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('View Order'),
                          )*/
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "Ship To : Mohamed Maideen",
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
                          MaterialButton(
                            color: headingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Reorder",
                              style: TextStyle(color: Colors.white,fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          /* MaterialButton(
                            color: headingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "View Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),*/
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('View Order',style: TextStyle(color: headingColor,fontSize: 13),),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SizedBox(
              height: 170,
              child: Card(
                color: const Color(0xFFFCF6FD),
                borderOnForeground: true,
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Order ID: 000000933",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Total: ₹ 1,598",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Order Status: Delivered",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "26 June 2023",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          /*const SizedBox(
                            width: 4,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('View Order'),
                          )*/
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "Ship To : Mohamed Maideen",
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
                          MaterialButton(
                            color: headingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Reorder",
                              style: TextStyle(color: Colors.white,fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          /* MaterialButton(
                            color: headingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "View Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),*/
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('View Order',style: TextStyle(color: headingColor,fontSize: 13),),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SizedBox(
              height: 170,
              child: Card(
                color: const Color(0xFFFCF6FD),
                borderOnForeground: true,
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Order ID: 000000933",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Total: ₹ 1,598",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Order Status: Delivered",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "26 June 2023",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          /*const SizedBox(
                            width: 4,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('View Order'),
                          )*/
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "Ship To : Mohamed Maideen",
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
                          MaterialButton(
                            color: headingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Reorder",
                              style: TextStyle(color: Colors.white,fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          /* MaterialButton(
                            color: headingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "View Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),*/
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('View Order',style: TextStyle(color: headingColor,fontSize: 13),),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SizedBox(
              height: 170,
              child: Card(
                color: const Color(0xFFFCF6FD),
                borderOnForeground: true,
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Order ID: 000000933",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Total: ₹ 1,598",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Order Status: Delivered",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "26 June 2023",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          /*const SizedBox(
                            width: 4,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('View Order'),
                          )*/
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "Ship To : Mohamed Maideen",
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
                          MaterialButton(
                            color: headingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Reorder",
                              style: TextStyle(color: Colors.white,fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          /* MaterialButton(
                            color: headingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "View Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),*/
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('View Order',style: TextStyle(color: headingColor,fontSize: 13),),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
