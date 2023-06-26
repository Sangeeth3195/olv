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
        // margin: const EdgeInsets.all(defaultPadding / 2),
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
                      style: const TextStyle(color: textColor),
                    ),
                    const SizedBox(height: defaultPadding / 4),
                    Text(
                      "\$$price",
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(color: priceColor),
                    ),
                    const SizedBox(height: defaultPadding / 4),
                    const Text(
                      "Add to Cart",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
            const Positioned(top: 0,right: 10,child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0,vertical: 6),
              child: Icon(Icons.favorite_border, color: headingColor,),
            )),

          ],
        ),
      ),
    );
  }
}
