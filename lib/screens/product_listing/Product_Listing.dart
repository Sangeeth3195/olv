import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';
import '../../PDP_UI.dart';
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
  List<dynamic> pList = [];
  int? _value = 0;
  int? _pricevalue = 0;
  List<String> materialOptions = []; // Placeholder for the fetched data
  List<String> materialSelectedOptions = [];

  int? _materialvalue=0;

  int? _collectionvalue=0;
  int? _aggregationOptionValue=0;
  int? _countryOptionValue=0;
  int? _fragranceOptionValue=0;
  int? _seasonOptionValue=0;
  int? _subclassOptionValue=0;

  var selectedColor=0;

  bool materialisOptionSelected(String option) {
    return materialSelectedOptions.contains(option);
  }

  void materialtoggleOption(String option) {
    setState(() {
      if (materialisOptionSelected(option)) {
        materialSelectedOptions.remove(option);
      } else {
        materialSelectedOptions.add(option);
      }
    });
  }
  final List<String> _options = [
    'Most Relevant',
    'Product Name',
    'Low to high',
    'High to low',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavdata();


  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  void getNavdata() async {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider.updateData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MyProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              /*Container(
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
              ),*/
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 10),
                      child: SectionTitle(
                        title: "New Arrival",
                        pressSeeAll: () {},
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(

                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        // <-- SEE HERE
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0),
                                      ),
                                    ),
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {

                                            return   SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const Center(
                                                    child: SizedBox(
                                                        width: 100,
                                                        child: Divider(
                                                          thickness: 4.0,
                                                        )),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.only(right: 10),
                                                          width: 24,
                                                          height: 24,

                                                          decoration: BoxDecoration(
                                                            color: Color(0xFFE6E6E6),
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.close,
                                                              color: Colors.black,
                                                              size: 24 * 0.6,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 10),
                                                    child: Text(
                                                      'Filter By',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          color: blackColor,
                                                          height: 1.5,
                                                          fontSize: 16),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 5),
                                                    child: Text(
                                                      'Price',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          color: blackColor,
                                                          height: 1.5,
                                                          fontSize: 12),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Wrap(
                                                      // list of length 3
                                                      children: List.generate(
                                                        provider.aggrecation[0]['options'].length,
                                                            (int index) {
                                                          // choice chip allow us to
                                                          // set its properties.
                                                          return ChoiceChip(
                                                            padding:
                                                            const EdgeInsets.all(8),
                                                            label: Text(provider.aggrecation[0]['options'][index]['label'],style:const TextStyle(
                                                                fontWeight: FontWeight.w200,
                                                                color: blackColor,
                                                                height: 1,
                                                                fontSize: 16)),
                                                            // color of selected chip
                                                            selectedColor: chipColor,

                                                            backgroundColor: Color(0xFFEFEFEF),
                                                            // selected chip value
                                                            selected: _pricevalue == index,
                                                            // onselected method
                                                            onSelected: (bool selected) {
                                                              setState(() {
                                                                _pricevalue =
                                                                selected ? index : null;
                                                              });
                                                              print(_pricevalue);
                                                            },
                                                          );
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ),

                                                  SizedBox(height: 20,),
                                                  //
                                                  // Padding(
                                                  //   padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 5),
                                                  //   child: Text(
                                                  //     'Color',
                                                  //     style: const TextStyle(
                                                  //         fontWeight: FontWeight.w700,
                                                  //         color: blackColor,
                                                  //         height: 1.5,
                                                  //         fontSize: 12),
                                                  //   ),
                                                  // ),
                                                  // ListView.builder(
                                                  //   itemCount: provider.aggrecation[1]['options'].length,
                                                  //   itemBuilder: (context, index) {
                                                  //     final color = provider.aggrecation[1]['options'][index]['swapvalue'];
                                                  //     return GestureDetector(
                                                  //       onTap: () {
                                                  //         setState(() {
                                                  //           selectedColor = color;
                                                  //         });
                                                  //       },
                                                  //       child: Container(
                                                  //         height: 80,
                                                  //         color: color,
                                                  //         child: Center(
                                                  //           child: Text(
                                                  //             color == selectedColor ? 'Selected' : 'Tap to Select',
                                                  //             style: TextStyle(color: Colors.white, fontSize: 20),
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     );
                                                  //   },
                                                  // ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 5),
                                                    child: Text(
                                                      'Material',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          color: blackColor,
                                                          height: 1.5,
                                                          fontSize: 12),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Wrap(
                                                      // list of length 3
                                                      children: List.generate(
                                                        provider.aggrecation[2]['options'].length,
                                                            (int index) {
                                                          // choice chip allow us to
                                                          // set its properties.
                                                          return ChoiceChip(
                                                            padding:
                                                            const EdgeInsets.all(8),
                                                            label: Text(provider.aggrecation[2]['options'][index]['label'],style:const TextStyle(
                                                                fontWeight: FontWeight.w200,
                                                                color: blackColor,
                                                                height: 1,
                                                                fontSize: 16)),
                                                            // color of selected chip
                                                            selectedColor: chipColor,

                                                            backgroundColor: Color(0xFFEFEFEF),
                                                            // selected chip value
                                                            selected: _materialvalue == index,
                                                            // onselected method
                                                            onSelected: (bool selected) {
                                                              setState(() {
                                                                _materialvalue =
                                                                selected ? index : null;
                                                              });
                                                              print(_materialvalue);
                                                            },
                                                          );
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 5),
                                                    child: Text(
                                                      'Collection',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          color: blackColor,
                                                          height: 1.5,
                                                          fontSize: 12),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Wrap(
                                                      // list of length 3
                                                      children: List.generate(
                                                        provider.aggrecation[3]['options'].length,
                                                            (int index) {
                                                          // choice chip allow us to
                                                          // set its properties.
                                                          return ChoiceChip(
                                                            padding:
                                                            const EdgeInsets.all(8),
                                                            label: Text(provider.aggrecation[3]['options'][index]['label'],style:const TextStyle(
                                                                fontWeight: FontWeight.w200,
                                                                color: blackColor,
                                                                height: 1,
                                                                fontSize: 16)),
                                                            // color of selected chip
                                                            selectedColor: chipColor,

                                                            backgroundColor: Color(0xFFEFEFEF),
                                                            // selected chip value
                                                            selected: _collectionvalue == index,
                                                            // onselected method
                                                            onSelected: (bool selected) {
                                                              setState(() {
                                                                _collectionvalue =
                                                                selected ? index : null;
                                                              });
                                                              print(_collectionvalue);
                                                            },
                                                          );
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20,),

                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 5),
                                                    child: Text(
                                                      'Collection',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          color: blackColor,
                                                          height: 1.5,
                                                          fontSize: 12),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Wrap(
                                                      // list of length 3
                                                      children: List.generate(
                                                        provider.aggrecation[3]['options'].length,
                                                            (int index) {
                                                          // choice chip allow us to
                                                          // set its properties.
                                                          return ChoiceChip(
                                                            padding:
                                                            const EdgeInsets.all(8),
                                                            label: Text(provider.aggrecation[3]['options'][index]['label'],style:const TextStyle(
                                                                fontWeight: FontWeight.w200,
                                                                color: blackColor,
                                                                height: 1,
                                                                fontSize: 16)),
                                                            // color of selected chip
                                                            selectedColor: chipColor,

                                                            backgroundColor: Color(0xFFEFEFEF),
                                                            // selected chip value
                                                            selected: _collectionvalue == index,
                                                            // onselected method
                                                            onSelected: (bool selected) {
                                                              setState(() {
                                                                _collectionvalue =
                                                                selected ? index : null;
                                                              });
                                                              print(_collectionvalue);
                                                            },
                                                          );
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 5),
                                                    child: Text(
                                                      'Type',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          color: blackColor,
                                                          height: 1.5,
                                                          fontSize: 12),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Wrap(
                                                      // list of length 3
                                                      children: List.generate(
                                                        provider.aggrecation[7]['options'].length,
                                                            (int index) {
                                                          // choice chip allow us to
                                                          // set its properties.
                                                          return ChoiceChip(
                                                            padding:
                                                            const EdgeInsets.all(8),
                                                            label: Text(provider.aggrecation[7]['options'][index]['label'],style:const TextStyle(
                                                                fontWeight: FontWeight.w200,
                                                                color: blackColor,
                                                                height: 1,
                                                                fontSize: 16)),
                                                            // color of selected chip
                                                            selectedColor: chipColor,

                                                            backgroundColor: Color(0xFFEFEFEF),
                                                            // selected chip value
                                                            selected: _countryOptionValue == index,
                                                            // onselected method
                                                            onSelected: (bool selected) {
                                                              setState(() {
                                                                _countryOptionValue =
                                                                selected ? index : null;
                                                              });
                                                              print(_countryOptionValue);
                                                            },
                                                          );
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 5),
                                                    child: Text(
                                                      'Brands',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          color: blackColor,
                                                          height: 1.5,
                                                          fontSize: 12),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Wrap(
                                                      // list of length 3
                                                      children: List.generate(
                                                        provider.aggrecation[8]['options'].length,
                                                            (int index) {
                                                          // choice chip allow us to
                                                          // set its properties.
                                                          return ChoiceChip(
                                                            padding:
                                                            const EdgeInsets.all(8),
                                                            label: Text(provider.aggrecation[8]['options'][index]['label'],style:const TextStyle(
                                                                fontWeight: FontWeight.w200,
                                                                color: blackColor,
                                                                height: 1,
                                                                fontSize: 16)),
                                                            // color of selected chip
                                                            selectedColor: chipColor,

                                                            backgroundColor: Color(0xFFEFEFEF),
                                                            // selected chip value
                                                            selected: _countryOptionValue == index,
                                                            // onselected method
                                                            onSelected: (bool selected) {
                                                              setState(() {
                                                                _countryOptionValue =
                                                                selected ? index : null;
                                                              });
                                                              print(_countryOptionValue);
                                                            },
                                                          );
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.all(10),

                                                    width:MediaQuery.of(context).size.width,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        // Define the action to perform when the button is pressed
                                                        print('Button Pressed');
                                                      },
                                                      child: Text('Apply'),
                                                      style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(16.0), // Set the corner radius here
                                                        ),
                                                        padding: EdgeInsets.all(16.0), // Optional: Set padding for the button
                                                        // Customize other properties like background color, elevation, etc.
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20,),

                                                ],
                                              ),
                                            );
                                          }

                                      );
                                    });
                              },
                              // styling the button
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(5),
                                // Button color
                                backgroundColor: filter,
                                // Splash color
                                foregroundColor: Colors.cyan,
                              ),
                              // icon of the button
                              child: const Icon(
                                FontAwesomeIcons.arrowsUpDown,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    // <-- SEE HERE
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                ),
                                builder: (context) {
                                  return StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {

                                    return   Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Center(
                                          child: SizedBox(
                                              width: 100,
                                              child: Divider(
                                                thickness: 4.0,
                                              )),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(right: 10),
                                                width: 24,
                                                height: 24,

                                                decoration: BoxDecoration(
                                                  color: Color(0xFFE6E6E6),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                    size: 24 * 0.6,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 10),
                                          child: Text(
                                            'Sort By',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: blackColor,
                                                height: 1.5,
                                                fontSize: 16),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 5),
                                          child: Text(
                                            'Price',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: blackColor,
                                                height: 1.5,
                                                fontSize: 12),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Wrap(
                                            // list of length 3
                                            children: List.generate(
                                              _options.length,
                                                  (int index) {
                                                // choice chip allow us to
                                                // set its properties.
                                                return ChoiceChip(
                                                  padding:
                                                  const EdgeInsets.all(8),
                                                  label: Text(_options[index],style:const TextStyle(
                                                      fontWeight: FontWeight.w200,
                                                      color: blackColor,
                                                      height: 1,
                                                      fontSize: 16)),
                                                  // color of selected chip
                                                  selectedColor: chipColor,

                                                  backgroundColor: Color(0xFFEFEFEF),
                                                  // selected chip value
                                                  selected: _value == index,
                                                  // onselected method
                                                  onSelected: (bool selected) {
                                                    setState(() {
                                                      _value =
                                                      selected ? index : null;
                                                    });
                                                    print(_value);
                                                  },
                                                );
                                              },
                                            ).toList(),
                                          ),
                                        ),

                                        SizedBox(height: 20,),
                                        Container(
                                          margin: EdgeInsets.all(10),

                                          width:MediaQuery.of(context).size.width,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Define the action to perform when the button is pressed
                                              print('Button Pressed');
                                            },
                                            child: Text('Apply'),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16.0), // Set the corner radius here
                                              ),
                                              padding: EdgeInsets.all(16.0), // Optional: Set padding for the button
                                              // Customize other properties like background color, elevation, etc.
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20,),

                                      ],
                                    );
                                  }

                                  );
                                });
                          },
                          // styling the button
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(5),
                            // Button color
                            backgroundColor: filter,
                            // Splash color
                            foregroundColor: Colors.cyan,
                          ),
                          // icon of the button
                          child: const Icon(
                            FontAwesomeIcons.filter,
                            color: Colors.black,
                            size: 20,
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
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(2),
                  childAspectRatio: 0.57,
                  maxCrossAxisExtent: 300,
                  children: List.generate(
                    provider.pList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(3),
                      child: ProductCard(
                        title: provider.pList[index]['name'],
                        image: provider.pList[index]['small_image']['url'],
                        price: provider.pList[index]['__typename'] ==
                                "SimpleProduct"
                            ? provider.pList[index]['price_range']
                                    ['minimum_price']['regular_price']['value']
                                .toString()
                            : "${provider.pList[index]['price_range']['minimum_price']['regular_price']['value']}"
                                " - ${provider.pList[index]['price_range']['minimum_price']['regular_price']['value']}",
                        product: provider.pList[index],
                        bgColor: demo_product[0].colors[0],



                        press: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    product: provider.pList[index]),
                              ));*/

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                    product: provider.pList[index]),
                              ));

                        },
                      ),
                    ),
                  ),
                ),
              ),

              /*Expanded(
                child: GridView.builder(
                    primary: false,
                    itemCount: pList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                        childAspectRatio: 2 / 3),
                    padding: const EdgeInsets.all(2),
                    itemBuilder:  (BuildContext ctx, i) {
                      return Padding(
                        padding: const EdgeInsets.only(right: defaultPadding),
                        child: ProductCard(
                          title: provider.pList[i]['name'],
                          image: provider.pList[i]['small_image']['url'],
                          price: provider.pList[i]['__typename'] ==
                              "SimpleProduct"
                              ? provider.pList[i]['price_range']
                          ['minimum_price']['regular_price']['value']
                              .toString()
                              : "${provider.pList[i]['price_range']['minimum_price']['regular_price']['value']}"
                              " - ${provider.pList[i]['price_range']['minimum_price']['regular_price']['value']}",
                          product: provider.pList[i],
                          bgColor: demo_product[0].colors[0],
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                      product: provider.pList[i]),
                                ));
                          },
                        ),
                      );
                    }
                ),
              )*/
            ],
          );
        },
      ),
    );
  }
}
