import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/screens/cart/cart_screen.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/home/components/product_card.dart';

import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';
import 'components/search_form.dart';
import 'components/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home_screen";


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedOption="Popularity";
  final List<String> _options = [
    'Popularity',
    'Product Name',
    'Lowest to Highest Proce',
    'Highest to Lowest Price',
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.8;
    final double itemWidth = size.width / 2;
    return Scaffold(
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
      body: Column(
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            child: SectionTitle(
              title: "New Arrival",
              pressSeeAll: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 4,top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.rectangle,
                    border: Border.all(color: headingColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(0.0),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.sort,color: headingColor,),
                      SizedBox(width: defaultPadding / 4),
                      Text(
                        "Filter",
                        style: TextStyle(
                            color: headingColor, fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                    ],
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: const [
                        SizedBox(height: 5,),
                        Text(
                          "84 Items",
                          style: TextStyle(
                              color: headingColor, fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: headingColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(0.0),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 4,top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                      child: DropdownButton<String>(
                        underline: Container(),

                        value: _selectedOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue!;
                          });
                        },
                        items: _options.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
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
