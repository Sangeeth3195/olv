import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

class Product_Listing_PLP extends StatefulWidget {
  const Product_Listing_PLP({
    Key? key,
    required this.name,
    required this.id,
    required this.id1,
  }) : super(key: key);
  final String name;
  final int id;
  final int id1;
  static const String routeName = "/home_screen";

  @override
  State<Product_Listing_PLP> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Product_Listing_PLP> {
  String? name;
  int? id;
  int? id1;
  GraphQLService graphQLService = GraphQLService();
  List<dynamic> pList = [];
  var selectedColor = 0;
  MyProvider? myProvider;

  final GlobalKey<ScaffoldState> _childDrawerKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myProvider = Provider.of<MyProvider>(context, listen: false);
    getNavdata();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void getNavdata() async {



    final myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider.updatebrandData(widget.id, widget.id1, limit: 2);
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                          color: navTextColor),
                    ),
                  ),
                  GridView.extent(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(2),
                    childAspectRatio: 0.60,
                    maxCrossAxisExtent: 300,
                    cacheExtent: 10,
                    children: List.generate(
                      provider.items.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(3),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                                Radius.circular(defaultBorderRadius)),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                              Padding(
                              padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
                              child: GestureDetector(
                                onTap: () {

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                            product: provider.items[index].sku),
                                      ));
                                },
                                child:
                                Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: demo_product[0].colors[0],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(defaultBorderRadius)),
                                    ),
                                    child: Image.network(
                                      provider.items[index].smallImage.url ??
                                          '',
                                      height: 150,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                          'assets/omalogo.png',
                                          height: 150,
                                        );
                                      },
                                    ),
                                  ),
                              ),
                              ),
                                  const SizedBox(height: 2),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5.0, 0, 0, 0),
                                        child: Text(
                                          provider
                                              .items[index]
                                              .dynamicAttributes[0]
                                              .attributeValue
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
                                        padding: const EdgeInsets.fromLTRB(
                                            5.0, 0, 0, 0),
                                        child: Text(
                                          provider.items[index].name ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: blackColor,
                                              height: 1.5,
                                              fontSize: 12),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5.0, 0, 0, 0),
                                        child: Text(
                                          provider
                                                  .items[index]
                                                  .textAttributes[0]
                                                  .normalprice ??
                                              '',
                                          style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5.0, 0, 0, 0),
                                        child: Text(provider
                                                .items[index]
                                                .textAttributes[0]
                                                .specicalprice ??
                                            ''),
                                      ),
                                      const SizedBox(height: 5.0),

                                      /* widget.item!.textAttributes[0].specicalprice.toString() ==
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

0                                          : Container(),*/

                                      /*widget.item!.typename == "ConfigurableProduct"
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
                                          : Container(),*/

                                      GestureDetector(
                                        onTap: () async {
                                          print('object');

                                          EasyLoading.show(status: 'loading...');
                                          graphQLService.addProductToCart(
                                              provider
                                                  .items[index].sku.toString(), '1',
                                              context: context);
                                        },
                                        child: const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5.0, 0, 0, 0),
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
                                        if (!provider.items[index].wishlist) {
                                          provider.items[index].wishlist = true;
                                          dynamic listData =
                                          await graphQLService.add_Product_from_wishlist(
                                              wishlistId: myProvider!
                                                  .customerModel.customer!.wishlists![0].id!,
                                              sku: provider.items[index].sku.toString(),
                                              qty: "1",
                                              context: context);
                                        } else {
                                          provider.items[index].wishlist = false;
                                          dynamic listData =
                                          await graphQLService.remove_Product_from_wishlist(
                                              wishlistId: myProvider!
                                                  .customerModel.customer!.wishlists![0].id!,
                                              wishlistItemsIds: provider.items[index].id.toString(),
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
                                        provider.items[index].wishlist
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: provider.items[index].wishlist ? Colors.red : blackColor,
                                        size: 22,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),

                        /* ProductCardPLP(
                          title: provider.items[index].name,
                          image: provider.items[index].smallImage.url,
                          product: provider.items[index],
                          bgColor: demo_product[0].colors[0],
                          press: () {



                            */ /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                      product: provider.pList[index]['sku']),
                                ));*/ /*
                          },
                        ),*/
                      ),
                    ),
                  ),
                ],
              ),
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

    // Parse the hexadecimal values and construct the Color object.
    return Color(int.parse('FF$hexColor', radix: 16));
  }
}
