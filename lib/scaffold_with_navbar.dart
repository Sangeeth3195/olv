import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/LoginPage.dart';
import 'package:omaliving/screens/cart/CartProvider.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API Services/graphql_service.dart';
import 'constants.dart';

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
  late DateTime currentBackPressTime;

  int catId = 10071;
  String token = '';
  BuildContext? selectedContext;
  MyProvider? myProvider;
  int _selectedIndex = 0;
  int selectedPageIndex = 0;
  late TabController _tabController;
  String cart_token = '';
  var test;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavdata();
    getuserdata();
    _tabController = TabController(vsync: this, length: 5);

    myProvider = Provider.of<MyProvider>(context, listen: false);
  }

  void getNavdata() async {
    navHeaderList = await graphQLService.getCategory(limit: 100);
    setState(() {});

    print(navHeaderList.length);
  }

  Future<String> getuserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    setState(() {});

    return token;
  }

  Widget _leadButton(BuildContext context) {
    return
      GestureDetector(
      onTap: () {
        context.pop();
      },

      child:  Icon(Icons.arrow_back),
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
                fontSize: 10,
              ),
              textAlign: TextAlign.center),
        ],
      ),
    );
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
      appBar: AppBar(
        leading: _showLeading(context) ? _leadButton(context) : null,
        elevation: 0,
        iconTheme: const IconThemeData(color: chipColor),
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Image.asset('assets/omalogo.png', height: 30, width: 100),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: blackColor,
              size: 22,
            ),
            onPressed: () {
              /*getNavdata();*/
            },
          ),
          const SizedBox(
            width: 0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () async {

                // print('object');
                // print(cart_token);

                // test = await graphQLService.assign_Customer_To_Guest_Cart("Xc357qa7yfvOEhyw8S1P7QkYyAQ3CIdP");

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const CircleAvatar(
                backgroundColor: Colors.black,
                radius: 12,
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/photo.jpg'),
                ),
              ),
            ),
          ),

          /*IconButton(
            icon: const FaIcon(
              Icons.shopping_bag_sharp,
              size: 28,
              color: headingColor,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed("/loginpage");
            },
          ),*/
        ],
      ),
      body: widget.navigationShell,
      drawer: Drawer(
        backgroundColor: navBackground,
        width:
            MediaQuery.of(context).size.width, // 75% of screen will be occupied
        child: ListView(
          children: [
            AppBar(
              automaticallyImplyLeading:
                  false, // this will hide Drawer hamburger icon

              backgroundColor: navBackground,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 22,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the navigation drawer
                },
              ),
              title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child:
                      Image.asset('assets/omalogo.png', height: 30, width: 100),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: blackColor,
                    size: 22,
                  ),
                  onPressed: () {
                    getNavdata();
                    Navigator.of(context).pop();
                    // Navigator.pushNamed(context, Settings.routeName);
                  },
                ),
                // const SizedBox(
                //   width: 12,
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 12,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/photo.jpg'),
                      ),
                    ),
                  ),
                ),

                /*IconButton(
                  icon: const FaIcon(
                    Icons.shopping_bag_sharp,
                    size: 28,
                    color: headingColor,
                  ),
                  onPressed: () {},
                ),*/
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return  Divider(
                  color: navHeaderList[index]['include_in_menu'] !=1?Colors.transparent:textColor,
                  thickness: 0.3,
                );
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
                              print('item_id --> $catId');
                              final myProvider = Provider.of<MyProvider>(
                                  context,
                                  listen: false);
                              myProvider.updateData(catId);
                              myProvider
                                  .updateHeader(navHeaderList[index]['name']);
                              myProvider.isproduct = true;
                              myProvider.notifyListeners();
                              context.go('/home/pdp');
                            },
                            child: Text(
                              navHeaderList[index]['name'],
                              style: const TextStyle(
                                  color: navTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: navHeaderList[index]['children']
                                    .length, // Replace with the actual number of items
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
                                        Navigator.of(context).pop();
                                        print('item_id --> $catId');
                                        catId = navHeaderList[index]['children']
                                            [itemIndex]['id'];
                                        final myProvider =
                                            Provider.of<MyProvider>(context,
                                                listen: false);
                                        myProvider.updateData(catId);
                                        myProvider.updateHeader(
                                            navHeaderList[index]['children']
                                                [itemIndex]['name']);
                                        myProvider.isproduct = true;
                                        myProvider.notifyListeners();
                                        context.go('/home/pdp');

                                        // Navigator.of(context, rootNavigator: true).pushNamed("/productlisting", arguments: catId);
                                      },
                                      child: Text(
                                        navHeaderList[index]['children']
                                            [itemIndex]['name'],
                                        style: const TextStyle(
                                            color: navTextColor,
                                            fontSize: 13,
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
                                            .length, // Replace with the actual number of items
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
                                                Navigator.of(context).pop();

                                                print('item_id --> $catId');
                                                catId = navHeaderList[index]
                                                            ['children']
                                                        [itemIndex]['children']
                                                    [subitemIndex]['id'];
                                                final myProvider =
                                                    Provider.of<MyProvider>(
                                                        context,
                                                        listen: false);
                                                myProvider.updateData(catId);
                                                myProvider.updateHeader(
                                                    navHeaderList[index][
                                                                        'children']
                                                                    [itemIndex]
                                                                ['children'][
                                                            subitemIndex]['name']
                                                        .toString());
                                                myProvider.isproduct = true;
                                                myProvider.notifyListeners();
                                                context.go('/home/pdp');

                                              },
                                              title: Text(
                                                navHeaderList[index]['children']
                                                                [itemIndex]
                                                            ['children']
                                                        [subitemIndex]['name']
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: navTextColor,
                                                    fontSize: 15,
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
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            color: Colors.white,
            child: TabBar(
                onTap: (x) {
                  _onTap(x);
                  setState(() {
                    _selectedIndex = x;
                  });
                },
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide.none,
                ),
                tabs: [
                  for (int i = 0; i < _icons.length; i++)
                    _tabItem(
                      _icons[i],
                      _labels[i],
                      isSelected: i == _selectedIndex,
                    ),
                ],
                controller: _tabController),
          ),
        ),
      ),
    );
  }

  void _onTap(index) async {

    if(index==3){
     CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);

     cartProvider.getCartData();

    }

    if(index==2){

      if (token.isNotEmpty) {

        CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);

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
