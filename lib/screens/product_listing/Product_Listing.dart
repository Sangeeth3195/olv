import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';
import '../../models/CategoryInfo.dart';
import 'components/product_card.dart';

class ProductListing extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProductListing({Key? key, required this.data}) : super(key: key);
  static const String routeName = "/home_screen";

  @override
  State<ProductListing> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProductListing> {
  String _selectedOption = "Most Relevant";
  GraphQLService graphQLService = GraphQLService();
  List<dynamic> pList = [];
  CategoryInfo getcategoryInfo = CategoryInfo();

  var selectedColor = 0;

  final List<String> _options = [
    'Most Relevant',
    'Product Name',
    'Low to high',
    'High to low',
  ];

  final GlobalKey<ScaffoldState> _childDrawerKey = GlobalKey();
  RangeValues _currentRangeValues = const RangeValues(50, 200);

  int currentPage = 1;
  int itemsPerPage = 10;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    getNavdata();

    print('widget.data');

    print(widget.data['id']);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    print("scroll listener");
    // Check if the user has scrolled to the bottom
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // User has scrolled to the bottom, load more items
      setState(() {
        currentPage++;
      });
      final myProvider = Provider.of<MyProvider>(context, listen: false);
      myProvider.loadMoreData(widget.data['id'],
          limit: 20, currentPage: currentPage);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  void getNavdata() async {
    getcategoryInfo =
        await graphQLService.getCategoryInfo(widget.data['id'].toString());

    final myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider.updateData(widget.data['id'], limit: 20);
  }

  void filterData(Map<String, dynamic> filter) async {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider.updateDataWithFilter(widget.data['id'], filter);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final myProvider = Provider.of<MyProvider>(context, listen: false);
        if (myProvider.isproduct) {
          myProvider.isproduct = false;
          myProvider.notifyListeners();
        }
        return Future.value(true);
      },
      child: Consumer<MyProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            key: _childDrawerKey,
            drawer: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width - 50,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 15, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Apply Filters',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: priceColor,
                                  height: 1.5,
                                  fontSize: 18)),
                          Container(
                            height: 30,
                            width: 35,
                            color: priceColor,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(
                                    context); // Close the navigation drawer
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: provider.aggregationList.length,
                        itemBuilder: (BuildContext context, int subitemIndex) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  title: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        5.0, 0, 10, 5),
                                    child: Text(
                                      provider
                                          .aggregationList[subitemIndex].label,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: priceColor,
                                          height: 1.5,
                                          fontFamily: 'Gotham',
                                          fontSize: 14),
                                    ),
                                  ),
                                  children: [
                                    provider.aggregationList[subitemIndex]
                                                .label ==
                                            "Price"
                                        ? Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: RangeSlider(
                                              values: _currentRangeValues,
                                              min: 0,
                                              max: 300,
                                              divisions: 30,
                                              // Optional: Increase for a smoother slider
                                              onChanged: (RangeValues values) {
                                                setState(() {
                                                  _currentRangeValues = values;
                                                });
                                              },
                                              labels: RangeLabels(
                                                '\$${_currentRangeValues.start.round()}',
                                                '\$${_currentRangeValues.end.round()}',
                                              ),
                                            ),
                                          )
                                        : provider.aggregationList[subitemIndex]
                                                    .label ==
                                                "Color"
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5.0, 0, 10, 5),
                                                child: GridView.builder(
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 9,
                                                    // Number of columns
                                                    crossAxisSpacing: 5,
                                                    // Horizontal spacing between items
                                                    mainAxisSpacing:
                                                        5, // Vertical spacing between rows
                                                  ),
                                                  shrinkWrap: true,
                                                  itemCount: provider
                                                      .aggregationList[
                                                          subitemIndex]
                                                      .options
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final option = provider
                                                        .aggregationList[
                                                            subitemIndex]
                                                        .options[index];
                                                    final isSelected = provider
                                                        .aggregationList[
                                                            subitemIndex]
                                                        .selected
                                                        .contains(option.value);

                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (isSelected) {
                                                            provider
                                                                .aggregationList[
                                                                    subitemIndex]
                                                                .selected
                                                                .remove(option
                                                                    .value);
                                                          } else {
                                                            provider
                                                                .aggregationList[
                                                                    subitemIndex]
                                                                .selected
                                                                .add(option
                                                                    .value);
                                                          }
                                                        });
                                                        print(provider
                                                            .aggregationList[
                                                                subitemIndex]
                                                            .selected);
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 5),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: isSelected
                                                                ? Colors.red
                                                                : Colors
                                                                    .transparent
                                                                    .withOpacity(
                                                                        0.2),
                                                            // Change border color if selected
                                                            width: 2.0,
                                                          ),
                                                          shape:
                                                              BoxShape.circle,
                                                          color: colorFromHex(
                                                              option.swatchData!
                                                                  .value),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            /*Container(
                                                color: priceColor.withOpacity(0.3),

                                                child: Wrap(
                                                  children: List.generate(
                                                    provider
                                                        .aggregationList[
                                                            subitemIndex]
                                                        .options
                                                        .length,
                                                    (int index) {
                                                      return CheckboxListTile(
                                                        controlAffinity:
                                                            ListTileControlAffinity
                                                                .leading,
                                                        title: SizedBox(
                                                          height: 12,
                                                          width: 12,
                                                          child: Container(
                                                            margin: const EdgeInsets
                                                                .symmetric(horizontal: 5),
                                                            padding:
                                                            const EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width:
                                                                  2.0), // Using BorderSide with BoxDecoration

                                                              shape: BoxShape.circle,
                                                              color: colorFromHex(provider
                                                                  .aggregationList[
                                                              subitemIndex]
                                                                  .options[index].swatchData!.value),
                                                            ),
                                                          ),
                                                        ),
                                                        value: provider
                                                            .aggregationList[
                                                                subitemIndex]
                                                            .selected
                                                            .contains(provider
                                                                .aggregationList[
                                                                    subitemIndex]
                                                                .options[index]
                                                                .value),
                                                        // onselected method
                                                        onChanged:
                                                            (bool? selected) {
                                                          setState(() {
                                                            if (selected!) {
                                                              provider
                                                                  .aggregationList[
                                                                      subitemIndex]
                                                                  .selected
                                                                  .add(provider
                                                                      .aggregationList[
                                                                          subitemIndex]
                                                                      .options[
                                                                          index]
                                                                      .value);
                                                            } else {
                                                              provider
                                                                  .aggregationList[
                                                                      subitemIndex]
                                                                  .selected
                                                                  .remove(provider
                                                                      .aggregationList[
                                                                          subitemIndex]
                                                                      .options[
                                                                          index]
                                                                      .value);
                                                            }
                                                          });
                                                          print(provider
                                                              .aggregationList[
                                                                  subitemIndex]
                                                              .selected);
                                                        },
                                                      );
                                                    },
                                                  ).toList(),
                                                ),
                                              )
                                */
                                            : Column(
                                                // list of length 3
                                                children: List.generate(
                                                  provider
                                                      .aggregationList[
                                                          subitemIndex]
                                                      .options
                                                      .length,
                                                  (int index) {
                                                    // choice chip allow us to
                                                    // set its properties.
                                                    return CheckboxListTile(
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      title: Text(
                                                          "${provider.aggregationList[subitemIndex].options[index].label} (${provider.aggregationList[subitemIndex].options[index].count}) ",
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: blackColor,
                                                              height: 1,
                                                              fontSize: 12)),
                                                      value: provider
                                                          .aggregationList[
                                                              subitemIndex]
                                                          .selected
                                                          .contains(provider
                                                              .aggregationList[
                                                                  subitemIndex]
                                                              .options[index]
                                                              .value),
                                                      onChanged:
                                                          (bool? selected) {
                                                        setState(() {
                                                          if (selected!) {
                                                            provider
                                                                .aggregationList[
                                                                    subitemIndex]
                                                                .selected
                                                                .add(provider
                                                                    .aggregationList[
                                                                        subitemIndex]
                                                                    .options[
                                                                        index]
                                                                    .value);
                                                          } else {
                                                            provider
                                                                .aggregationList[
                                                                    subitemIndex]
                                                                .selected
                                                                .remove(provider
                                                                    .aggregationList[
                                                                        subitemIndex]
                                                                    .options[
                                                                        index]
                                                                    .value);
                                                          }
                                                        });
                                                        print(provider
                                                            .aggregationList[
                                                                subitemIndex]
                                                            .selected);
                                                      },
                                                    );
                                                  },
                                                ).toList(),
                                              ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container();
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          Map<String, dynamic> myMap = {};

                          for (int i = 0;
                              i < provider.aggregationList.length;
                              i++) {
                            myMap[provider.aggregationList[i].attributeCode] =
                                "{in: ${provider.aggregationList[i].selected}}";
                          }

                          log(myMap.toString());
                          filterData(myMap);
                          Navigator.of(context).pop();
                          // Define the action to perform when the button is pressed
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0), // Set the corner radius here
                          ),
                          padding: const EdgeInsets.all(
                              16.0), // Optional: Set padding for the button
                          // Customize other properties like background color, elevation, etc.
                        ),
                        child: const Text('Apply'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: Column(
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

                Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 148,
                          child: Text(
                            getcategoryInfo.category?.name ??
                                widget.data['name'],
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: headingColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 0),
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _childDrawerKey.currentState?.openDrawer();
                            },
                            // styling the button
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                                side: const BorderSide(
                                  color: themecolor,
                                  width: 0.5,
                                ),
                              ),
                              padding: const EdgeInsets.all(8),
                              // Button color
                              backgroundColor: omaColor,
                              // Splash color
                              foregroundColor: omaColor,
                            ),
                            // icon of the button
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/adjustment.png',
                                  width: 28,
                                  height: 22,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "FILTER",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: headingColor,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text(
                            '${getcategoryInfo.category?.products.totalCount ?? widget.data['product_count']} ITEMS',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: headingColor,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.0,
                                ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 35,
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: omaColor,
                              border: Border.all(
                                color: themecolor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: DropdownButton<String>(
                              value: _selectedOption,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedOption = newValue!;
                                });
                                provider.sort(newValue!);
                              },
                              underline: Container(),
                              items: _options.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0,
                                        color: navTextColor),
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
                    padding: const EdgeInsets.all(2),
                    childAspectRatio: 0.55,
                    maxCrossAxisExtent: 300,
                    cacheExtent: 10,
                    controller: _scrollController,
                    children: List.generate(
                      provider.items.length + 1,
                      (index) {
                        if (index < provider.items.length) {
                          return Padding(
                            padding: const EdgeInsets.all(3),
                            child: ProductCard(
                              title: provider.items[index].name,
                              image: provider.items[index].smallImage.url,
                              price: provider.items[index].typename ==
                                      "SimpleProduct"
                                  ? provider.items[index].price.regularPrice
                                      .amount.value
                                      .toString()
                                  : "",
                              product: provider.items[index],
                              bgColor: demo_product[0].colors[0],
                              item: provider.items[index],
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                          product: provider.items[index].sku),
                                    ));
                              },
                            ),
                          );
                        } else {
                          return const Center();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color colorFromHex(String hexColor) {
    // Remove the '#' character from the hex color code, if present.
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    // Check if the hex color code is valid.
    if (hexColor.length != 6) {
      throw const FormatException(
          "Invalid hex color code. It should be 6 characters long (excluding the '#').");
    }

    print(int.parse('FF$hexColor', radix: 16));
    // Parse the hexadecimal values and construct the Color object.
    return Color(int.parse('FF$hexColor', radix: 16));
  }
}
