import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omaliving/models/Product_detail.dart';
import 'package:omaliving/screens/details/components/product_images.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../../API Services/graphql_service.dart';
import '../../../constants.dart';
import '../../../components/size_config.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Map<String, dynamic> product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  int quantity = 0;

  GraphQLService graphQLService = GraphQLService();
  bool _isExpanded = false;

  void incrementQuantity() {
    quantity++;
    setState(() {});
  }

  void decrementQuantity() {
    if (quantity > 0) {
      quantity--;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (kDebugMode) {
      print('name --> '+widget.product['name']);
      print('id --> ${widget.product['id']}');

      print('id --> ${widget.product['id']}');
    }
  }

  void getNavdata() async {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider.updateProductDescriptionData(widget.product['sku'].toString());
  }

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, _) {
        dynamic product = provider.productData;
        if (product == null) {
          return Container();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10)),
                child: Text(provider.productData[0]['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 18)),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10)),
                child: Text(
                    "₹ " + provider.productData[0]['__typename'] ==
                            "SimpleProduct"
                        ? provider.productData[0]['price_range']
                                ['minimum_price']['regular_price']['value']
                            .toString()
                        : '₹'+"${provider.productData[0]['price_range']['minimum_price']['regular_price']['value']}"
                            " - "+'₹'+"${provider.productData[0]['price_range']['minimum_price']['regular_price']['value']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: headingColor,
                        fontSize: 15)),
              ),
              const SizedBox(
                height: 16,
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10)),
                child: const Text('OVERVIEW',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: headingColor)),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(10),
                  right: getProportionateScreenWidth(10),
                ),
                child: Text(
                    provider.productData[0]['short_description']['html']
                        .toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: headingColor,
                        height: 1.3,
                        fontSize: 15)),
              ),
              const SizedBox(
                height: 18,
              ),

              provider.productData[0]['__typename'] == "ConfigurableProduct"
                  ?  Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10)),
                    child: const Text('SIZE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: headingColor)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),

                  provider.productData[0]['__typename'] == "ConfigurableProduct"
                      ?
                  Row(
                    children: [
                      Chip(
                        backgroundColor: chipColor,
                        label: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            '8.66 "',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          // Adjust the border radius for rectangle shape
                          side: const BorderSide(
                            color: omaColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Chip(
                        backgroundColor: chip2Color,
                        label: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('4.57 "'),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          // Adjust the border radius for rectangle shape
                          side: const BorderSide(color: omaColor),
                        ),
                      ),
                      // Add more chips as needed
                    ],
                  ) : Container(),
                ],
              ) : Container(),

              const SizedBox(
                height: 18,
              ),

              provider.productData[0]['__typename'] == "ConfigurableProduct"
                  ? Row(
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.productData[0]['configurable_options'][0]
                                            ['values']
                                        .length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // _changeColor(index);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorFromHex(
                                        provider.productData[0]['configurable_options'][0]
                                                ['values'][index]['swatch_data']
                                            ['value']),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),

              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10)),
                    child: const Text('QUANTITY',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: headingColor)),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: omaColor,
                      border: Border.all(
                        color: headingColor, // Border color
                        width: 0.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 34,
                          child: IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: headingColor,
                            ),
                            onPressed: () {
                              decrementQuantity();
                            },
                          ),
                        ),
                        Container(
                          height: 34,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8), // Adjust padding as needed
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: headingColor, // Border color
                              width: 1.0, // Border width
                            ),
                            borderRadius: BorderRadius.circular(
                                0.0), // Adjust border radius as needed
                          ),
                          child: Text(
                            quantity.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 34,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: headingColor,
                            ),
                            onPressed: () {
                              incrementQuantity();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                // Set the container width to occupy the full width
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                // Adjust margins as needed
                child: ElevatedButton(
                  onPressed: () {
                    // Button onPressed action
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(5),
                    primary: headingColor, // Set the background color
                  ),
                  child: const Text(
                    'ADD TO CART',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                // Set the container width to occupy the full width
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                // Adjust margins as needed
                child: ElevatedButton(
                  onPressed: () {
                    // Button onPressed action
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: headingColor),
                    backgroundColor: Colors.white,
                    padding:
                        const EdgeInsets.all(5), // Set the background color
                  ),
                  child: const Text(
                    'ADD TO WATCHLIST',
                    style: TextStyle(fontSize: 14, color: headingColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: HtmlExpansionTile(
                  title: 'Detail',
                  htmlContent: '''${product[0]['detail']}''',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Card(
                  color: chip2Color,
                  child: ExpansionTile(
                    onExpansionChanged: _onExpansionChanged,
                    trailing: _isExpanded
                        ? const Icon(Icons.remove) // Icon when expanded
                        : const Icon(Icons.add),
                    title: const Text(
                      'Dimensions',
                      style: TextStyle(color: headingColor),
                    ),
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            product[0]['height'] == null
                                ? Container()
                                : Text('Height: ' + product[0]['height']),
                            product[0]['diameter'] == null
                                ? Container()
                                : Text('Diameter: ' + product[0]['diameter']),
                            product[0]['capacity'] == null
                                ? Container()
                                : Text('Capacity: ' + product[0]['capacity']),
                            product[0]['width'] == null
                                ? Container()
                                : Text('Width: ' + product[0]['width']),
                            product[0]['length'] == null
                                ? Container()
                                : Text('Length: ' + product[0]['length']),
                            product[0]['overall'] == null
                                ? Container()
                                : Text('Overall: ' + product[0]['overall']),
                            product[0]['depth'] == null
                                ? Container()
                                : Text('Depth: ' + product[0]['depth']),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: HtmlExpansionTile(
                  title: 'Care & Maintenance',
                  htmlContent: '''${product[0]['care']}''',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          );
        }
      },
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

    // Parse the hexadecimal values and construct the Color object.
    return Color(int.parse('FF$hexColor', radix: 16));
  }
}

class HtmlExpansionTile extends StatefulWidget {
  final String title;
  final String htmlContent;

  HtmlExpansionTile({required this.title, required this.htmlContent});

  @override
  State<HtmlExpansionTile> createState() => _HtmlExpansionTileState();
}

class _HtmlExpansionTileState extends State<HtmlExpansionTile> {
  bool _isExpanded = false;

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: chip2Color,
      child: ExpansionTile(
        onExpansionChanged: _onExpansionChanged,
        trailing: _isExpanded
            ? const Icon(Icons.remove) // Icon when expanded
            : const Icon(Icons.add),
        title: Container(
            child: Text(widget.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, color: headingColor))),
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Html(
              data: widget.htmlContent,
            ),
          ),
        ],
      ),
    );
  }
}
