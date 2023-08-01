import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.press,
    required this.bgColor,
    this.product,
  }) : super(key: key);
  final String image, title;
  final VoidCallback press;
  final String price;
  final Color bgColor;
  final dynamic product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Card(
          elevation: 0,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(defaultBorderRadius)),
                    ),
                    child: Image.network(
                      image,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: blackColor,
                              height: 1.5,
                              fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 0.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: blackColor,
                              height: 1.5,
                              fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Text(
                          '₹$price',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: headingColor,
                              height: 1.2,
                              fontSize: 13),
                        ),
                      ),

                      const SizedBox(height: 5.0),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Text(
                          'Clearance ₹356 - ₹446',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: headingColor,
                              height: 1.2,
                              fontSize: 12),
                        ),
                      ),

                      product['__typename'] == "ConfigurableProduct"
                          ? Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: product['configurable_options']
                                                    [0]['values']
                                                .length >
                                            0
                                        ? 2
                                        : product['configurable_options'][0]
                                            ['values'],
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // _changeColor(index);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: colorFromHex(
                                                product['configurable_options']
                                                        [0]['values'][index]
                                                    ['swatch_data']['value']),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                product['configurable_options'][0]['values']
                                            .length >
                                        2
                                    ? const Text(
                                        '+ More',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: headingColor,
                                            height: 1.2,
                                            fontSize: 13),
                                      )
                                    : Container(),
                              ],
                            )
                          : Container(),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: headingColor,
                              height: 1.5,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Positioned(
                  top: 0,
                  right: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 6),
                    child: Icon(
                      Icons.favorite_border,
                      color: blackColor,
                      size: 22,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Color colorFromHex(String hexColor) {
    // Remove the '#' character from the hex color code, if present.
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    // Check if the hex color code is valid.
    if (hexColor.length != 6) {
      throw const FormatException(
          "Invalid hex color code. It should be 6 characters long (excluding the '#').");
    }

    // Parse the hexadecimal values and construct the Color object.
    return Color(int.parse('FF$hexColor', radix: 16));
  }
}
