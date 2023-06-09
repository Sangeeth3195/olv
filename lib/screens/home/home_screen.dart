import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/home/components/product_card.dart';

import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';
import 'components/search_form.dart';
import 'components/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
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
            icon: const FaIcon(
              FontAwesomeIcons.user,
              color: Colors.brown,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: SearchForm(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            child: SectionTitle(
              title: "Decorative cushions",
              pressSeeAll: () {},
            ),
          ),
          Expanded(
            child: GridView.extent(
              primary: false,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: (itemWidth / itemHeight),
              maxCrossAxisExtent: 300.0,
              children: List.generate(
                demo_product.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: defaultPadding),
                  child: ProductCard(
                    title: demo_product[index].title,
                    image: demo_product[index].images[0],
                    price: demo_product[index].price,
                    bgColor: demo_product[index].colors[0],
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(product: demo_product[index]),
                          ));
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // body: SingleChildScrollView(
      //   physics: const BouncingScrollPhysics(
      //       parent: AlwaysScrollableScrollPhysics()),
      //   padding: const EdgeInsets.all(defaultPadding),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       // Text(
      //       //   "Explore",
      //       //   style: Theme.of(context)
      //       //       .textTheme
      //       //       .headline4!
      //       //       .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
      //       // ),
      //       // const Text(
      //       //   "best Outfits for you",
      //       //   style: TextStyle(fontSize: 18),
      //       // ),
      //       const Padding(
      //         padding: EdgeInsets.symmetric(vertical: defaultPadding),
      //         child: SearchForm(),
      //       ),
      //       const Categories(),
      //       const NewArrivalProducts(),
      //       const PopularProducts(),
      //     ],
      //   ),
      // ),
    );
  }
}
