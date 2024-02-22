import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/LoginPage.dart';
import 'package:omaliving/screens/Product_listing_PLP/Product_Listing_PLP.dart';
import 'package:omaliving/screens/cart/CartProvider.dart';
import 'package:omaliving/screens/product_listing/components/search_form.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:omaliving/webview.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API Services/graphql_service.dart';
import 'constants.dart';
import 'screens/cart/cart_screen.dart';

class ScaffoldWithNavbar extends StatefulWidget {
  const ScaffoldWithNavbar(this.navigationShell, {super.key});

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNavbar> createState() => _ScaffoldWithNavbarState();
}

class _ScaffoldWithNavbarState extends State<ScaffoldWithNavbar>
    with SingleTickerProviderStateMixin {
  GraphQLService graphQLService = GraphQLService();
  List<dynamic> navHeaderList = [];
  List<dynamic> getbrandslist = [];
  late DateTime currentBackPressTime;

  bool isVisible = false;

  int catId = 0;
  String token = '';
  BuildContext? selectedContext;
  MyProvider? myProvider;
  int _selectedIndex = 0;
  int selectedPageIndex = 0;
  late TabController _tabController;
  String cart_token = '';
  var test;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final OverlayPortalController _tooltipController = OverlayPortalController();
  bool isSearch = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavdata();
    getuserdata();
    _tabController = TabController(vsync: this, length: 5);

    myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider!.getuserdata();
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    cartProvider.getCartData();

    print(isVisible);
  }

  void getNavdata() async {
    navHeaderList = await graphQLService.getCategory(limit: 100);
    getbrandslist = await graphQLService.getbrands();
    setState(() {});
  }

  Future<String> getuserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    setState(() {});
    return token;
  }

  Widget _leadButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: const Icon(
        Icons.arrow_back_ios,
        size: 20,
      ),
    );
  }

  bool _showLeading(BuildContext context) {
    if (widget.navigationShell.currentIndex == 0) {
      return GoRouter.of(context).location != '/home';
    } else if (widget.navigationShell.currentIndex == 1) {
      return GoRouter.of(context).location != '/discover';
    } else if (widget.navigationShell.currentIndex == 2) {
      return GoRouter.of(context).location != '/wishlist';
    } else if (widget.navigationShell.currentIndex == 3) {
      return GoRouter.of(context).location != '/cart';
    } else if (widget.navigationShell.currentIndex == 4) {
      return GoRouter.of(context).location != '/profile';
    }
    return GoRouter.of(context).location != '/home';
  }

  Widget _tabItem(Widget child, String label, {bool isSelected = false}) {
    return Consumer<MyProvider>(builder: (context, provider, _) {
      return Container(
        width: MediaQuery.of(context).size.width / 8,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        decoration: !isSelected
            ? null
            : const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(2), topLeft: Radius.circular(2)),
                color: themecolor,
              ),
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  child,
                  const SizedBox(
                    height: 5,
                  ),
                  Text(label,
                      style: const TextStyle(
                        fontSize: 9,
                      ),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            label == 'cart'
                ? Consumer<CartProvider>(builder: (context, cartProd, _) {
                    return cartProd.cartNumbers == 0
                        ? Container()
                        : Positioned(
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                cartProd.cartNumbers.toString(),
                                // You can replace this with the actual badge count
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                  })
                : label == 'WishList'
                    ? Positioned(
                        right: 0,
                        child: provider.wishListNumbers == 0
                            ? Container()
                            : Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  provider.wishListNumbers.toString(),
                                  // You can replace this with the actual badge count
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      )
                    : Container()
          ],
        ),
      );
    });
  }

  final List<String> _labels = [
    'Home',
    'Discover',
    'WishList',
    'cart',
    'Profile'
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> _icons = const [
      Icon(Icons.home),
      Icon(FontAwesomeIcons.compass),
      Icon(FontAwesomeIcons.heart),
      Icon(FontAwesomeIcons.cartPlus),
      Icon(FontAwesomeIcons.user),
    ];
    return Scaffold(
      key: _key,
      // Assign the key to Scaffold.
      endDrawer: Drawer(
        clipBehavior: Clip.none,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 0,
              child: DrawerHeader(
                child: Container(),

                /*ListTile(
                    contentPadding: EdgeInsets.zero,
                   */ /* leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),*/ /*
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      //  Icon(Icons.shopping_cart),
                        Text(
                          'My Cart',
                        )
                      ],
                    ),
                    onTap: () {},
                  )*/
              ),
            ),
            const Expanded(
                child: CartScreen(
              isFromActionBar: true,
            )),
            //const Expanded(child: CartContent())
          ],
        ),
      ),

      /*  Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Text('Top'),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, right: 10.0, bottom: 0.0, left: 10.0),
                    child: SizedBox(
                      height: 45.0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: headingColor,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  "VIEW CART",
                                  style: TextStyle(
                                    color: headingColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, right: 10.0, bottom: 0.0, left: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(45),
                  backgroundColor: themecolor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                ),
                onPressed: () async {},
                child: const Text(
                  'PROCEED TO CHECKOUT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),*/

      appBar: AppBar(
        leading: _showLeading(context) ? _leadButton(context) : null,
        /*Row(
          children: [

            SizedBox(width: 20,),
            IconButton(
              icon: const Icon(Icons.menu, size: 30,),
              onPressed: () => _key.currentState?.openDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
            IconButton(
              icon: const Icon(Icons.search, size: 30,),
              onPressed: () => _key.currentState?.openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ],
        )*/

        elevation: 0,
        iconTheme: const IconThemeData(color: chipColor),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            if (GoRouter.of(context).location != "/home") {
              context.go("/home");
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset('assets/omalogo.png', height: 25, width: 80),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // isSearch = !isSearch;
              // setState(() {
              //
              // });
              myProvider!.showHideSearch();
            },
            icon: const Icon(Icons.search),
          ),
          // Center(
          //   child: GestureDetector(
          //     child: const Padding(
          //       padding: EdgeInsets.only(right: 12.0),
          //       child: Icon(
          //         Icons.search,
          //         size: 25,
          //       ),
          //     ),
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => const TST()));
          //     },
          //   ),
          // ),
          Center(
            child: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/shopping_bag.png',
                    width: 28,
                    height: 22,
                  ),
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  await getuserdata();
                  if (token.isEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  } else {
                    setState(() {
                      _selectedIndex = 4;
                    });
                    _onTap(4);
                  }
                },
                child: Image.asset(
                  'assets/images/user.png',
                  width: 28,
                  height: 22,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 0,
          ),
        ],
      ),
      body: widget
          .navigationShell /*Column(
        children: [
          isSearch?SearchForm():Container(),
          SingleChildScrollView(child: Container(
              height: MediaQuery.of(context).size.height-(isSearch?144:0),
              child: widget.navigationShell)),
        ],
      )*/
      ,
      drawer: Drawer(
        backgroundColor: navBackground,
        width:
            MediaQuery.of(context).size.width, // 75% of screen will be occupied
        child: ListView(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: tileColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.black54,
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the navigation drawer
                },
              ),
              title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child:
                      Image.asset('assets/omalogo.png', height: 22, width: 80),
                ),
              ),
              actions: [
                Center(
                  child: GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Icon(
                        Icons.search,
                        size: 25,
                        color: headingColor,
                      ),
                    ),

                    onTap: () {},

                    // onTap: () => _key.currentState?.openEndDrawer(),
                    // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
                Center(
                  child: Builder(
                    builder: (context) => Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: GestureDetector(
                        child: Image.asset(
                          'assets/images/shopping_bag.png',
                          width: 28,
                          height: 22,
                        ),
                        onTap: () => Scaffold.of(context).openEndDrawer(),
                        // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        // print('object');
                        // print(cart_token);

                        // test = await graphQLService.assign_Customer_To_Guest_Cart("Xc357qa7yfvOEhyw8S1P7QkYyAQ3CIdP");

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const LoginPage()),
                        // );

                        await getuserdata();
                        if (token.isEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        } else {
                          setState(() {
                            _selectedIndex = 4;
                          });
                          _onTap(4);
                        }
                      },
                      child: Image.asset(
                        'assets/images/user.png',
                        width: 28,
                        height: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {

                return navHeaderList[index]['include_in_menu'] == 1 ? Divider(
                  color: navHeaderList[index]['include_in_menu'] != 1
                      ? Colors.transparent
                      : textColor,
                  thickness: 0.0,

                ): Container();
              },
              itemCount: navHeaderList.length,
              itemBuilder: (BuildContext context, int index) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor:
                        Colors.transparent, // Set divider color to transparent
                  ),
                  child: navHeaderList[index]['include_in_menu'] == 1
                      ? ExpansionTile(
                          trailing: navHeaderList[index]['children'].length == 0
                              ? Container(
                                  width: 10,
                                )
                              : null,
                          title: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              catId = navHeaderList[index]['id'];
                              print('item_id 1 --> $catId');
                              final myProvider = Provider.of<MyProvider>(
                                  context,
                                  listen: false);
                              myProvider
                                  .updateHeader(navHeaderList[index]['name']);
                              myProvider.isproduct = true;
                              myProvider.notifyListeners();
                              context.go('/home/pdp',
                                  extra: navHeaderList[index]);
                            },
                            child: Text(
                              navHeaderList[index]['name'].toUpperCase(),
                              style: const TextStyle(
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.0,
                                  color: navTextColor),
                            ),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount:
                                    navHeaderList[index]['children'].length,
                                // Replace with the actual number of items
                                itemBuilder:
                                    (BuildContext context, int itemIndex) {
                                  return ExpansionTile(
                                    trailing: navHeaderList[index]['children']
                                                    [itemIndex]['children']
                                                .length ==
                                            0
                                        ? Container(
                                            width: 10,
                                          )
                                        : null,
                                    // initiallyExpanded: true,
                                    title: GestureDetector(
                                      onTap: () {
                                       /* Navigator.of(context).pop();
                                        print('item_id 2 --> $catId');
                                        context.go('/home/catDetails',
                                            extra: navHeaderList[index]
                                                ['children'][itemIndex]);*/

                                        // catId = navHeaderList[index]['children']
                                        //     [itemIndex]['id'];
                                        // final myProvider =
                                        //     Provider.of<MyProvider>(context,
                                        //         listen: false);
                                        // // myProvider.updateData(catId);
                                        // myProvider.updateHeader(
                                        //     navHeaderList[index]['children']
                                        //         [itemIndex]['name']);
                                        // myProvider.isproduct = true;
                                        // myProvider.notifyListeners();
                                        // context.go('/home/pdp');

                                        // Navigator.of(context, rootNavigator: true).pushNamed("/productlisting", arguments: catId);
                                      },
                                      child: Text(
                                        navHeaderList[index]['children']
                                            [itemIndex]['name'],
                                        style: const TextStyle(
                                            color: navTextColor,
                                            fontSize: 12,
                                            letterSpacing: 2,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal),
                                      ),
                                    ),
                                    children: <Widget>[
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: navHeaderList[index]
                                                    ['children'][itemIndex]
                                                ['children']
                                            .length,
                                        // Replace with the actual number of items
                                        itemBuilder: (BuildContext context,
                                            int subitemIndex) {
                                          String tc = navHeaderList[index]
                                                          ['children']
                                                      [itemIndex]['children']
                                                  [subitemIndex]['name']
                                              .split(' ')
                                              .map((word) => word.toLowerCase())
                                              .join(' ');

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 0),
                                            child: ListTile(
                                              onTap: () {
                                                print('showcollection');

                                                print(navHeaderList[index]
                                                                    ['children']
                                                                [itemIndex]
                                                            ['children']
                                                        [subitemIndex]
                                                    ['show_collection']);

                                                if (navHeaderList[index][
                                                                        'children']
                                                                    [itemIndex]
                                                                ['children']
                                                            [subitemIndex]
                                                        ['show_collection'] ==
                                                    1) {
                                                  print('test_entry');

                                                  print(navHeaderList[index][
                                                                      'children']
                                                                  [itemIndex]
                                                              ['children']
                                                          [subitemIndex]
                                                      ['show_collection']);

                                                  print(navHeaderList[index]
                                                                  ['children']
                                                              [itemIndex]
                                                          ['children']
                                                      [subitemIndex]['name']);

                                                  Navigator.of(context).pop();
                                                  catId = navHeaderList[index]
                                                                  ['children']
                                                              [itemIndex]
                                                          ['children']
                                                      [subitemIndex]['id'];
                                                  final myProvider =
                                                      Provider.of<MyProvider>(
                                                          context,
                                                          listen: false);
                                                  // myProvider.updateData(catId);
                                                  myProvider.updateHeader(
                                                      navHeaderList[index][
                                                                          'children']
                                                                      [
                                                                      itemIndex]
                                                                  ['children'][
                                                              subitemIndex]['name']
                                                          .toString());
                                                  myProvider.isproduct = true;
                                                  myProvider.notifyListeners();

                                                  context.go(
                                                      '/home/cat_listing_filter',
                                                      extra:
                                                          navHeaderList[index]
                                                                  ['children']
                                                              [itemIndex]);
                                                } else {
                                                  print(navHeaderList[index]
                                                                  ['children']
                                                              [itemIndex]
                                                          ['children']
                                                      [subitemIndex]['name']);

                                                  print(navHeaderList[index]
                                                  ['children']
                                                  [itemIndex]
                                                  ['children']
                                                  [subitemIndex]['id']);

                                                  print('item_id 1 -->');
                                                  print(navHeaderList[index]
                                                  ['children']
                                                  [itemIndex]
                                                  ['children']
                                                  [subitemIndex]['name']);

                                                  print(navHeaderList[index]
                                                  ['children']
                                                  [itemIndex]
                                                  ['children']
                                                  [subitemIndex]['id']);


                                                  Navigator.of(context).pop();
                                                  catId = navHeaderList[index]
                                                                  ['children']
                                                              [itemIndex]
                                                          ['children']
                                                      [subitemIndex]['id'];
                                                  final myProvider =
                                                      Provider.of<MyProvider>(
                                                          context,
                                                          listen: false);
                                                  myProvider.updateHeader(
                                                      navHeaderList[index][
                                                                          'children']
                                                                      [
                                                                      itemIndex]
                                                                  ['children'][
                                                              subitemIndex]['name']
                                                          .toString());
                                                  myProvider.isproduct = true;
                                                  myProvider.notifyListeners();
                                                  context.go('/home/pdp',
                                                      extra:
                                                          navHeaderList[index]
                                                                  ['children']
                                                              [itemIndex]);
                                                }
                                              },
                                              title: Text(
                                                navHeaderList[index]['children']
                                                                [itemIndex]
                                                            ['children']
                                                        [subitemIndex]['name']
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: navTextColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        )

                      : Container(),
                );
              },
            ),

            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'BRANDS',
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                        color: navTextColor),
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: getbrandslist.length,
                      itemBuilder: (BuildContext context, int itemIndex) {
                        return ExpansionTile(
                          trailing: const SizedBox(),
                          title: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              if (getbrandslist[itemIndex]['collectiondata'] !=
                                  null) {
                                context.go('/home/product_listing_brand',
                                    extra: getbrandslist[itemIndex]);
                              } else {
                                final Map<String, dynamic> someMap = {
                                  "id": getbrandslist[itemIndex]['option_id'],
                                  "name": getbrandslist[itemIndex]['name'],
                                };
                                print(someMap);
                                context.go('/home/product_listing_brandlist',
                                    extra: someMap);
                              }
                            },
                            child: Text(
                              getbrandslist[itemIndex]['name'].toUpperCase(),
                              style: const TextStyle(
                                  color: navTextColor,
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              color: textColor,
              thickness: 0.4,
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(index) async {
    if (index == 3) {
      CartProvider cartProvider =
          Provider.of<CartProvider>(context, listen: false);

      cartProvider.getCartData();
    }

    if (index == 2) {
      if (token.isNotEmpty) {
        CartProvider cartProvider =
            Provider.of<CartProvider>(context, listen: false);

        cartProvider.getCartData();
      }
    }

    if (index == 2 || index == 4) {
      await getuserdata();
      MyProvider cartProvider = Provider.of<MyProvider>(context, listen: false);

      myProvider!.getuserdata();
      if (token.isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        widget.navigationShell.goBranch(
          index,
          // A common pattern when using bottom navigation bars is to support
          // navigating to the initial location when tapping the item that is
          // already active. This example demonstrates how to support this behavior,
          // using the initialLocation parameter of goBranch.
          initialLocation: index == widget.navigationShell.currentIndex,
        );
      }
    } else {
      widget.navigationShell.goBranch(
        index,
        // A common pattern when using bottom navigation bars is to support
        // navigating to the initial location when tapping the item that is
        // already active. This example demonstrates how to support this behavior,
        // using the initialLocation parameter of goBranch.
        initialLocation: index == widget.navigationShell.currentIndex,
      );
    }
  }
}

/*class CartContent extends StatelessWidget {
  const CartContent();

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<CartState>(
        initialData: bloc.state,
        stream: bloc.observableState,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state is LoadingCartState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ErrorCartState) {
            return Center(child:Text(state.message));
          } else {
            return _renderCartContent(context, state);
          }
        });
  }

  Widget _renderCartContent(BuildContext context, LoadedCartState state){
    totalPrice() => Column(children: <Widget>[
      const Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text(
            'Total Price',
          ),
          Text(state.totalPrice)
        ],
      )
    ]);

    cartItems() => ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: state.items.length + 1,
        itemBuilder: (context, index) {
          if (index < state.items.length) {
            final CartItemState cartItemState = state.items[index];

            return CartContentItem(cartItemState);
          } else {
            return totalPrice();
          }
        });

    emptyCartItems() => const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          ' Empty Cart :('
        ));

    final content =
    state.items.isNotEmpty ? cartItems() : emptyCartItems();

    return content;
  }
}*/

class CartContentItem extends StatelessWidget {
  final CartItemState _cartItemState;
  final TextEditingController _quantityController = TextEditingController();

  CartContentItem(this._cartItemState);

  @override
  Widget build(BuildContext context) {
    final imageWidget = Image.network(
      _cartItemState.image,
      height: 120.0,
    );

    final descriptionWidget = Column(children: <Widget>[
      Text(
        _cartItemState.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: _quantityController,
            decoration: const InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          )),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(_cartItemState.price))),
        ],
      )
    ]);

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 16.0, right: 8.0, bottom: 16.0),
                      child: imageWidget)),
              Expanded(flex: 3, child: descriptionWidget),
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {},
              )
            ],
          ),
        ));
  }
}

class CartItemState {
  final String id;
  final String image;
  final String title;
  final String price;
  final int quantity;

  CartItemState(this.id, this.image, this.title, this.price, this.quantity);
}
