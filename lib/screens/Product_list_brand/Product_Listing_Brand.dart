import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';
import '../Product_listing_PLP/Product_Listing_PLP.dart';
import 'components/product_card_custom.dart';

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
                        child: Column(
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
                                        builder: (context) =>
                                            Product_Listing_PLP(
                                                name: data['collectiondata'][index]['name'],
                                                id: data['option_id'],
                                                id1: data['collectiondata']
                                                    [index]['option_id']),
                                      ));
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: demo_product[0].colors[0],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(defaultBorderRadius)),
                                  ),
                                  child: Image.network(
                                    "https://omaliving.com/media/wysiwyg/collection/${data['collectiondata'][index]['image']}" ??
                                        '',
                                    height: 180,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Image.asset(
                                        'assets/omalogo.png',
                                        height: 180,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                                  child: Center(
                                    child: Text(
                                      data['collectiondata'][index]['name'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: 'Gotham',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          color: navTextColor),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
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
