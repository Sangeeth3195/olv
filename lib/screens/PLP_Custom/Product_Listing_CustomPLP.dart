import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../models/CategoryInfo.dart';
import '../../models/ProductListJson.dart';
import '../cart/CartProvider.dart';
import '../details/details_screen.dart';

class Product_Listing_CustomPLP extends StatefulWidget {
  final Map<String, dynamic> data;

  const Product_Listing_CustomPLP({Key? key, required this.data})
      : super(key: key);
  static const String routeName = "/home_screen";

  @override
  State<Product_Listing_CustomPLP> createState() => _HomeScreenState(this.data);
}

class _HomeScreenState extends State<Product_Listing_CustomPLP> {
  final Map<String, dynamic> data;
  _HomeScreenState(this.data);
  String? name;
  int? id;
  int? id1;
  GraphQLService graphQLService = GraphQLService();
  List<dynamic> pList = [];
  var selectedColor = 0;
  MyProvider? myProvider;
  CategoryInfo getcategoryInfo = CategoryInfo();
  String price = "0";
  bool isExpired = true;
  final GlobalKey<ScaffoldState> _childDrawerKey = GlobalKey();
  CarouselController buttonCarouselController = CarouselController();
  List<dynamic> getbrandslist = [];
  DateTime? dt1;
  bool isVisible = false;
  int _current = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.data['id'].toString());
    print(widget.data['name'].toString());
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
    myProvider.updatebrandlistData(widget.data['id'], limit: 2);
    getbrandslist = await graphQLService.getbrandsbanner(widget.data['name'].toString());

    print(getbrandslist[0]['bannerdata'].length);

    if (getbrandslist[0]['bannerdata'].length == 0) {
      setState(() {
        isVisible = false;
      });
    } else {
      isVisible = true;
    }
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
                     Visibility(
                    visible: isVisible,
                    child: CarouselSlider(
                      items: [
                        for (Map<String, dynamic> item in getbrandslist[0]['bannerdata'])
                          GestureDetector(
                            onTap: () {},
                            child: Image.network(
                              "https://staging2.omaliving.com/media/wysiwyg/brand/${item['banner']}",
                              fit: BoxFit.fitWidth,
                            ),
                          )
                      ],
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        autoPlay: getbrandslist[0]['bannerdata'].length == 1 ? false : true,
                        enlargeCenterPage: false,
                        viewportFraction: 1,
                        disableCenter: false,
                        aspectRatio: 1,
                        initialPage: 0,
                        height: 175,
                        autoPlayInterval: const Duration(seconds: 2),
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  getbrandslist[0]['bannerdata'].length == 1 ||
                      getbrandslist[0]['bannerdata'].length == 0
                      ? Container()
                      : DotsIndicator(
                    dotsCount: getbrandslist[0]['bannerdata'].length,
                    position: _current,
                    decorator: DotsDecorator(
                      size: const Size.square(9.0),
                      activeSize: const Size(9.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      widget.data['name'].toUpperCase(),
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
                    childAspectRatio: 0.55,
                    maxCrossAxisExtent: 300,
                    cacheExtent: 10,
                    children: List.generate(
                      provider.items.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(3),
                        child: ProductCard(
                          title: provider.items[index].name,
                          image: provider.items[index].smallImage.url,
                          fromdate: provider.items[index].specialFromDate,
                          todate: provider.items[index].specialToDate,
                          price:
                              provider.items[index].typename == "SimpleProduct"
                                  ? provider.items[index].price.regularPrice
                                      .amount.value
                                      .toString()
                                  : "${provider.items[index].getPriceRange}",
                          product: provider.items[index],
                          bgColor: demo_product[0].colors[0],
                          item: provider.items[index],
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                      product: provider.pList[index]['sku']),
                                ));
                          },
                        ),
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
}

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.fromdate,
    required this.todate,
    required this.price,
    required this.press,
    required this.bgColor,
    this.product,
    this.item,
  }) : super(key: key);
  final String image, title, fromdate, todate;
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

  int wishlist = 0;
  String cart_token = '';
  int _selected = 0;
  MyProvider? myProvider;
  String? wishListID;
  String? image, title;
  String price_ss = '0';
  String? Spl_price = '0';
  Color? bgColor;
  Item? item;
  CartProvider? cartProvider;
  String spl_price = "0";
  bool isExpired = false;
  String? _price_text;
  String? _price_value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myProvider = Provider.of<MyProvider>(context, listen: false);
    cartProvider = Provider.of<CartProvider>(context, listen: false);

    Spl_price = widget.item!.textAttributes[0].specicalprice.toString();

    calculatePrice();

    if (widget.item!.typename != "SimpleProduct") {
      try {
        _changeColor(
            0, widget.item!.configurableOptions![0].values[0].valueIndex);
      } catch (e) {
        print(e);
        title = widget.title;
        image = widget.item?.smallImage.url ?? '';
        // price_ss = widget.item!.getPriceRange.isEmpty
        //     ? widget.item!.textAttributes[0].normalprice
        //     : widget.item!.getPriceRange[0].normalpricevalue;
      }
    } else {
      title = widget.title;
      image = widget.item?.smallImage.url ?? '';
      // price_ss = widget.item!.getPriceRange.isEmpty
      //     ? widget.item!.textAttributes[0].normalprice
      //     : widget.item!.getPriceRange[0].normalpricevalue;
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

    if (widget.item!.textAttributes[0].specicalprice == '0') {
      isExpired = true;
    }
    if (widget.item?.specialToDate == '' || widget.item?.specialToDate == null) {
      isExpired = false;
    }
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
            image = variants.product.mediaGallery![0].url;
            // price_ss = variants.product.getPriceRange.isEmpty
            //     ? variants.product.textAttributes[0].normalprice
            //     : variants.product.getPriceRange[0].normalpricevalue;
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
                            color: Colors.black54,
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
                            fontWeight: FontWeight.w400,
                            color: blackColor,
                            fontFamily: 'Gotham',
                            height: 1.5,
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 5.0),

                    // isExpired? Padding(
                    //   padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                    //   child: widget.price.isEmpty
                    //       ? Text(
                    //     "₹${widget.price}",
                    //     style: const TextStyle(
                    //         fontSize: 13, color: Colors.black),
                    //   )
                    //       : Text(
                    //     "₹${widget.price}",
                    //     style: const TextStyle(
                    //         fontSize: 13, color: Colors.black),
                    //   ),
                    // ): Padding(
                    //   padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                    //   child: widget.price.isEmpty
                    //       ? Text(
                    //     "${widget.item!.textAttributes[0].normalprice}",
                    //     style: const TextStyle(
                    //         fontSize: 13, color: Colors.black),
                    //   )
                    //       : Text(
                    //     "${widget.item!.textAttributes[0].normalprice}",
                    //     style: const TextStyle(
                    //         fontSize: 13, color: Colors.black,decoration:TextDecoration.lineThrough ),
                    //   ),
                    // ),
                    // isExpired?Container():Padding(
                    //     padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                    //     child:
                    //     RichText(
                    //       text: TextSpan(
                    //         text: '$_price_text',
                    //         style: const TextStyle(
                    //           color: Color(0xFF983030),
                    //         ),
                    //         children: [
                    //           TextSpan(
                    //             text: '₹ $_price_value',
                    //             style: const TextStyle(
                    //                 fontWeight: FontWeight.w400,
                    //                 fontFamily: 'Gotham',
                    //                 color: Colors.black
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     )
                    //
                    //
                    //   // Text(
                    //   //     widget.item!.textAttributes[0].specicalprice!,
                    //   //     style: const TextStyle(
                    //   //         fontSize: 13, color: Colors.black)
                    //   // ),
                    //
                    //
                    // ),

                    widget.item!.typename == "ConfigurableProduct"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.item?.getPriceRange?[0].oldpricevalue == ""
                                  ? Container()
                                  : Text(widget
                                      .item!.getPriceRange![0].oldpricevalue
                                      .toString()),
                              widget.item?.getPriceRange?[0].normalpricevalue ==
                                      "null"
                                  ? Container()
                                  : Text(widget
                                      .item!.getPriceRange![0].normalpricevalue
                                      .toString()),
                            ],
                          )
                        : Container(),

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
                                    ? Text(widget
                                        .item!.textAttributes[0].specicalprice
                                        .toString())
                                    : Container(),
                              ],
                            ),
                          )
                        : Container(),

                    /*   Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text(
                        '${widget.item!.textAttributes[0].specicalprice}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: headingColor,
                            height: 1.2,
                            fontSize: 13),
                      ),
                    ),*/

                    const SizedBox(height: 5.0),
                    widget.item!.textAttributes[0].specicalprice.toString() == null
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

                    //widget.item!.typename == "ConfigurableProduct"
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
                                                            : Colors.transparent
                                                                .withOpacity(
                                                                    0.1),
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

                    const SizedBox(height: 5.0),

                    GestureDetector(
                      onTap: () async {
                        EasyLoading.show(status: 'loading...');
                        graphQLService.addProductToCart(
                            widget.item!.sku.toString(), '1',
                            context: context);
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Text(
                          "Add to cart",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
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
    try {
      if (hexColor.startsWith('#')) {
        hexColor = hexColor.substring(1);
      }
      if (hexColor.length != 6) {
        throw const FormatException(
            "Invalid hex color code. It should be 6 characters long (excluding the '#').");
      }
      return Color(int.parse('FF$hexColor', radix: 16));
    } catch (e) {
      return const Color(0xFFFFFFFF);
    }
  }
}
