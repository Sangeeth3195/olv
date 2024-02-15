
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      data['name'].toUpperCase(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                          color: navTextColor),
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
                          image: 'https://omaliving.com/media/wysiwyg/collection/${data['collectiondata'][index]['image']}',
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
  final int id,brand_id;

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
        print(widget.title);
        print(widget.image);
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child:
            Stack(
            children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Product_Listing_PLP(
                                          name: widget.title,
                                          id: widget.id,
                                          id1: widget.brand_id),
                                ));
                          },
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(defaultBorderRadius)),
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
                ),
                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Center(
                        child: Text(
                          widget.title ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: textColor,
                              fontFamily: 'Gotham',
                              height: 1.5,
                              fontSize: 12),
                        ),
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
