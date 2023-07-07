import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/screens/cart/cart_screen.dart';
import 'package:omaliving/screens/homescreen/homescreen.dart';
import 'package:omaliving/screens/product_listing/Product_Listing.dart';
import 'package:omaliving/screens/product_listing/components/search_form.dart';
import 'package:omaliving/screens/profile/profile_screen.dart';
import 'package:omaliving/screens/settings/settings.dart';
import 'package:omaliving/screens/wishlist/wishlist.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainLayout extends StatelessWidget {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  MainLayout({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: omaColor,
          // leading: IconButton(
          //   onPressed: () {
          //     _key.currentState!.openDrawer();
          //   },
          //   icon: SvgPicture.asset(
          //     "assets/icons/menu.svg",
          //     color: headingColor,
          //   ),
          // ),
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
                Navigator.pushNamed(context, Settings.routeName);
              },
            ),
            IconButton(
              icon: const FaIcon(
                Icons.shopping_bag_sharp,
                size: 28,
                color: headingColor,
              ),
              onPressed: () {

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
          navBarStyle: NavBarStyle
              .style12, // Choose the nav bar style with this property.
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.9, // 75% of screen will be occupied
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
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
      const ProductListing(),
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
      width: MediaQuery.of(context).size.width*0.8,
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
                  children: <Widget>[
                    Container(
                      width: 70,
                      height: 70,
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage('https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70'),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Text(
                      'Mr.John',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2,),
                    const Text(
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
            const Divider(height: 1,),
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
