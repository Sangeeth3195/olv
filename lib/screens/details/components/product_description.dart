import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/models/Product_detail.dart';
import 'package:omaliving/screens/details/components/product_images.dart';
import 'package:omaliving/screens/details/components/top_rounded_container.dart';
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

  final String product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  int quantity = 1;
  GraphQLService graphQLService = GraphQLService();
  MyProvider? myProvider;
  bool _isExpanded = false;
  bool _isExpanded1 = false;
  bool _isExpanded2 = false;
  bool isConfiguredProduct = false;
  int configurableProductIndex = 0;
  int configurableProductSizeIndex = 0;
  bool? isWishListed;

  ScrollController scrollController = ScrollController();

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
    myProvider = Provider.of<MyProvider>(context, listen: false);
    // if (kDebugMode) {
    //   print('name --> ' + widget.product['name']);
    //   print('id --> ${widget.product['id']}');
    //
    // }
  }

  void getNavdata() async {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider.updateProductDescriptionData(widget.product.toString());
  }

  void _changeColor(int index) {
    configurableProductIndex = index;
    setState(() {});
  }

  void _changeSize(int index) {
    configurableProductSizeIndex = index;
    setState(() {});
  }

  void _onExpansionChanged(bool isExpanded) {
    setState(() {
      _isExpanded = isExpanded;
    });
  }

  void _onExpansionChanged1(bool isExpanded) {
    setState(() {
      _isExpanded1 = isExpanded;
    });
  }

  void _onExpansionChanged2(bool isExpanded) {
    setState(() {
      _isExpanded2 = isExpanded;
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
          log(provider.productData[0]['__typename']);


          // print('restart');
          if (isWishListed == null) {
            isWishListed = provider.productData[0]['is_wishlisted'];
          }
          if (provider.productData[0]['__typename'] == "ConfigurableProduct") {
            isConfiguredProduct = true;
          } else {
            isConfiguredProduct = false;
          }
          print(isConfiguredProduct);
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                ProductImages(
                    product: provider.productData,
                    configurableProductIndex: configurableProductIndex,
                    isConfigurableProduct: isConfiguredProduct),
                TopRoundedContainer(
                  color: omaColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(10)),
                        child: Text(
                            isConfiguredProduct
                                ? provider.productData[0]['variants']
                                    [configurableProductIndex]['product']['name']
                                : provider.productData[0]['name'],
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
                            isConfiguredProduct
                                ? provider.productData[0]['variants']
                                        [configurableProductIndex]['product']
                                        ['price_range']['minimum_price']
                                        ['regular_price']['value']
                                    .toString()
                                : "₹ " + provider.productData[0]['__typename'] ==
                                        "SimpleProduct"
                                    ? provider.productData[0]['price_range']
                                            ['minimum_price']['regular_price']
                                            ['value']
                                        .toString()
                                    : '₹' +
                                        "${provider.productData[0]['price_range']['minimum_price']['regular_price']['value']}",
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
                                fontWeight: FontWeight.bold,
                                color: headingColor)),
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
                            isConfiguredProduct
                                ? provider.productData[0]['variants']
                                        [configurableProductIndex]['product']
                                        ['short_description']['html']
                                    .toString()
                                : provider.productData[0]['short_description']
                                        ['html']
                                    .toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: headingColor,
                                height: 1.3,
                                fontSize: 15)),
                      ),
                      const SizedBox(
                        height: 0,
                      ),

                      provider.productData[0]['configurable_options'] != null &&
                              provider.productData[0]['configurable_options'][0]
                                      ['label'] ==
                                  "size"
                          ? Row(
                              children: [
                                /* Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(10)),
                                  child: const Text('SIZE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: headingColor)),
                                ),*/
                                const SizedBox(
                                  width: 10,
                                ),
                                provider.productData[0]['__typename'] ==
                                        "ConfigurableProduct"
                                    ? Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: provider
                                                  .productData[0]
                                                      ['configurable_options'][0]
                                                      ['values']
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                    onTap: () {
                                                      _changeSize(index);
                                                    },
                                                    child: Chip(
                                                      backgroundColor: chipColor,
                                                      label: Padding(
                                                        padding: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 16.0),
                                                        child: Text(
                                                          "${provider.productData[0]['configurable_options'][0]['values'][index]['swatch_data']['value']}",
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                0.0),
                                                        // Adjust the border radius for rectangle shape
                                                        side: const BorderSide(
                                                          color: omaColor,
                                                        ),
                                                       ),
                                                    ));
                                              },
                                            ),
                                          ),

                                          /* Chip(
                                            backgroundColor: chipColor,
                                            label: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.0),
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.0),
                                              child: Text('4.57 "'),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(0.0),
                                              // Adjust the border radius for rectangle shape
                                              side: const BorderSide(color: omaColor),
                                            ),
                                          ),*/
                                          // Add more chips as needed
                                        ],
                                      )
                                    : Container(),
                              ],
                            )
                          : Container(),

                      // provider.productData[0]['__typename'] == "ConfigurableProduct"
                      //     ? Row(
                      //         children: [
                      //           Padding(
                      //             padding: EdgeInsets.symmetric(
                      //                 horizontal: getProportionateScreenWidth(10)),
                      //             child: const Text('SIZE',
                      //                 style: TextStyle(
                      //                     fontWeight: FontWeight.bold,
                      //                     color: headingColor)),
                      //           ),
                      //           const SizedBox(
                      //             width: 10,
                      //           ),
                      //
                      //           provider.productData[0]['__typename'] ==
                      //                   "ConfigurableProduct"
                      //               ? Row(
                      //                   children: [
                      //                     SizedBox(
                      //                       height: 50,
                      //                       child: ListView.builder(
                      //                         shrinkWrap: true,
                      //                         scrollDirection: Axis.horizontal,
                      //                         itemCount: provider
                      //                             .productData[0]
                      //                                 ['configurable_options'][0]
                      //                                 ['values']
                      //                             .length,
                      //                         itemBuilder: (context, index) {
                      //                           return GestureDetector(
                      //                               onTap: () {
                      //                                 // _changeColor(index);
                      //                               },
                      //                               child: Chip(
                      //                                 backgroundColor: chipColor,
                      //                                 label: Padding(
                      //                                   padding:
                      //                                       const EdgeInsets.symmetric(
                      //                                           horizontal: 16.0),
                      //                                   child: Text(
                      //                                     "${provider.productData[0]['configurable_options'][0]['values'][index]['swatch_data']['value']}",
                      //                                     style: const TextStyle(
                      //                                         color: Colors.white),
                      //                                   ),
                      //                                 ),
                      //                                 shape: RoundedRectangleBorder(
                      //                                   borderRadius:
                      //                                       BorderRadius.circular(0.0),
                      //                                   // Adjust the border radius for rectangle shape
                      //                                   side: const BorderSide(
                      //                                     color: omaColor,
                      //                                   ),
                      //                                 ),
                      //                               ));
                      //                         },
                      //                       ),
                      //                     ),
                      //
                      //                     /* Chip(
                      //                       backgroundColor: chipColor,
                      //                       label: const Padding(
                      //                         padding: EdgeInsets.symmetric(
                      //                             horizontal: 16.0),
                      //                         child: Text(
                      //                           '8.66 "',
                      //                           style: TextStyle(color: Colors.white),
                      //                         ),
                      //                       ),
                      //                       shape: RoundedRectangleBorder(
                      //                         borderRadius: BorderRadius.circular(0.0),
                      //                         // Adjust the border radius for rectangle shape
                      //                         side: const BorderSide(
                      //                           color: omaColor,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     const SizedBox(
                      //                       width: 5,
                      //                     ),
                      //                     Chip(
                      //                       backgroundColor: chip2Color,
                      //                       label: const Padding(
                      //                         padding: EdgeInsets.symmetric(
                      //                             horizontal: 16.0),
                      //                         child: Text('4.57 "'),
                      //                       ),
                      //                       shape: RoundedRectangleBorder(
                      //                         borderRadius: BorderRadius.circular(0.0),
                      //                         // Adjust the border radius for rectangle shape
                      //                         side: const BorderSide(color: omaColor),
                      //                       ),
                      //                     ),*/
                      //                     // Add more chips as needed
                      //                   ],
                      //                 )
                      //               : Container(),
                      //         ],
                      //       )
                      //     : Container(),  // provider.productData[0]['__typename'] == "ConfigurableProduct"
                      //     ? Row(
                      //         children: [
                      //           Padding(
                      //             padding: EdgeInsets.symmetric(
                      //                 horizontal: getProportionateScreenWidth(10)),
                      //             child: const Text('SIZE',
                      //                 style: TextStyle(
                      //                     fontWeight: FontWeight.bold,
                      //                     color: headingColor)),
                      //           ),
                      //           const SizedBox(
                      //             width: 10,
                      //           ),
                      //
                      //           provider.productData[0]['__typename'] ==
                      //                   "ConfigurableProduct"
                      //               ? Row(
                      //                   children: [
                      //                     SizedBox(
                      //                       height: 50,
                      //                       child: ListView.builder(
                      //                         shrinkWrap: true,
                      //                         scrollDirection: Axis.horizontal,
                      //                         itemCount: provider
                      //                             .productData[0]
                      //                                 ['configurable_options'][0]
                      //                                 ['values']
                      //                             .length,
                      //                         itemBuilder: (context, index) {
                      //                           return GestureDetector(
                      //                               onTap: () {
                      //                                 // _changeColor(index);
                      //                               },
                      //                               child: Chip(
                      //                                 backgroundColor: chipColor,
                      //                                 label: Padding(
                      //                                   padding:
                      //                                       const EdgeInsets.symmetric(
                      //                                           horizontal: 16.0),
                      //                                   child: Text(
                      //                                     "${provider.productData[0]['configurable_options'][0]['values'][index]['swatch_data']['value']}",
                      //                                     style: const TextStyle(
                      //                                         color: Colors.white),
                      //                                   ),
                      //                                 ),
                      //                                 shape: RoundedRectangleBorder(
                      //                                   borderRadius:
                      //                                       BorderRadius.circular(0.0),
                      //                                   // Adjust the border radius for rectangle shape
                      //                                   side: const BorderSide(
                      //                                     color: omaColor,
                      //                                   ),
                      //                                 ),
                      //                               ));
                      //                         },
                      //                       ),
                      //                     ),
                      //
                      //                     /* Chip(
                      //                       backgroundColor: chipColor,
                      //                       label: const Padding(
                      //                         padding: EdgeInsets.symmetric(
                      //                             horizontal: 16.0),
                      //                         child: Text(
                      //                           '8.66 "',
                      //                           style: TextStyle(color: Colors.white),
                      //                         ),
                      //                       ),
                      //                       shape: RoundedRectangleBorder(
                      //                         borderRadius: BorderRadius.circular(0.0),
                      //                         // Adjust the border radius for rectangle shape
                      //                         side: const BorderSide(
                      //                           color: omaColor,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     const SizedBox(
                      //                       width: 5,
                      //                     ),
                      //                     Chip(
                      //                       backgroundColor: chip2Color,
                      //                       label: const Padding(
                      //                         padding: EdgeInsets.symmetric(
                      //                             horizontal: 16.0),
                      //                         child: Text('4.57 "'),
                      //                       ),
                      //                       shape: RoundedRectangleBorder(
                      //                         borderRadius: BorderRadius.circular(0.0),
                      //                         // Adjust the border radius for rectangle shape
                      //                         side: const BorderSide(color: omaColor),
                      //                       ),
                      //                     ),*/
                      //                     // Add more chips as needed
                      //                   ],
                      //                 )
                      //               : Container(),
                      //         ],
                      //       )
                      //     : Container(),

                      const SizedBox(
                        height: 10,
                      ),

                      provider.productData[0]['configurable_options'] != null &&
                              provider.productData[0]['configurable_options'][0]
                                      ['label'] ==
                                  "Color"
                          ? Row(
                              children: [
                                /* Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(10)),
                                  child: const Text('COLOR',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: headingColor)),
                                ),*/
                                const SizedBox(
                                  width: 10,
                                ),
                                provider.productData[0]['__typename'] ==
                                        "ConfigurableProduct"
                                    ? Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: provider
                                                  .productData[0]
                                                      ['configurable_options'][0]
                                                      ['values']
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    print(provider.productData[0][
                                                            'configurable_options']
                                                        [0]['label']);
                                                    print(provider
                                                            .productData[0][
                                                                'configurable_options']
                                                                [0]['values']
                                                            .length +
                                                        index);
                                                    _changeColor(index);
                                                    // print('color code --> ' +
                                                    //     provider.productData[0][
                                                    //                 'configurable_options']
                                                    //             [0]['values'][index]
                                                    //         ['value_index'].toString());
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(horizontal: 5),
                                                    padding:
                                                        const EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color:
                                                              configurableProductIndex ==
                                                                      index
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .transparent,
                                                          width:
                                                              2.0), // Using BorderSide with BoxDecoration

                                                      color: colorFromHex(provider
                                                                      .productData[0]
                                                                  [
                                                                  'configurable_options']
                                                              [0]['values'][index]
                                                          [
                                                          'swatch_data']['value']),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            )
                          : Container(),

                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: getProportionateScreenWidth(10)),
                          //   child: const Text('QUANTITY',
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.bold, color: headingColor)),
                          // ),
                          const SizedBox(
                            width: 12,
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
                        height: 40,

                        width: double.infinity,
                        // Set the container width to occupy the full width
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        // Adjust margins as needed
                        child: ElevatedButton(
                          onPressed: () {
                            print(quantity.toString());
                            // Button onPressed action
                            // graphQLService.create_cart_non_user();
                            // graphQLService.create_cart();

                            EasyLoading.show(status: 'loading...');

                            if (provider.productData[0]['configurable_options'] ==
                                'configurable_options') {
                              print(widget.product.toString());

                              print(provider.productData[0]['variants']
                                  [configurableProductIndex]['product']['sku']);

                              graphQLService.addProductToCart(
                                provider.productData[0]['variants']
                                    [configurableProductIndex]['product']['sku'],
                                quantity.toString(),
                                context: context
                              );
                            } else {
                              graphQLService.addProductToCart(
                                widget.product.toString(),
                                quantity.toString(),
                                  context: context

                              );
                            }

                            // graphQLService.update_product_to_cart(
                            //   widget.product['sku'].toString(),
                            //   quantity.toStringAsFixed(0),
                            // );
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
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 80,
                            height: 40,
                            // Set the container width to occupy the full width
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 4),
                            // Adjust margins as needed
                            child: ElevatedButton(
                              onPressed: () {
                                EasyLoading.show(status: 'loading...');

                                if (provider.productData[0]
                                        ['configurable_options'] ==
                                    'configurable_options') {
                                  print(widget.product.toString());

                                  print(provider.productData[0]['variants']
                                          [configurableProductIndex]['product']
                                      ['sku']);

                                  graphQLService.addProductToCart(
                                    provider.productData[0]['variants']
                                            [configurableProductIndex]['product']
                                        ['sku'],
                                    quantity.toString(),
                                    context: context
                                  );
                                } else {
                                  graphQLService.addProductToCart(
                                    widget.product.toString(),
                                    quantity.toString(),
                                    context: context
                                  );
                                }

                                /*if (provider.productData[0]['configurable_options'] !=
                                    'configurable_options') {
                                  print(widget.product['sku'].toString());

                                  print(provider.productData[0]['variants'][0]
                                      ['product']['sku']);

                                  graphQLService.addProductToCart(
                                    provider.productData[0]['variants'][0]['product']
                                        ['sku'],
                                    '1',
                                  );
                                } else {
                                  print('widget.product.toString()');
                                }

                                graphQLService.addProductToCart(
                                  widget.product['sku'].toString(),
                                  '1',
                                );*/
                              },
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(color: headingColor),
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.all(
                                    5), // Set the background color
                              ),
                              child: const Text(
                                "Buy Now",
                                style:
                                    TextStyle(fontSize: 14, color: headingColor),
                              ),
                            ),
                          ),
                          Container(
                              height: 40,
                              // padding: const EdgeInsets.symmetric(
                              //     horizontal: 1.0,
                              //     vertical: 1), // Adjust padding as needed
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: headingColor, // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    0.0), // Adjust border radius as needed
                              ),
                              child: IconButton(
                                  onPressed: () async {
                                    print(widget.product.toString());

                                    if (myProvider!
                                            .customerModel?.customer?.email !=
                                        null) {
                                      if (isWishListed ?? false) {
                                        dynamic listData = await graphQLService
                                            .add_Product_from_wishlist(
                                          wishlistId: myProvider!.customerModel
                                              .customer!.wishlists![0].id!,
                                          sku: provider.productData[0]['sku']
                                              .toString(),
                                          qty: "1",
                                        );
                                      } else {
                                        dynamic listData = await graphQLService
                                            .remove_Product_from_wishlist(
                                                wishlistId: myProvider!
                                                    .customerModel
                                                    .customer!
                                                    .wishlists![0]
                                                    .id!,
                                                wishlistItemsIds: provider
                                                    .productData[0]['sku']
                                                    .toString());
                                      }

                                      isWishListed = !isWishListed!;

                                      print(isWishListed);

                                      setState(() {});

                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Please Login for wishlist an item');
                                    }
                                  },
                                  icon: Icon(
                                    isWishListed ?? false
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isWishListed ?? false
                                        ? Colors.red
                                        : themecolor,
                                  )))
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: ExpansionTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          leading: _isExpanded
                              ? const Icon(
                            Icons.remove,
                            size: 20,
                            color: headingColor,
                          ) // Icon when expanded
                              : const Icon(
                            Icons.add,
                            size: 20,
                            color: headingColor,
                          ),
                          childrenPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          expandedCrossAxisAlignment: CrossAxisAlignment.end,
                          maintainState: true,
                          onExpansionChanged: _onExpansionChanged,
                          // trailing: _isExpanded
                          //     ? const Icon(Icons.remove) // Icon when expanded
                          //     : const Icon(Icons.add),
                          title: const Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                            child: Align(
                              alignment: Alignment(-1.5, 0),
                              child: Text(
                                'Detail',
                                style: TextStyle(
                                    color: headingColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ),
                          ),

                          children: [
                            SingleChildScrollView(
                              padding: const EdgeInsets.all(5.0),
                              child: Html(
                                data: '''${product[0]['detail']}''',
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(14.0),
                                    fontWeight: FontWeight.normal,
                                  ),
                                },
                              ),
                            ),
                          ],
                        ),


                        // HtmlExpansionTile(
                        //   title: 'Detail',
                        //   htmlContent: '''${product[0]['detail']}''',
                        // ),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: ExpansionTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          leading: _isExpanded1
                              ? const Icon(
                            Icons.remove,
                            size: 20,
                            color: headingColor,
                          ) // Icon when expanded
                              : const Icon(
                            Icons.add,
                            size: 20,
                            color: headingColor,
                          ),
                          childrenPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          expandedCrossAxisAlignment: CrossAxisAlignment.end,
                          maintainState: true,
                          onExpansionChanged: _onExpansionChanged1,
                          // trailing: _isExpanded
                          //     ? const Icon(Icons.remove) // Icon when expanded
                          //     : const Icon(Icons.add),
                          title: const Padding(
                            padding: EdgeInsets.fromLTRB(22, 0, 0, 0),
                            child: Align(
                              alignment: Alignment(-1.5, 0),
                              child: Text(
                                'Dimensions',
                                style: TextStyle(
                                    color: headingColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ),
                          ),

                          children: [
                            SingleChildScrollView(
                              padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 20),
                              child: Column(
                                children: [
                                  product[0]['height'] == null
                                      ? Container()
                                      : Text('Height: ' + product[0]['height']),
                                  product[0]['diameter'] == null
                                      ? Container()
                                      : Text('Diameter: ' +
                                      product[0]['diameter']),
                                  product[0]['capacity'] == null
                                      ? Container()
                                      : Text('Capacity: ' +
                                      product[0]['capacity']),
                                  product[0]['width'] == null
                                      ? Container()
                                      : Text('Width: ' + product[0]['width']),
                                  product[0]['length'] == null
                                      ? Container()
                                      : Text('Length: ' + product[0]['length']),
                                  product[0]['overall'] == null
                                      ? Container()
                                      : Text(
                                      'Overall: ' + product[0]['overall']),
                                  product[0]['depth'] == null
                                      ? Container()
                                      : Text('Depth: ' + product[0]['depth']),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // HtmlExpansionTile(
                        //   title: 'Care & Maintenance',
                        //   htmlContent: '''${product[0]['care']}''',
                        // ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: ExpansionTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          leading: _isExpanded2
                              ? const Icon(
                            Icons.remove,
                            size: 20,
                            color: headingColor,
                          ) // Icon when expanded
                              : const Icon(
                            Icons.add,
                            size: 20,
                            color: headingColor,
                          ),
                          childrenPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          expandedCrossAxisAlignment: CrossAxisAlignment.end,
                          maintainState: true,
                          onExpansionChanged: _onExpansionChanged2,
                          // trailing: _isExpanded
                          //     ? const Icon(Icons.remove) // Icon when expanded
                          //     : const Icon(Icons.add),
                          title: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Align(
                              alignment: Alignment(-1.5, 0),
                              child: Text(
                                'Care & Maintenance',
                                style: TextStyle(
                                    color: headingColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ),
                          ),

                          children: [
                            SingleChildScrollView(
                              padding: const EdgeInsets.all(5.0),
                              child: Html(
                                data: '''${product[0]['care']}''',
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(14.0),
                                    fontWeight: FontWeight.normal,
                                  ),
                                },
                              ),
                            ),
                          ],
                        ),

                        // HtmlExpansionTile(
                        //   title: 'Care & Maintenance',
                        //   htmlContent: '''${product[0]['care']}''',
                        // ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(10)),
                        child: const Text('Related Products',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: blackColor)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount:
                              provider.productData[0]['related_products'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildRelatedProducts(context, provider, index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  GestureDetector buildRelatedProducts(BuildContext context, MyProvider provider, int index) {
    return GestureDetector(
                          onTap: (){

                            myProvider!.updateProductDescriptionData(provider.productData[0]
                                ['related_products'][index]['sku'].toString());
                            setState((){
                              scrollController.animateTo(
                                0.0,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 500),
                              );});
                            // Navigator.of(context).pop();
                            // context.go("/wishlist/pdp", extra: provider.productData[0]
                            // ['related_products'][index]['sku'].toString());

                          },
                          child: Container(
                            width: 200,
                            // color: colors[index],
                            margin: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF4F2EE),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                defaultBorderRadius)),
                                      ),
                                      child: Image.network(
                                        provider.productData[0]
                                                ['related_products'][index]
                                                ['media_gallery'][0]['url']
                                            .toString(),
                                        height: 150,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                                          child: Text(
                                            '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: blackColor,
                                                height: 1.5,
                                                fontSize: 12),
                                          ),
                                        ),
                                        const SizedBox(height: 0.0),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5.0, 0, 0, 0),
                                          child: Text(
                                            provider.productData[0]
                                                    ['related_products'][index]
                                                ['name'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: blackColor,
                                                height: 1.5,
                                                fontSize: 13),
                                          ),
                                        ),
                                        // const SizedBox(height: 10.0),

                                        // Padding(
                                        //   padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                                        //   child:   Text("fjdkf"),
                                        //
                                        // ),

                                        /*Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                    child: Text(
                      '₹$price',
                      style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: headingColor,
                            height: 1.2,
                            fontSize: 13),
                    ),
                  ),*/

                                        const SizedBox(height: 10.0),

                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5.0, 0, 0, 0),
                                          child: Text(
                                            provider.productData[0]
                                                    ['related_products'][index]
                                                    ['price_range']
                                                    ['minimum_price']
                                                    ['regular_price']['value']
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: headingColor,
                                                height: 1.2,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Positioned(
                                    top: 0,
                                    right: 5,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.0, vertical: 6),
                                      child: IconButton(
                                        onPressed: () async{

                                          if (myProvider!
                                              .customerModel?.customer?.email !=
                                              null) {
                                            if (provider.productData[0]['related_products'][index]['is_wishlisted'] ?? false) {
                                              dynamic listData = await graphQLService
                                                  .add_Product_from_wishlist(
                                                wishlistId: myProvider!.customerModel
                                                    .customer!.wishlists![0].id!,
                                                sku: provider.productData[0]['related_products'][index]['sku'].toString(),
                                                qty: "1",
                                              );
                                            } else {
                                              dynamic listData = await graphQLService
                                                  .remove_Product_from_wishlist(
                                                  wishlistId: myProvider!
                                                      .customerModel
                                                      .customer!
                                                      .wishlists![0]
                                                      .id!,
                                                  wishlistItemsIds: provider.productData[0]['related_products'][index]['sku'].toString()                                                     .toString());
                                            }

                                            provider.productData[0]['related_products'][index]['is_wishlisted']= !provider.productData[0]['related_products'][index]['is_wishlisted'];
                                            setState(() {

                                            });


                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                'Please Login for wishlist an item');
                                          }

                                        },
                                        icon: Icon(
                                          provider.productData[0]['related_products'][index]['is_wishlisted']?Icons.favorite:Icons.favorite_border,
                                          color: provider.productData[0]['related_products'][index]['is_wishlisted']?Colors.red:blackColor,
                                          size: 22,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
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
      color: omaColor,
      elevation: 0,
      child: ExpansionTile(
        controlAffinity: ListTileControlAffinity.leading,
        leading: _isExpanded
            ? const Icon(
                Icons.remove,
                size: 20,
                color: headingColor,
              ) // Icon when expanded
            : const Icon(
                Icons.add,
                size: 20,
                color: headingColor,
              ),
        childrenPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        expandedCrossAxisAlignment: CrossAxisAlignment.end,
        maintainState: true,
        onExpansionChanged: _onExpansionChanged,
        // trailing: _isExpanded
        //     ? const Icon(Icons.remove) // Icon when expanded
        //     : const Icon(Icons.add),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Align(
            alignment: const Alignment(-1.5, 0),
            child: Text(
              widget.title,
              style: const TextStyle(
                  color: headingColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
        ),

        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(5.0),
            child: Html(
              data: widget.htmlContent,
              style: {
                "body": Style(
                  fontSize: FontSize(14.0),
                  fontWeight: FontWeight.normal,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
