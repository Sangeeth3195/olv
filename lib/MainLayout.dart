import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/screens/cart/cart_screen.dart';
import 'package:omaliving/screens/home/home_screen.dart';
import 'package:omaliving/screens/profile/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
class MainLayout extends StatelessWidget {

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: omaColor,
          leading: IconButton(
            onPressed: () {

              Navigator.pushNamed(context, CartScreen.routeName);

            },
            icon: SvgPicture.asset(
              "assets/icons/menu.svg",
              color: headingColor,
            ),
          ),
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
                size: 30,
                color: Colors.brown,
              ),
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.shoppingBag,
                color: Colors.brown,
              ),
              onPressed: () {},
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
          resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const Text('page2')
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: headingColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: headingColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
