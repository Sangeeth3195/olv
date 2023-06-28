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
  }) : super(key: key);
  final String image, title;
  final VoidCallback press;
  final double price;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: 180,
        height: 200,
        padding: const EdgeInsets.all(defaultPadding / 2),
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
                    color: bgColor,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(defaultBorderRadius)),
                  ),
                  child: Image.asset(
                    image,
                    height: 150 ,
                  ),
                ),
                const SizedBox(height: defaultPadding / 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                        height: 1.5,
                        fontSize: 13),
                    ),
                    const SizedBox(height: defaultPadding / 5),
                    Text(
                      '\₹$price',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: headingColor,
                          height: 1.2,
                          fontSize: 13),
                    ),
                    const SizedBox(height: defaultPadding / 5),
                    const Text(
                      "Add to Cart",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: headingColor,
                          height: 1.5,
                          fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
            const Positioned(top: 0,right: 5,child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0,vertical: 6),
              child: Icon(Icons.favorite_border, color: headingColor,),
            )),

          ],
        ),
      ),
    );
  }
}
