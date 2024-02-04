import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omaliving/models/ProductListJson.dart';
import 'package:omaliving/screens/cart/CartProvider.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../../API Services/graphql_service.dart';
import '../../../constants.dart';

class Product_Card_Custom extends StatefulWidget {
  const Product_Card_Custom({
    Key? key,
    required this.title,
    required this.image,
    required this.press,
    required this.bgColor,
  }) : super(key: key);
  final String title;
  final String image;
  final VoidCallback press;
  final Color bgColor;

  @override
  State<Product_Card_Custom> createState() => _ProductCardState();
}

class _ProductCardState extends State<Product_Card_Custom> {
  String? title;
  String? image;
  Color? bgColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(title.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.bgColor,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(defaultBorderRadius)),
                  ),
                  child: Image.network(
                    image ?? '',
                    height: 180,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/omalogo.png',
                        height: 180,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Center(
                        child: Text(
                          title.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'Gotham',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: navTextColor
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
