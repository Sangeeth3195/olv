import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:omaliving/constants.dart';

import 'components/size_config.dart';

class DetailsPage extends StatefulWidget {
  /* final String url;
  final String title;
  final int index;*/

  //required this.url, required this.title, required this.index

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {

  int quantity = 0;

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
      appBar: AppBar(
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
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                color: Colors.white,
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: CarouselSlider(
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
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 5),
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
                      color: _current == index ? Colors.black : Colors.grey,
                    ),
                  );
                }),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Chanel',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Scheffera potted plant',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: '₹ 2,595',
                                    style: TextStyle(
                                        color: headingColor, fontSize: 14)),
                                TextSpan(
                                    text: '    ',
                                    style: TextStyle(color: headingColor)),
                                TextSpan(
                                  text: 'Clearance ₹ 1,298',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: headingColor,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Card(
                                color: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: SizedBox(
                                  height: 32,
                                  width: 110,
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    child: showWidget(quantity),
                                  ),
                                ),
                              ),
                              // InkWell(child: Icon(Icons.remove)),
                              // Text('1'),
                              // InkWell(child: Icon(Icons.add)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
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
                child: const Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
                    'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown'
                    ' printer took a galley of type and scrambled it to make a type specimen book. '
                    'It has survived not only five centuries,but also the leap into electronic typesetting,'
                    ' remaining essentially unchanged. It was popularised in the 1960s with the release of'
                    'Letraset sheets containing Lorem Ipsum passages, '
                    'and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                    style: TextStyle(
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
                child: _buildDetailsAndMaterialWidgets(),
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
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AspectRatio(
                                  aspectRatio: 16.0 / 9.0,
                                  child: Image.network(url, fit: BoxFit.cover)),
                              const SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    4.0, 0.0, 4.0, 2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          margin:
                                              const EdgeInsets.only(right: 4.0),
                                          child: const Column(
                                            children: <Widget>[
                                              Text(
                                                '₹ 2,595',
                                                style: TextStyle(
                                                  color: headingColor,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 4.0),
                                          child: const Column(
                                            children: <Widget>[
                                              Text(
                                                'Clearance ₹1,298',
                                                style: TextStyle(
                                                  color: headingColor,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.bold,
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
      ),
    );
  }

  _buildDetailsAndMaterialWidgets() {
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
          height: 40.0,
          child: TabBarView(
            controller: tabController,
            children: const <Widget>[
              Text(
                "76% acrylic, 19% polyster, 5% metallic yarn Hand-wash cold",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                "86% acrylic, 9% polyster, 1% metallic yarn Hand-wash cold",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                "86% acrylic, 9% polyster, 1% metallic yarn Hand-wash cold",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
