import 'package:flutter/material.dart';

import '../../../components/size_config.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 20),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: SizedBox(
              height: 200,
              child: Card(
                color: const Color(0xFFFCF6FD),
                borderOnForeground: true,
                elevation: 5,
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
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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

                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "Order ID: 000000933",
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
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('Button'),
                          )


                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "10:00am | Home delivery",
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
                              style: TextStyle(color: Colors.white),
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
                              "Track Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: SizedBox(
              height: 200,
              child: Card(
                color: const Color(0xFFFCF6FD),
                borderOnForeground: true,
                elevation: 5,
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
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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

                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "Order ID: 000000933",
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
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('Button'),
                          )


                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "10:00am | Home delivery",
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
                              style: TextStyle(color: Colors.white),
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
                              "Track Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: SizedBox(
              height: 200,
              child: Card(
                color: const Color(0xFFFCF6FD),
                borderOnForeground: true,
                elevation: 5,
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
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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

                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "Order ID: 000000933",
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
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('Button'),
                          )


                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "10:00am | Home delivery",
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
                              style: TextStyle(color: Colors.white),
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
                              "Track Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: SizedBox(
              height: 200,
              child: Card(
                color: const Color(0xFFFCF6FD),
                borderOnForeground: true,
                elevation: 5,
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
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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

                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "Order ID: 000000933",
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
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('Button'),
                          )


                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "10:00am | Home delivery",
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
                              style: TextStyle(color: Colors.white),
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
                              "Track Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: SizedBox(
              height: 200,
              child: Card(
                color: const Color(0xFFFCF6FD),
                borderOnForeground: true,
                elevation: 5,
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
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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

                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "Order ID: 000000933",
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
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('Button'),
                          )


                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "10:00am | Home delivery",
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
                              style: TextStyle(color: Colors.white),
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
                              "Track Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
