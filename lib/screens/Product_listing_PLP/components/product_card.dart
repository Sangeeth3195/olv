import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omaliving/models/ProductListJson.dart';
import 'package:omaliving/screens/cart/CartProvider.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../../API Services/graphql_service.dart';
import '../../../constants.dart';

class ProductCardPLP extends StatefulWidget {
  const ProductCardPLP({
    Key? key,
    required this.image,
    required this.title,
    required this.press,
    required this.bgColor,
    this.product,
    this.item,
  }) : super(key: key);
  final String image, title;
  final VoidCallback press;
  final Color bgColor;
  final dynamic product;
  final Item? item;

  @override
  State<ProductCardPLP> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCardPLP> {
  GraphQLService graphQLService = GraphQLService();

  int wishlist = 0;

  String cart_token = '';

  // create_cart

  int _selected = 0;
  MyProvider? myProvider;
  String? wishListID;

  String? image, title;
  String? price;
  Color? bgColor;
  Item? item;
  CartProvider? cartProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myProvider = Provider.of<MyProvider>(context, listen: false);
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    if (widget.item!.typename != "SimpleProduct") {
      try {
        _changeColor(
            0, widget.item!.configurableOptions[0].values[0].valueIndex);
      } catch (e) {
        print(e);
        title = widget.title;
        image = widget.item?.smallImage.url ?? '';
        price = widget.item!.getPriceRange.isEmpty
            ? widget.item!.textAttributes[0].normalprice
            : widget.item!.getPriceRange[0].normalpricevalue;
      }
    } else {
      title = widget.title;
      image = widget.item?.smallImage.url ?? '';
      price = widget.item!.getPriceRange.isEmpty
          ? widget.item!.textAttributes[0].normalprice
          : widget.item!.getPriceRange[0].normalpricevalue;
    }
  }

  void _changeColor(int index, int valueIndex) {
    setState(() {
      _selected = index;
    });

    for (final variants in widget.item!.variants) {
      for (final attributes in variants.attributes) {
        if (attributes.valueIndex == valueIndex) {
          setState(() {
            title = variants.product.name;
            image = variants.product.smallImage.url;
            price = variants.product.getPriceRange.isEmpty
                ? variants.product.textAttributes[0].normalprice
                : variants.product.getPriceRange[0].normalpricevalue;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.bgColor,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(defaultBorderRadius)),
                  ),
                  child: Image.network(
                    image ?? '',
                    height: 150,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/omalogo.png',
                        height: 150,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text(
                        widget.item!.dynamicAttributes[0].attributeValue
                            .toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: blackColor,
                            height: 1.5,
                            fontSize: 11),
                      ),
                    ),
                    const SizedBox(height: 0.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text(
                        title ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                            height: 1.5,
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text(price ?? ''),
                    ),
                    const SizedBox(height: 5.0),
                    widget.item!.textAttributes[0].specicalprice.toString() ==
                            null
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                            child: Text(
                              widget.item!.textAttributes[0].specicalprice
                                  .toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: headingColor,
                                  height: 1.2,
                                  fontSize: 12),
                            ),
                          )
                        : Container(),
                    widget.item!.typename == "ConfigurableProduct"
                        ? Row(
                            children: [
                              widget.item!.configurableOptions[0].label ==
                                      "Color"
                                  ? widget.item!.configurableOptions[0].values
                                              .length >
                                          2
                                      ? SizedBox(
                                          height: 50,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: widget
                                                        .item!
                                                        .configurableOptions[0]
                                                        .values
                                                        .length >
                                                    2
                                                ? 2
                                                : widget
                                                    .item!
                                                    .configurableOptions[0]
                                                    .values
                                                    .length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  log(widget
                                                      .item!
                                                      .configurableOptions[0]
                                                      .values[index]
                                                      .toJson()
                                                      .toString());
                                                  _changeColor(
                                                      index,
                                                      widget
                                                          .item!
                                                          .configurableOptions[
                                                              0]
                                                          .values[index]
                                                          .valueIndex);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: _selected ==
                                                                index
                                                            ? Colors.red
                                                            : Colors
                                                                .transparent,
                                                        width:
                                                            2.0), // Using BorderSide with BoxDecoration

                                                    shape: BoxShape.circle,
                                                    color: colorFromHex(widget
                                                        .item!
                                                        .configurableOptions[0]
                                                        .values[index]
                                                        .swatchData
                                                        .value),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : SizedBox(
                                          height: 50,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: widget
                                                .item!
                                                .configurableOptions[0]
                                                .values
                                                .length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  log(widget
                                                      .item!
                                                      .configurableOptions[0]
                                                      .values[index]
                                                      .toJson()
                                                      .toString());
                                                  _changeColor(
                                                      index,
                                                      widget
                                                          .item!
                                                          .configurableOptions[
                                                              0]
                                                          .values[index]
                                                          .valueIndex);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: _selected ==
                                                                index
                                                            ? Colors.brown
                                                            : Colors
                                                                .transparent,
                                                        width:
                                                            3.0), // Using BorderSide with BoxDecoration
                                                    color: colorFromHex(widget
                                                        .item!
                                                        .configurableOptions[0]
                                                        .values[index]
                                                        .swatchData
                                                        .value),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                  : Container(),
                              widget.item!.configurableOptions[0].label ==
                                      "Color"
                                  ? widget.item!.configurableOptions[0].values
                                              .length >
                                          2
                                      ? const Text(
                                          '+ More',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: headingColor,
                                              height: 1.2,
                                              fontSize: 13),
                                        )
                                      : Container()
                                  : Container(),
                            ],
                          )
                        : Container(),
                    GestureDetector(
                      onTap: () async {
                        EasyLoading.show(status: 'loading...');
                        graphQLService.addProductToCart(
                            widget.item!.sku.toString(), '1',
                            context: context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: headingColor,
                              height: 1.5,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
                top: 0,
                right: 5,
                child: InkWell(
                  onTap: () async {
                    if (myProvider!.customerModel.customer?.email != null) {
                      if (!widget.item!.wishlist) {
                        widget.item!.wishlist = true;
                        dynamic listData =
                            await graphQLService.add_Product_from_wishlist(
                                wishlistId: myProvider!
                                    .customerModel.customer!.wishlists![0].id!,
                                sku: widget.item!.sku.toString(),
                                qty: "1",
                                context: context);
                      } else {
                        widget.item!.wishlist = false;
                        dynamic listData =
                            await graphQLService.remove_Product_from_wishlist(
                                wishlistId: myProvider!
                                    .customerModel.customer!.wishlists![0].id!,
                                wishlistItemsIds: widget.item!.id.toString(),
                                context: context);
                      }
                      setState(() {});
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please Login for wishlist an item');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2.0, vertical: 6),
                    child: Icon(
                      widget.item!.wishlist
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.item!.wishlist ? Colors.red : blackColor,
                      size: 22,
                    ),
                  ),
                )),
          ],
        ),
        /*),*/
      ),
    );
  }

  Color colorFromHex(String hexColor) {
    // Remove the '#' character from the hex color code, if present.

    try {
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
    } catch (e) {
      return const Color(0xFFFFFFFF);
    }
  }
}
