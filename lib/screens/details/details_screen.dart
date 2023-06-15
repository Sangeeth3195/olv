import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/models/Product_detail.dart';
import 'package:omaliving/screens/cart/cart_screen.dart';
import 'package:omaliving/screens/home/components/search_form.dart';

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

      Scaffold(
        appBar: AppBar(
          backgroundColor: omaColor,
          leading: IconButton(
            onPressed: () {

              Navigator.pushNamed(context, CartScreen.routeName);

            },
            icon: SvgPicture.asset(
              "assets/icons/menu.svg",
              color: headingColor,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Image.asset('assets/omalogo.png', height: 50, width: 100),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.person,
                size: 30,
                color: Colors.brown,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.shoppingBag,
                color: Colors.brown,
              ),
              onPressed: () {},
            ),
          ],
        ),

        body: Container(
          color: Colors.white,
          child: ListView(
        children: [

          Container(
            height: 70,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: searchBackgroundColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: const SearchForm(),
          ),
          const SizedBox(
            height: 20,
          ),
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
        ),
      );
  }
}
