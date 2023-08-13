import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/screens/details/components/product_description.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import 'API Services/graphql_service.dart';
import 'components/size_config.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.product}) : super(key: key);

  final Map<String, dynamic> product;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  GraphQLService graphQLService = GraphQLService();

  int quantity = 0;
  int selectedImage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavdata();

    print('getPriceRange --> ${widget.product}');
  }

  void getNavdata() async {
    if (kDebugMode) {
      print('sku ->${widget.product['sku']}');
    }

    final myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider.updateProductDescriptionData(widget.product['sku'].toString());
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

  Widget showWidget(int qty) {
    if (qty == 0) {
      return TextButton(
        child: const Text(
          'Add Item',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        onPressed: () {
          setState(() {
            quantity++;
          });
        },
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.remove,
              color: blackColor,
            ),
            onPressed: () {
              setState(() {
                quantity--;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8, 0, 0),
            child: Text(quantity.toString()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.black54,
              ),
              onPressed: () {
                setState(() {
                  quantity++;
                });
              },
            ),
          ),
        ],
      );
    }
  }

  List imgList = [
    'https://www.omaliving.com/media/catalog/product/cache/0141941aeb4901c5334e6ba10ea3844d/I/T/ITEM-008721_3.png',
    'https://www.omaliving.com/media/catalog/product/cache/0141941aeb4901c5334e6ba10ea3844d/I/T/ITEM-008721_1_1.png',
    'https://www.omaliving.com/media/catalog/product/cache/0141941aeb4901c5334e6ba10ea3844d/I/T/ITEM-008721_2_1.png',
  ];

  final List<String> imageList = [
    "https://www.omaliving.com/media/wysiwyg/image_18_.png",
    "https://www.omaliving.com/media/wysiwyg/image_24_.png",
    "https://www.omaliving.com/media/wysiwyg/image_22_.png",
    "https://www.omaliving.com/media/wysiwyg/image_21_.png",
    "https://www.omaliving.com/media/wysiwyg/image_23_.png",
    "https://www.omaliving.com/media/wysiwyg/image_19_.png"
  ];

  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        /*    appBar: AppBar(
          title: const Center(
            child: Text(
              'Details',
              style: TextStyle(fontSize: 24, color: headingColor),
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),*/
        body: Consumer<MyProvider>(
          builder: (context, provider, _) {
            if (provider.productData != null) {
              return SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Card(
                          color: Colors.white,
                          elevation: 5,
                          margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 2.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(padding: EdgeInsets.fromLTRB(0.0,10,20,0),
                                     child: Icon(Icons.favorite_border,size: 25.0,)),
                                  ],
                                ),
                                CarouselSlider(
                                  options: CarouselOptions(
                                      initialPage: 0,
                                      reverse: false,
                                      autoPlay: true,
                                      enableInfiniteScroll: true,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index, fn) {
                                        setState(() {
                                          _current = index;
                                        });
                                      }),
                                  items: imgList.map((imgUrl) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Image.network(
                                            provider.productData[0]['media_gallery'][selectedImage]['url'],
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: map<Widget>(imgList, (index, url) {
                                    return Container(
                                      width: 18.0,
                                      height: 8.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // borderRadius: BorderRadius.circular(10.0),
                                        color: _current == index
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(height: 15),
                              ])),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 20, right: 10, left: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.productData[0]['dynamicAttributes'][0]['attribute_value'].toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    provider.productData[0]['name'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Limited time offer',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: '₹' +
                                                "${provider.productData[0]['price_range']['minimum_price']['regular_price']['value']}",
                                            style: const TextStyle(
                                                color: headingColor,
                                                fontSize: 14)),
                                        const TextSpan(
                                            text: '    ',
                                            style:
                                                TextStyle(color: headingColor)),
                                        /*const TextSpan(
                                          text: 'Clearance ₹ 1,298',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: headingColor,
                                              fontSize: 14),
                                        ),*/
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Card(
                                        color: Colors.grey[300],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        child: SizedBox(
                                          height: 35,
                                          width: 110,
                                          child: AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            child: showWidget(quantity),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      provider.productData[0]['__typename'] ==
                              "ConfigurableProduct"
                          ? Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(10)),
                                  child: const Text('COLOR',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: headingColor)),
                                ),
                                const SizedBox(
                                  width: 5,
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
                                                      ['configurable_options']
                                                      [0]['values']
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    // _changeColor(index);
                                                    print('color code --> ' +
                                                        provider.productData[0][
                                                                    'configurable_options'][0]
                                                                [
                                                                'values'][index]
                                                            [
                                                            'swatch_data']['value']);
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: colorFromHex(provider
                                                                      .productData[0]
                                                                  [
                                                                  'configurable_options']
                                                              [
                                                              0]['values'][index]
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

                      /*provider.productData[0]['configurable_options'][0]
                                  ['values'][0]['attribute_code'] ==
                              "size"
                          ? Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(10)),
                                  child: const Text('SIZE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: headingColor)),
                                ),
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
                                                      ['configurable_options']
                                                      [0]['values']
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                    onTap: () {
                                                      // _changeColor(index);
                                                    },
                                                    child: Chip(
                                                      backgroundColor:
                                                          chipColor,
                                                      label: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    16.0),
                                                        child: Text(
                                                          "${provider.productData[0]['configurable_options'][0]['values'][index]['swatch_data']['value']}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        side: const BorderSide(
                                                          color: omaColor,
                                                        ),
                                                      ),
                                                    ));
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            )
                          : Container(),*/

                    /*  provider.productData[0]['__typename'] ==
                              "ConfigurableProduct"
                          ? Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(10)),
                                  child: const Text('SIZE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: headingColor)),
                                ),
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
                                                      ['configurable_options']
                                                      [0]['values']
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                    onTap: () {
                                                      // _changeColor(index);
                                                    },
                                                    child: Chip(
                                                      backgroundColor:
                                                          chipColor,
                                                      label: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    16.0),
                                                        child: Text(
                                                          "${provider.productData[0]['configurable_options'][0]['values'][index]['swatch_data']['value']}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        // Adjust the border radius for rectangle shape
                                                        side: const BorderSide(
                                                          color: omaColor,
                                                        ),
                                                      ),
                                                    ));
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            )
                          : Container(),*/

                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: Text('Overview',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: blackColor)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(10),
                          right: getProportionateScreenWidth(10),
                        ),
                        child: Text(
                            provider.productData[0]['short_description']
                                ['html'],
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: blackColor,
                                height: 1.3,
                                fontSize: 14)),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(10)),
                        child: _buildDetailsAndMaterialWidgets(
                            provider.productData),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(10)),
                        child: const Text('You May also like',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: blackColor)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GFItemsCarousel(
                        rowCount: 2,
                        children: imageList.map(
                          (url) {
                            return InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 500,
                                child: Card(
                                  elevation: 1.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      AspectRatio(
                                          aspectRatio: 16.0 / 9.0,
                                          child: Image.network(url,
                                              fit: BoxFit.cover)),
                                      const SizedBox(height: 10.0),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            4.0, 0.0, 4.0, 2.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Scheffera potted plant ',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: blackColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            const Text(
                                              'Limited time offer',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13.0,
                                              ),
                                            ),
                                            const SizedBox(height: 15.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 4.0),
                                                  child: const Column(
                                                    children: <Widget>[
                                                      Text(
                                                        '₹ 2,595',
                                                        style: TextStyle(
                                                          color: headingColor,
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 4.0),
                                                  child: const Column(
                                                    children: <Widget>[
                                                      Text(
                                                        'Clearance ₹1,298',
                                                        style: TextStyle(
                                                          color: headingColor,
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),

                ),
              );
            } else {
              return Container();
            }
          },
        ));
  }

  _buildDetailsAndMaterialWidgets(productData) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TabBar(
          controller: tabController,
          tabs: const <Widget>[
            Tab(
              child: Text(
                "Details",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            Tab(
              child: Text(
                "Dimensions",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            Tab(
              child: Text(
                "Care & Maintenance",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5),
          )),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          height: 100.0,
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
              HtmlWidget(
                productData[0]['detail'].toString(),
              ),
              productData[0]['depth'] == null
                  ? Container()
                  : Text('Depth: ' + productData[0]['depth'].toString()),
              // HtmlWidget(
              //   productData[0]['care'],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
