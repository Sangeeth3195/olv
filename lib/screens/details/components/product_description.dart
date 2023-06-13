import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omaliving/models/Product_detail.dart';

import '../../../constants.dart';
import '../../../components/size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final ProductDetail product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: Text(
            product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),

        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: Text(
            'OVERVIEW',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(10),
            right: getProportionateScreenWidth(10),
          ),
          child: Text(
            product.description,
            style: Theme.of(context).textTheme.headline6,

          ),
        ),

      ],
    );
  }
}
