import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/models/Product_detail.dart';

import '../../components/default_button.dart';
import '../../components/size_config.dart';
import 'components/color_dot.dart';
import 'components/color_dots.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    return

      Container(
        color: Colors.white,
        child: ListView(
      children: [

        ProductImages(product: product),



        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),

            ],
          ),
        ),
      ],
    ),
      );
  }
}
