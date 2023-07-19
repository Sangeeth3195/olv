import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/screens/cart/cart_screen.dart';
import 'package:omaliving/screens/homescreen/homescreen.dart';
import 'package:omaliving/screens/product_listing/Product_Listing.dart';
import 'package:omaliving/screens/product_listing/components/search_form.dart';
import 'package:omaliving/screens/profile/profile_screen.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:omaliving/screens/settings/settings.dart';
import 'package:omaliving/screens/wishlist/wishlist.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  GraphQLService graphQLService = GraphQLService();
  List<dynamic> navHeaderList = [];
  int catId = 10071;
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

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // Create a key
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: chipColor),
        backgroundColor: omaColor,
        title: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Image.asset('assets/omalogo.png', height: 50, width: 100),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              size: 28,
              color: headingColor,
            ),
            onPressed: () {
              getNavdata();
              Navigator.of(context, rootNavigator: true)
                  .pushNamed("/signinscreen");
            },
          ),
          IconButton(
            icon: const FaIcon(
              Icons.shopping_bag_sharp,
              size: 28,
              color: headingColor,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed("/signupscreen");
            },
          ),
        ],
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        hideNavigationBar: false,
        navBarStyle:
            NavBarStyle.style12, // Choose the nav bar style with this property.
      ),
      drawer: Drawer(
        backgroundColor: navBackground,
        width:
            MediaQuery.of(context).size.width, // 75% of screen will be occupied
        child: ListView(
          children: [
            AppBar(
              backgroundColor: navBackground,
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 28,
                  color: headingColor,
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the navigation drawer
                },
              ),
              title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child:
                      Image.asset('assets/omalogo.png', height: 50, width: 100),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.person,
                    size: 28,
                    color: headingColor,
                  ),
                  onPressed: () {
                    getNavdata();
                    // Navigator.pushNamed(context, Settings.routeName);
                  },
                ),
                IconButton(
                  icon: const FaIcon(
                    Icons.shopping_bag_sharp,
                    size: 28,
                    color: headingColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: textColor,
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
                  child: ExpansionTile(
                    trailing: navHeaderList[index]['children'].length == 0
                        ? Container(
                            width: 10,
                          )
                        : const Icon(Icons.keyboard_arrow_down),
                    title: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        catId = navHeaderList[index]['id'];
                        print('item_id --> $catId');
                        final myProvider =
                            Provider.of<MyProvider>(context, listen: false);
                        myProvider.updateData(catId);
                        _controller.jumpToTab(1);
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
                          itemBuilder: (BuildContext context, int itemIndex) {
                            return ExpansionTile(
                              trailing: navHeaderList[index]['children']
                                              [itemIndex]['children']
                                          .length ==
                                      0
                                  ? Container(
                                      width: 10,
                                    )
                                  : const Icon(Icons.keyboard_arrow_down),
                              initiallyExpanded: true,
                              title: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  print('item_id --> $catId');
                                  catId = navHeaderList[index]['children']
                                      [itemIndex]['id'];
                                  final myProvider = Provider.of<MyProvider>(
                                      context,
                                      listen: false);
                                  myProvider.updateData(catId);
                                  _controller.jumpToTab(1);
                                  // Navigator.of(context, rootNavigator: true).pushNamed("/productlisting", arguments: catId);
                                },
                                child: Text(
                                  navHeaderList[index]['children'][itemIndex]
                                      ['name'],
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
                                  itemCount: navHeaderList[index]['children']
                                          [itemIndex]['children']
                                      .length, // Replace with the actual number of items
                                  itemBuilder:
                                      (BuildContext context, int subitemIndex) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 0),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          catId = navHeaderList[index]
                                                  ['children'][itemIndex]
                                              ['children'][subitemIndex]['id'];
                                          final myProvider =
                                              Provider.of<MyProvider>(context,
                                                  listen: false);
                                          myProvider.updateData(catId);
                                          _controller.jumpToTab(1);

                                          // Navigator.of(context, rootNavigator: true).pushNamed("/productlisting", arguments: catId);
                                        },
                                        title: Text(
                                          navHeaderList[index]['children']
                                                      [itemIndex]['children']
                                                  [subitemIndex]['name']
                                              .toString(),
                                          style: const TextStyle(
                                              color: navTextColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal),
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      ProductListing(id: catId),
      const Wishlist(),
      const CartScreen(),
      const ProfileScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.house),
        iconSize: 22.0,
        title: ("Home"),
        activeColorPrimary: headingColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.search),
        iconSize: 22.0,
        title: ("Search"),
        activeColorPrimary: headingColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.heart),
        iconSize: 22.0,
        title: ("WishList"),
        activeColorPrimary: headingColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.cartPlus),
        iconSize: 22.0,
        title: ("Cart"),
        activeColorPrimary: headingColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.user),
        iconSize: 22.0,
        title: ("Profile"),
        activeColorPrimary: headingColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.red),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70'),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Mr.John',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'John300@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            const Divider(
              height: 1,
            ),
            const ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
