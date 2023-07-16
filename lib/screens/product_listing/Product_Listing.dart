import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'components/product_card.dart';
import 'components/search_form.dart';
import 'components/section_title.dart';

class ProductListing extends StatefulWidget {
  final int id;
  const ProductListing({Key? key, required this.id}) : super(key: key);
  static String routeName = "/home_screen";

  @override
  State<ProductListing> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProductListing> {
  String _selectedOption = "Popularity";
  GraphQLService graphQLService = GraphQLService();
  List<dynamic> pList=[];

  final List<String> _options = [
    'Popularity',
    'Product Name',
    'Lowest to Highest Price',
    'Highest to Lowest Price',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavdata();
  }
  void getNavdata() async {
    pList = await graphQLService.getproductlist(limit: 100,id: widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.8;
    final double itemWidth = size.width / 2;
    return Scaffold(
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
                  margin: const EdgeInsets.only(left: 4, top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
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
                      Icon(
                        FontAwesomeIcons.sliders,
                        color: headingColor,
                        size: 18.0,
                      ),
                      SizedBox(width: defaultPadding / 2),
                      Text(
                        "Filter",
                        style: TextStyle(
                            color: headingColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
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
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                           "Items",
                          style: TextStyle(
                              color: headingColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 3.3,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: headingColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(0.0),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 4, top: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1),
                      child: DropdownButton<String>(
                        underline: Container(),
                        isExpanded: true,
                        value: _selectedOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue!;
                          });
                        },
                        items: _options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 14),
                            ),
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
              padding: const EdgeInsets.all(5),
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: (itemWidth / itemHeight),
              maxCrossAxisExtent: 300.0,
              children: List.generate(
                pList.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: defaultPadding),
                  child: ProductCard(
                    title: pList[index]['name'],
                    image: pList[index]['small_image']['url'],
                    price: double.parse(pList[index]['price_range']['minimum_price']['final_price']['value'].toString()),
                    bgColor: demo_product[0].colors[0],
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(product: pList[index]),
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
