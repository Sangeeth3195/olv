import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/API%20Services/Constant.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';
import '../Product_listing_PLP/Product_Listing_PLP.dart';

class Product_Listing_Brand extends StatefulWidget {
  final Map<String, dynamic> data;

  const Product_Listing_Brand({Key? key, required this.data}) : super(key: key);
  static const String routeName = "/home_screen";

  @override
  State<Product_Listing_Brand> createState() => _HomeScreenState(this.data);
}

class _HomeScreenState extends State<Product_Listing_Brand> {
  final Map<String, dynamic> data;
  _HomeScreenState(this.data);
  GraphQLService graphQLService = GraphQLService();
  final GlobalKey<ScaffoldState> _childDrawerKey = GlobalKey();
  CarouselController buttonCarouselController = CarouselController();

  int _current = 0;
  bool isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (data['bannerdata'].length == 0) {
      setState(() {
        isVisible = false;
      });
    } else {
      isVisible = true;
    }

    print(isVisible);

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: isVisible,
                    child: CarouselSlider(
                      items: [
                        for (Map<String, dynamic> item in data['bannerdata'])
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
                        autoPlay: data['bannerdata'].length == 1 ? false : true,
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
                  data['bannerdata'].length == 1 ||
                          data['bannerdata'].length == 0
                      ? Container()
                      : DotsIndicator(
                          dotsCount: data['bannerdata'].length,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data['name'].toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                            color: navTextColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.extent(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(2),
                    childAspectRatio: 0.70,
                    maxCrossAxisExtent: 300,
                    cacheExtent: 10,
                    children: List.generate(
                      data['collectiondata'].length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(3),
                        child: ProductCard(
                          title: data['collectiondata'][index]['name'],
                          id: data['option_id'],
                          brand_id: data['collectiondata'][index]['option_id'],
                          image:
                              '${Urls.BASE_URL_Prod}${data['collectiondata'][index]['image']}',
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
    required this.id,
    required this.brand_id,
    required this.title,
  }) : super(key: key);
  final String image, title;
  final int id, brand_id;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  GraphQLService graphQLService = GraphQLService();
  int wishlist = 0;
  String cart_token = '';
  MyProvider? myProvider;
  String? wishListID;
  String? image, title;
  String? brand_banner;
  String? price;
  Color? bgColor;
  String spl_price = "0";
  bool isExpired = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Product_Listing_PLP(
                  name: widget.title, id: widget.id, id1: widget.brand_id),
            ));
      },
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
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(defaultBorderRadius)),
                  ),
                  child: Image.network(
                    widget.image ?? '',
                    height: 180,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/omalogo.png',
                        height: 150,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text(
                        widget.title ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: textColor,
                            fontFamily: 'Gotham',
                            height: 1.5,
                            fontSize: 14),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
