import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omaliving/models/ProductListJson.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../API Services/graphql_service.dart';
import '../../../constants.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.press,
    required this.bgColor,
    this.product,
    this.item,
  }) : super(key: key);
  final String image, title;
  final VoidCallback press;
  final String price;
  final Color bgColor;
  final dynamic product;
  final Item? item;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  GraphQLService graphQLService = GraphQLService();

  String cart_token = '';

  // create_cart

  int _selected = 0;
  MyProvider? myProvider;
   String? wishListID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myProvider = Provider.of<MyProvider>(context, listen: false);
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
        child:
            /*Card(
          elevation: 0,
          child:*/
            Stack(
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
                    widget.item!.smallImage.url,
                    height: 150,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset('assets/omalogo.png',height: 150,);
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
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 0.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                            height: 1.5,
                            fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: widget.item!.getPriceRange.isEmpty
                          ? Text(widget.item!.textAttributes[0].normalprice
                              .toString())
                          : Text(widget.item!.getPriceRange[0].normalpricevalue
                              .toString()),
                    ),

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
                              widget.item!.configurableOptions[0].values
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
                                              _changeColor(index);
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: _selected == index
                                                        ? Colors.red
                                                        : Colors.transparent,
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
                                              _changeColor(index);
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: _selected == index
                                                        ? Colors.brown
                                                        : Colors.transparent,
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
                                    ),
                              widget.item!.configurableOptions[0].values
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
                                  : Container(),
                            ],
                          )
                        : Container(),
                    GestureDetector(
                      onTap: () async {

                        graphQLService.addProductToCart(
                          widget.item!.sku.toString(),
                          '1',
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: headingColor,
                              height: 1.5,
                              fontSize: 13),
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
                  onTap: () async{

                    if(myProvider!.customerModel?.customer?.email != null){
                      if(widget.item!.wishlist ==0){
                        widget.item!.wishlist =1;
                        dynamic listData = await graphQLService
                            .add_Product_from_wishlist(
                          wishlistId: myProvider!.customerModel.customer!.wishlists![0].id!,
                          sku: widget.item!.sku.toString(),
                          qty:"1",
                        );
                      }else{
                        widget.item!.wishlist =0;
                        dynamic listData = await graphQLService
                            .remove_Product_from_wishlist(
                            wishlistId: myProvider!.customerModel.customer!.wishlists![0].id!,
                            wishlistItemsIds: widget.item!.id.toString());

                      }
                      setState(() {

                      });

                    }else{
                      Fluttertoast.showToast(msg: 'Please Login for wishlist an item');
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 6),
                    child: Icon(
                      widget.item!.wishlist ==0?Icons.favorite_border:Icons.favorite,
                      color: blackColor,
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

  void _changeColor(int index) {
    setState(() {
      _selected = index;
    });
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
