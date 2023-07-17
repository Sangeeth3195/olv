import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/screens/product_listing/Product_Listing.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/homescreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
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
    return  Scaffold(
      body: Body(),

    );
  }
}
