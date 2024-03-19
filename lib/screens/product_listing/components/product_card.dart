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

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.press,
    required this.openDrawer,
    required this.bgColor,
    this.product,
    this.item,
  }) : super(key: key);
  final String image, title;
  final VoidCallback press;
  final VoidCallback openDrawer;
  final String price;
  final Color bgColor;
  final dynamic product;
  final Item? item;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  GraphQLService graphQLService = GraphQLService();

  int wishlist = 0;

  String cart_token = '';

  int _selected = 0;
  MyProvider? myProvider;
  String? wishListID;

  String? image, title;
  String? price;
  Color? bgColor;
  Item? item;
  CartProvider? cartProvider;
  String spl_price = "0";
  bool isExpired = false;
  String? _price_text;
  String? _price_value;
  bool isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myProvider = Provider.of<MyProvider>(context, listen: false);
    cartProvider = Provider.of<CartProvider>(context, listen: false);

    calculatePrice();

    print(widget.title);
    print(widget.image);

    if (widget.item!.typename == 'ConfigurableProduct' ) {
      setState(() {
        isVisible = true;
      });
    }

    if (widget.item!.typename != "SimpleProduct") {
      try {
        _changeColor(
            0, widget.item!.configurableOptions![0].values[0].valueIndex);
      } catch (e) {
        print(e);
        title = widget.title;
        image = widget.item?.smallImage.url ?? '';
        price = widget.item!.getPriceRange!.isEmpty
            ? widget.item!.textAttributes[0].normalprice
            : widget.item!.getPriceRange![0].normalpricevalue;
      }
    } else {
      title = widget.title;
      image = widget.item?.smallImage.url ?? '';
      price = widget.item!.getPriceRange!.isEmpty
          ? widget.item!.textAttributes[0].normalprice
          : widget.item!.getPriceRange![0].normalpricevalue;
    }
  }

  void calculatePrice() {
    print('date${widget.item!.specialToDate}');

    if (widget.item?.specialToDate != null &&
        widget.item?.specialToDate != '') {
      DateTime dt1;
      dt1 = DateTime.parse(widget.item!.specialToDate);
      DateTime currentDate = DateTime.now();
      isExpired = currentDate.isAfter(dt1);
    }

    print("isExpired --> $isExpired");
    if (widget.item!.textAttributes[0].specicalprice == '0' ) {
      isExpired = true;
    }

    String tagName = widget.item!.textAttributes[0].specicalprice.toString();

    final split = tagName.split('₹');

    final Map<int, String> values = {
      for (int i = 0; i < split.length; i++) i: split[i]
    };

    _price_text = values[0];
    _price_value = values[1];
  }

  void _changeColor(int index, int valueIndex) {
    setState(() {
      _selected = index;
    });

    for (final variants in widget.item!.variants!) {
      for (final attributes in variants.attributes) {
        if (attributes.valueIndex == valueIndex) {
          setState(() {
            title = variants.product.name;
            image = variants.product.mediaGallery[0].url;
            // price = variants.product.priceRange!.minimumPrice!.regularPrice!.value!
            //     ? variants.product!.textAttributes![0].normalprice!
            //     : variants.product.getPriceRange![0].normalpricevalue;
          });
        }
      }
    }
    // widget.item!.variants.map((e) {
    //   log(e.typename);
    //   e.attributes.map((attributes) {
    //     log(attributes.typename);
    //     if(attributes.valueIndex==valueIndex){
    //       log(attributes.typename);
    //
    //       setState(() {
    //         title = e.product.name;
    //         image = e.product.smallImage.url;
    //         price=  e.product.typename == "SimpleProduct"
    //             ? e.product.priceRange.minimumPrice
    //             .regularPrice.value
    //             .toString()
    //             : "${e.product.priceRange.minimumPrice.regularPrice.value}"
    //             " - ${e.product.priceRange.minimumPrice.regularPrice.value}";
    //
    //       });
    //     }
    //   });
    // });
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
                    widget.image ?? '',
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
                      padding: const EdgeInsets.fromLTRB(5.0, 5, 0, 0),
                      child: Text(
                        widget.item!.dynamicAttributes[0].attributeValue
                            .toString()
                            .toUpperCase(),
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
                        widget.title ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: blackColor,
                            height: 1.5,
                            fontSize: 13),
                      ),
                    ),

                    const SizedBox(height: 5.0),

                    Visibility(
                      visible: isVisible,
                      child:  widget.item!.typename == "ConfigurableProduct"
                        ? Column(
                            children: [
                              Text(widget.item!.getPriceRange![0].oldpricevalue
                                  .toString()),
                              Text(widget
                                  .item!.getPriceRange![0].normalpricevalue
                                  .toString()),
                            ],
                          )
                        : Container(),
                    ),

                    widget.item!.typename == "SimpleProduct"
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "₹ ${widget.item!.price.regularPrice.amount.value}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    decoration: !isExpired
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    fontFamily: 'Gotham',
                                  ),
                                ),
                                !isExpired
                                    ? Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                                text: _price_text,
                                                style: const TextStyle(
                                                    color: Color(0xFF983030))),
                                            TextSpan(
                                              text: _price_value,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          )
                        : Container(),
                    widget.item!.typename == "ConfigurableProduct"
                        ? Row(
                            children: [
                              widget.item!.configurableOptions![0].label ==
                                      "Color"
                                  ? widget.item!.configurableOptions![0].values
                                              .length >
                                          2
                                      ? SizedBox(
                                          height: 50,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: widget
                                                        .item!
                                                        .configurableOptions![0]
                                                        .values
                                                        .length >
                                                    2
                                                ? 2
                                                : widget
                                                    .item!
                                                    .configurableOptions![0]
                                                    .values
                                                    .length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  log(widget
                                                      .item!
                                                      .configurableOptions![0]
                                                      .values[index]
                                                      .toJson()
                                                      .toString());
                                                  _changeColor(
                                                      index,
                                                      widget
                                                          .item!
                                                          .configurableOptions![
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
                                                        .configurableOptions![0]
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
                                                .configurableOptions![0]
                                                .values
                                                .length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  log(widget
                                                      .item!
                                                      .configurableOptions![0]
                                                      .values[index]
                                                      .toJson()
                                                      .toString());
                                                  _changeColor(
                                                      index,
                                                      widget
                                                          .item!
                                                          .configurableOptions![
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
                                                        .configurableOptions![0]
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
                              widget.item!.configurableOptions![0].label ==
                                      "Color"
                                  ? widget.item!.configurableOptions![0].values
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
                    const SizedBox(height: 5.0,),
                    GestureDetector(
                      onTap: () async {
                        EasyLoading.show(status: 'loading...');
                       await graphQLService.addProductToCart(
                            widget.item!.sku.toString(), '1',
                            context: context);
                       widget.openDrawer.call();
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Text(
                          "Add to cart",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: blackColor,
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
                      color: widget.item!.wishlist ? Colors.red : Colors.black54,
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
