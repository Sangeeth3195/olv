import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/LoginPage.dart';
import 'package:omaliving/screens/cart/cart_screen.dart';
import 'package:omaliving/screens/discover/discovers.dart';
import 'package:omaliving/screens/homescreen/homescreen.dart';
import 'package:omaliving/screens/otp/OTP.dart';
import 'package:omaliving/screens/product_listing/Product_Listing.dart';
import 'package:omaliving/screens/product_listing/components/search_form.dart';
import 'package:omaliving/screens/profile/profile_screen.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:omaliving/screens/recent_order/recentorder.dart';
import 'package:omaliving/screens/settings/settings.dart';
import 'package:omaliving/screens/wishlist/wishlist.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLayout extends StatefulWidget {
  MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  GraphQLService graphQLService = GraphQLService();
  List<dynamic> navHeaderList = [];
  late DateTime currentBackPressTime;

  int catId = 10071;
  String token = '';
  BuildContext? selectedContext;
  MyProvider? myProvider ;
  int _selectedIndex = 0;
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fivthTabNavKey = GlobalKey<NavigatorState>();

  CupertinoTabController? tabController;

  List<Widget> _widgetOptions = <Widget>[
NextScreen(),
    Text('Search Page'),
    Text('Profile Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavdata();
    getuserdata();
    tabController = CupertinoTabController(initialIndex: 0);

    myProvider = Provider.of<MyProvider>(
    context,
    listen: false);
  }

  void getNavdata() async {
    navHeaderList = await graphQLService.getCategory(limit: 100);
    setState(() {});
  }

  void getuserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    // if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    //   currentBackPressTime = now;
    //   Fluttertoast.showToast(msg: 'exit_warning');
    //   return Future.value(false);
    // }
    return Future.value(true);
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // Create a key
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFFFFF1E0), // navigation bar color
      statusBarColor: Color(0xFFFFF1E0), // status bar color
    ));

    final listOfKeys = [firstTabNavKey, secondTabNavKey, thirdTabNavKey,fourthTabNavKey,fivthTabNavKey];

    List homeScreenList = [
      //list of different screens for different tabs
    ];
    // return NavBarHandler();
    return Scaffold(
      appBar:           AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(color: chipColor),
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(
              Icons.location_on_outlined,
              size: 24,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          const Text(
            'Gurugram',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.favorite_border,
            color: blackColor,
            size: 26,
          ),
          onPressed: () {
            /*getNavdata();*/
            _controller.jumpToTab(2);
          },
        ),
        const SizedBox(
          width: 12,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: GestureDetector(
            onTap: () {
              token.isEmpty
                  ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPage()),
              )
                  : _controller.jumpToTab(4);
            },
            child: const CircleAvatar(
              backgroundColor: Colors.black,
              radius: 15,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/HEADER.webp'),
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
      drawer: Drawer(
        backgroundColor: navBackground,
        width:
        MediaQuery.of(context).size.width, // 75% of screen will be occupied
        child: ListView(
          children: [
            AppBar(
              backgroundColor: navBackground,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 28,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the navigation drawer
                },
              ),
              title: Padding(
                padding: const EdgeInsets.all(2.0),
                child:
                Container(), /*Center(
                  child:
                      Image.asset('assets/omalogo.png', height: 50, width: 100),
                ),*/
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    color: blackColor,
                    size: 26,
                  ),
                  onPressed: () {
                    getNavdata();
                    _controller.jumpToTab(3);
                    Navigator.of(context).pop();
                    // Navigator.pushNamed(context, Settings.routeName);
                  },
                ),
                const SizedBox(
                  width: 12,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: GestureDetector(
                    onTap: () {
                      token.isEmpty
                          ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      )
                          : _controller.jumpToTab(4);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 15,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/HEADER.webp'),
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
                        homeKey.currentState!.pushNamed(ProductListing.routeName);
                        // navigate(context, ProductListing.routeName,
                        //     isRootNavigator: false,
                        //     arguments: {'id': '1'});

                        catId = navHeaderList[index]['id'];
                        print('item_id --> $catId');
                        final myProvider = Provider.of<MyProvider>(
                            context,
                            listen: false);
                        myProvider.updateData(catId);
                        myProvider
                            .updateHeader(navHeaderList[index]['name']);
                        _controller.jumpToTab(0);
                        myProvider.isproduct=true;
                        myProvider.notifyListeners();

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
                                  _controller.jumpToTab(0);
                                  myProvider.isproduct=true;
                                  myProvider.notifyListeners();

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
                                          _controller.jumpToTab(0);
                                          myProvider.isproduct=true;
                                          myProvider.notifyListeners();
                                          HomeScreen.moveToProduct(selectedContext);
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

      body: NavBarHandler(),
    );
    return Consumer<MyProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: chipColor),
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.location_on_outlined,
                    size: 24,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                const Text(
                  'Gurugram',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                  color: blackColor,
                  size: 26,
                ),
                onPressed: () {
                  /*getNavdata();*/
                  _controller.jumpToTab(2);
                },
              ),
              const SizedBox(
                width: 12,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: GestureDetector(
                  onTap: () {
                    token.isEmpty
                        ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    )
                        : _controller.jumpToTab(4);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 15,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/HEADER.webp'),
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
          body: PersistentTabView(
            context,
            controller: _controller,
            onWillPop: (cnt) async{
              if(_controller.index==0){
                final myProvider = Provider.of<MyProvider>(
                    context,
                    listen: false);
                if(myProvider.isproduct){
                  myProvider.isproduct=false;
                  myProvider.notifyListeners();
                }
              }
              return Future.value(true);
            },
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.white, // Default is Colors.white.
            handleAndroidBackButtonPress: false, // Default is true.
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
            selectedTabScreenContext: (context){
              selectedContext=context;
            },
            hideNavigationBar: myProvider!.navBar,
            navBarStyle:
            NavBarStyle.simple, // Choose the nav bar style with this property.
          ),


          drawer: Drawer(
            backgroundColor: navBackground,
            width:
            MediaQuery.of(context).size.width, // 75% of screen will be occupied
            child: ListView(
              children: [
                AppBar(
                  backgroundColor: navBackground,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Close the navigation drawer
                    },
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child:
                    Container(), /*Center(
                  child:
                      Image.asset('assets/omalogo.png', height: 50, width: 100),
                ),*/
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        color: blackColor,
                        size: 26,
                      ),
                      onPressed: () {
                        getNavdata();
                        _controller.jumpToTab(3);
                        Navigator.of(context).pop();
                        // Navigator.pushNamed(context, Settings.routeName);
                      },
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: GestureDetector(
                        onTap: () {
                          token.isEmpty
                              ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          )
                              : _controller.jumpToTab(4);
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 15,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/HEADER.webp'),
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
                            _controller.jumpToTab(0);
                            myProvider.isproduct=true;
                            myProvider.notifyListeners();

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
                                  initiallyExpanded: true,
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
                                      _controller.jumpToTab(0);
                                      myProvider.isproduct=true;
                                      myProvider.notifyListeners();

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
                                              _controller.jumpToTab(0);
                                              myProvider.isproduct=true;
                                              myProvider.notifyListeners();
                                              HomeScreen.moveToProduct(selectedContext);
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
        );
      },


    );

  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const Discover(), //ProductListing (id: catId)
      const Wishlist(),
      const CartScreen(),
      const ProfileScreen() //Discover
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.house),
        iconSize: 20.0,
        title: ("Home"),
        textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        activeColorPrimary: headingColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.compass),
        iconSize: 20.0,
        textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        title: ("Discover"),
        activeColorPrimary: headingColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.heart),
        iconSize: 20.0,
        title: ("WishList"),
        textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        activeColorPrimary: headingColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.cartPlus),
        iconSize: 20.0,
        textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        title: ("Cart"),
        activeColorPrimary: headingColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.user),
        iconSize: 20.0,
        textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
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
      child: const Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
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
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
class NextScreen extends StatefulWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  @override
  Widget build(BuildContext context) {
   return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Text("data");
          }));
        },
        child: Text('Home Page')) ; }
}
/*
 * File: main.dart
 * Project: BottomNavigationBar demo
 * File Created: Wednesday, 26th May 2022 1:15:47 pm
 * Author: Mahesh Jamdade
 * -----
 * Last Modified: Saturday, 28th May 2022 4:42:07 pm
 * Modified By: Mahesh Jamdade
 * -----
 */


class MenuItem {
  const MenuItem(this.iconData, this.text);
  final IconData iconData;
  final String text;
}

Future<void> navigate(BuildContext context, String route,
    {bool isDialog = false,
      bool isRootNavigator = true,
      Map<String, dynamic>? arguments}) =>
    Navigator.of(context, rootNavigator: isRootNavigator)
        .pushNamed(route, arguments: arguments);

final homeKey = GlobalKey<NavigatorState>();
final productsKey = GlobalKey<NavigatorState>();
final wishKey = GlobalKey<NavigatorState>();
final cartKey = GlobalKey<NavigatorState>();
final profileKey = GlobalKey<NavigatorState>();
final NavbarNotifier _navbarNotifier = NavbarNotifier();
List<Color> colors = [themecolor,themecolor,themecolor,themecolor,themecolor];
const Color mediumPurple = Color.fromRGBO(79, 0, 241, 1.0);
const String placeHolderText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

class NavBarHandler extends StatefulWidget {
  const NavBarHandler({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<NavBarHandler> createState() => _NavBarHandlerState();
}

class _NavBarHandlerState extends State<NavBarHandler>
    with SingleTickerProviderStateMixin {
  final _buildBody = const <Widget>[const HomeScreen(),
    const CartScreen(), //ProductListing (id: catId)
    const Wishlist(),
    const CartScreen(),
    const ProfileScreen() ];

  late List<BottomNavigationBarItem> _bottomList = <BottomNavigationBarItem>[];


  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
        icon: const Icon(FontAwesomeIcons.house),
        label: ("Home"),
      ),
      BottomNavigationBarItem(
        icon: const Icon(FontAwesomeIcons.compass),
        label: ("Discover"),
      ),
      BottomNavigationBarItem(
        icon: const Icon(FontAwesomeIcons.heart),
        label: ("WishList"),
      ),
      BottomNavigationBarItem(
        icon: const Icon(FontAwesomeIcons.cartPlus),
        label: ("Cart"),
      ),
      BottomNavigationBarItem(
        icon: const Icon(FontAwesomeIcons.user),
        label: ("Profile"),
      ),
    ];
  }

  final menuItemlist = const <MenuItem>[
    MenuItem(FontAwesomeIcons.house, 'Home'),
    MenuItem(FontAwesomeIcons.compass, 'Discover'),
    MenuItem(FontAwesomeIcons.heart, 'WishList'),
    MenuItem(FontAwesomeIcons.cartPlus, 'Cart'),
    MenuItem(FontAwesomeIcons.user, 'Profile'),
  ];

  late Animation<double> fadeAnimation;
  late AnimationController _controller;
  var token;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    fadeAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );

    _bottomList = List.generate(
        _buildBody.length,
            (index) => BottomNavigationBarItem(
          icon: Icon(menuItemlist[index].iconData),
          label: menuItemlist[index].text,
        )).toList();
    _controller.forward();
    getuserdata();
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 600),
        margin: EdgeInsets.only(
            bottom: kBottomNavigationBarHeight, right: 2, left: 2),
        content: Text('Tap back button again to exit'),
      ),
    );
  }

  void hideSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void getuserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DateTime oldTime = DateTime.now();
  DateTime newTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool isExitingApp = await _navbarNotifier.onBackButtonPressed();
        if (isExitingApp) {
          newTime = DateTime.now();
          int difference = newTime.difference(oldTime).inMilliseconds;
          oldTime = newTime;
          if (difference < 1000) {
            hideSnackBar();
            return isExitingApp;
          } else {
            showSnackBar();
            return false;
          }
        } else {
          return isExitingApp;
        }
      },
      child: Material(
        child: AnimatedBuilder(
            animation: _navbarNotifier,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  IndexedStack(
                    index: _navbarNotifier.index,
                    children: [
                      for (int i = 0; i < _buildBody.length; i++)
                        FadeTransition(
                            opacity: fadeAnimation, child: _buildBody[i])
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedNavBar(
                        model: _navbarNotifier,
                        onItemTapped: (x) {

                          if((x==4||x==2) && token.isEmpty){

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          }else{
                            if (_navbarNotifier.index == x) {
                              _navbarNotifier.popAllRoutes(x);
                            } else {
                              _navbarNotifier.index = x;
                              _controller.reset();
                              _controller.forward();
                            }

                          }


                          // User pressed  on the same tab twice
                        },
                        menuItems: menuItemlist),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class NavbarNotifier extends ChangeNotifier {
  int _index = 0;
  int get index => _index;
  bool _hideBottomNavBar = false;

  set index(int x) {
    _index = x;
    notifyListeners();
  }

  bool get hideBottomNavBar => _hideBottomNavBar;
  set hideBottomNavBar(bool x) {
    _hideBottomNavBar = x;
    notifyListeners();
  }

  // pop routes from the nested navigator stack and not the main stack
  // this is done based on the currentIndex of the bottom navbar
  // if the backButton is pressed on the initial route the app will be terminated
  Future<bool> onBackButtonPressed() async {
    bool exitingApp = true;
    switch (_navbarNotifier.index) {
      case 0:
        if (homeKey.currentState != null && homeKey.currentState!.canPop()) {
          homeKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      case 1:
        if (productsKey.currentState != null &&
            productsKey.currentState!.canPop()) {
          productsKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      case 2:
        if (wishKey.currentState != null &&
            wishKey.currentState!.canPop()) {
          wishKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      case 3:
        if (cartKey.currentState != null &&
            cartKey.currentState!.canPop()) {
          cartKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      case 4:
        if (profileKey.currentState != null &&
            profileKey.currentState!.canPop()) {
          profileKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      default:
        return false;
    }
    if (exitingApp) {
      return true;
    } else {
      return false;
    }
  }

  // pops all routes except first, if there are more than 1 route in each navigator stack
  void popAllRoutes(int index) {
    switch (index) {
      case 0:
        if (homeKey.currentState!.canPop()) {
          homeKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      case 1:
        if (productsKey.currentState!.canPop()) {
          productsKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      case 2:
        if (wishKey.currentState!.canPop()) {
          wishKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      case 3:
        if (cartKey.currentState!.canPop()) {
          cartKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      case 4:
        if (profileKey.currentState!.canPop()) {
          profileKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      default:
        break;
    }
  }
}

class AnimatedNavBar extends StatefulWidget {
  const AnimatedNavBar(
      {Key? key,
        required this.model,
        required this.menuItems,
        required this.onItemTapped})
      : super(key: key);
  final List<MenuItem> menuItems;
  final NavbarNotifier model;
  final Function(int) onItemTapped;

  @override
  _AnimatedNavBarState createState() => _AnimatedNavBarState();
}

class _AnimatedNavBarState extends State<AnimatedNavBar>
    with SingleTickerProviderStateMixin {
  @override
  void didUpdateWidget(covariant AnimatedNavBar oldWidget) {
    if (widget.model.hideBottomNavBar != isHidden) {
      if (!isHidden) {
        _showBottomNavBar();
      } else {
        _hideBottomNavBar();
      }
      isHidden = !isHidden;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _hideBottomNavBar() {
    _controller.reverse();
    return;
  }

  void _showBottomNavBar() {
    _controller.forward();
    return;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: 100.0).animate(_controller);
  }

  late AnimationController _controller;
  late Animation<double> animation;
  bool isHidden = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(0, animation.value),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(2, -2),
                ),
              ]),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                currentIndex: widget.model.index,
                onTap: (x) {
                  widget.onItemTapped(x);
                },
                elevation: 16.0,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.grey.shade500,
                selectedItemColor: themecolor,
                items: widget.menuItems
                    .map((MenuItem menuItem) => BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(menuItem.iconData),
                  label: menuItem.text,
                ))
                    .toList(),
              ),
            ),
          );
        });
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme:
          Theme.of(context).colorScheme.copyWith(primary: colors[0])),
      child: Navigator(
          key: homeKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const HomeFeeds();
                break;
              case FeedDetail.route:
                builder = (BuildContext _) {
                  final id = (settings.arguments as Map)['id'];
                  return FeedDetail(
                    feedId: id,
                  );
                };
                break;
              default:
                builder = (BuildContext _) => const HomeFeeds();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          }),
    );
  }
}

class ProductsMenu extends StatelessWidget {
  const ProductsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme:
          Theme.of(context).colorScheme.copyWith(primary: colors[1])),
      child: Navigator(
          key: productsKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const ProductList();
                break;
              case ProductDetail.route:
                final id = (settings.arguments as Map)['id'];
                builder = (BuildContext _) {
                  return ProductDetail(
                    id: id,
                  );
                };
                break;
              case ProductComments.route:
                final id = (settings.arguments as Map)['id'];
                builder = (BuildContext _) {
                  return ProductComments(
                    id: id,
                  );
                };
                break;
              default:
                builder = (BuildContext _) => const ProductList();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          }),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme:
          Theme.of(context).colorScheme.copyWith(primary: colors[2])),
      child: Navigator(
          key: profileKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const UserProfile();
                break;
              case ProfileEdit.route:
                builder = (BuildContext _) => const ProfileEdit();
                break;
              default:
                builder = (BuildContext _) => const UserProfile();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          }),
    );
  }
}

class HomeFeeds extends StatefulWidget {
  const HomeFeeds({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<HomeFeeds> createState() => _HomeFeedsState();
}

class _HomeFeedsState extends State<HomeFeeds> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addScrollListener();
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_navbarNotifier.hideBottomNavBar) {
          _navbarNotifier.hideBottomNavBar = false;
        }
      } else {
        if (!_navbarNotifier.hideBottomNavBar) {
          _navbarNotifier.hideBottomNavBar = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeds'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 30,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                _navbarNotifier.hideBottomNavBar = false;
                navigate(context, FeedDetail.route,
                    isRootNavigator: false,
                    arguments: {'id': index.toString()});
              },
              child: FeedTile(index: index));
        },
      ),
    );
  }
}

class FeedTile extends StatelessWidget {
  final int index;
  const FeedTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      color: Colors.grey.withOpacity(0.4),
      child: Stack(
        children: [
          Positioned(
            top: 4,
            right: 4,
            left: 4,
            child: Container(
              color: Colors.grey,
              height: 180,
            ),
          ),
          Positioned(
              bottom: 12,
              right: 12,
              left: 12,
              child: Text(placeHolderText.substring(0, 200)))
        ],
      ),
    );
  }
}

class FeedDetail extends StatelessWidget {
  final String feedId;
  const FeedDetail({Key? key, this.feedId = '1'}) : super(key: key);
  static const String route = '/feeds/detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed $feedId'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Placeholder(
                fallbackHeight: 200,
                fallbackWidth: 300,
              ),
              Text(placeHolderText),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addScrollListener();
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_navbarNotifier.hideBottomNavBar) {
          _navbarNotifier.hideBottomNavBar = false;
        }
      } else {
        if (!_navbarNotifier.hideBottomNavBar) {
          _navbarNotifier.hideBottomNavBar = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    _navbarNotifier.hideBottomNavBar = false;
                    navigate(context, ProductDetail.route,
                        isRootNavigator: false,
                        arguments: {'id': index.toString()});
                  },
                  child: ProductTile(index: index)),
            );
          }),
    );
  }
}

class ProductTile extends StatelessWidget {
  final int index;
  const ProductTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey.withOpacity(0.5),
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              height: 75,
              width: 75,
              color: Colors.grey,
            ),
            Text('Product $index'),
          ],
        ));
  }
}

class ProductDetail extends StatelessWidget {
  final String id;
  const ProductDetail({Key? key, this.id = '1'}) : super(key: key);
  static const String route = '/products/detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product $id'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('My AWESOME Product $id'),
          const Center(
            child: Placeholder(
              fallbackHeight: 200,
              fallbackWidth: 300,
            ),
          ),
          TextButton(
              onPressed: () {
                _navbarNotifier.hideBottomNavBar = false;
                navigate(context, ProductComments.route,
                    isRootNavigator: false, arguments: {'id': id.toString()});
              },
              child: const Text('show comments'))
        ],
      ),
    );
  }
}

class ProductComments extends StatelessWidget {
  final String id;
  const ProductComments({Key? key, this.id = '1'}) : super(key: key);
  static const String route = '/products/detail/comments';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments on Product $id'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60,
            child: ListTile(
              tileColor: Colors.grey.withOpacity(0.5),
              title: Text('Comment $index'),
            ),
          ),
        );
      }),
    );
  }
}

class UserProfile extends StatelessWidget {
  static const String route = '/';

  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                navigate(context, ProfileEdit.route);
              },
            )
          ],
          title: const Text('Hi User')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hi My Name is'),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    decoration: InputDecoration(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileEdit extends StatelessWidget {
  static const String route = '/profile/edit';

  const ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Edit')),
      body: const Center(
        child: Text('Notice this page does not have bottom navigation bar'),
      ),
    );
  }
}
