import 'package:flutter/material.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/MainLayout.dart';
import 'package:omaliving/components/size_config.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/screens/product_listing/Product_Listing.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/homescreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static void moveToProduct(BuildContext? selectedContext) {
    homeKey.currentState!.pushNamed(ProductListing.routeName);
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Theme(
      data: ThemeData(
          colorScheme:
              Theme.of(context).colorScheme.copyWith(primary: themecolor)),
      child: Navigator(
          // key: homeKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const HomeScreenBody();
                break;
              case ProductListing.routeName:
                builder = (BuildContext _) {
                  final id = (settings.arguments as Map)['id'];
                  return ProductListing(data: id);
                };
                break;
              default:
                builder = (BuildContext _) => const HomeScreenBody();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          }),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  GraphQLService graphQLService = GraphQLService();
  List<dynamic> navHeaderList = [];
  @override
  void initState() {
    super.initState();
    getNavdata();
  }

  void getNavdata() async {
    navHeaderList = await graphQLService.getCategory(limit: 1000);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, _) {
        return const Body();
      },
    );
  }
}
