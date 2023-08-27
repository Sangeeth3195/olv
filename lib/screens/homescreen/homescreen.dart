import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/screens/product_listing/Product_Listing.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import '../address/address.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/homescreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static void moveToProduct(BuildContext? selectedContext) {
    Navigator.push(
      selectedContext!!,
      MaterialPageRoute(
          builder: (context) => const Address()),
    );

  }
}

class _HomeScreenState extends State<HomeScreen> {
  GraphQLService graphQLService = GraphQLService();
  List<dynamic> navHeaderList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavdata();
  }

  void getNavdata() async {
    navHeaderList = await graphQLService.getCategory(limit: 100);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, _) {
        if(provider.isproduct){
          return ProductListing(id: 100017);
        }
        return Body();
      },


    );
  }
}
