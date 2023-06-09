import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/models/Product_detail.dart';

import 'components/color_dot.dart';
import 'components/product_images.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        // TopRoundedContainer(
        //   color: Colors.white,
        //   child: Column(
        //     children: [
        //       ProductDescription(
        //         product: product,
        //         pressOnSeeMore: () {},
        //       ),
        //       TopRoundedContainer(
        //         color: Color(0xFFF6F7F9),
        //         child: Column(
        //           children: [
        //             ColorDots(product: product),
        //             TopRoundedContainer(
        //               color: Colors.white,
        //               child: Padding(
        //                 padding: EdgeInsets.only(
        //                   left: SizeConfig.screenWidth * 0.15,
        //                   right: SizeConfig.screenWidth * 0.15,
        //                   bottom: getProportionateScreenWidth(40),
        //                   top: getProportionateScreenWidth(15),
        //                 ),
        //                 child: DefaultButton(
        //                   text: "Add To Cart",
        //                   press: () {},
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
