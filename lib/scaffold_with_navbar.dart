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
  String? count = '0';
  late TabController _tabController;
  String cart_token = '';
  late CartProvider cartProvider;
  var test;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
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
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.getCartData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: Drawer(
        clipBehavior: Clip.none,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 0,
              child: DrawerHeader(
                child: Container(),
                /*ListTile(
                    contentPadding: EdgeInsets.zero,
                   */
                /* leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),*/
                /*
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
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'My Cart', //($count)
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                ),
                // FlutterLogo(),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
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
            child: Image.asset('assets/omalogo.png', height: 35, width: 80),
          ),
        ),
        actions: [

          GestureDetector(
            child: Image.asset(
              'assets/images/search.png',
              width: 28,
              height: 22,
            ),
            onTap: () {
              myProvider!.showHideSearch();
            },
          ),

          const SizedBox(width: 10,),
          /*IconButton(
            onPressed: () {
              // isSearch = !isSearch;
              // setState(() {
              //
              // });
              myProvider!.showHideSearch();
            },
            icon: const Icon(Icons.search),
          ),*/
          Center(
            child: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/shopping_bag.png',
                    width: 28,
                    height: 22,
                  ),
                  onTap: () {
                    // count =
                    //     cartProvider.cartModel.cart!.items!.length.toString();
                    Scaffold.of(context).openEndDrawer();
                  },
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
      body: widget.navigationShell,

      /*Column(
        children: [
          isSearch?SearchForm():Container(),
          SingleChildScrollView(child: Container(
              height: MediaQuery.of(context).size.height-(isSearch?144:0),
              child: widget.navigationShell)),
        ],
      )*/

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
              iconTheme: const IconThemeData(color: chipColor),
              centerTitle: true,
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
              title: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the navigation drawer

                  if (GoRouter.of(context).location != "/home") {
                    context.go("/home");
                  }

                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset('assets/omalogo.png', height: 35, width: 80),
                ),
              ),
              actions: [
                Center(
                  child:  GestureDetector(
                    child: Image.asset(
                      'assets/images/search.png',
                      width: 28,
                      height: 22,
                    ),
                    onTap: () {
                      myProvider!.showHideSearch();
                    },
                  ),
                ),
                const SizedBox(width: 10,),
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

                        onTap: () {
                          /*count = cartProvider.cartModel.cart!.items!.length
                              .toString();*/
                          Scaffold.of(context).openEndDrawer();
                        },

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
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return navHeaderList[index]['include_in_menu'] == 1
                    ? Divider(
                        color: navHeaderList[index]['include_in_menu'] != 1
                            ? Colors.transparent
                            : textColor,
                        thickness: 0.0,
                      )
                    : Container();
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
                              if (navHeaderList[index]['is_clickable'] == 1) {
                                Navigator.of(context).pop();
                                catId = navHeaderList[index]['id'];
                                final myProvider = Provider.of<MyProvider>(
                                    context,
                                    listen: false);
                                myProvider.updateHeader(
                                    navHeaderList[index]['name'].toString());
                                Map<String, dynamic> myMap = {};
                                // myProvider.updateData(catId,filter: myMap);
                                myProvider.isproduct = true;
                                myProvider.notifyListeners();
                                context.go('/home/pdp',
                                    extra: navHeaderList[index]);
                              }
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
                                    title: GestureDetector(
                                      onTap: () {
                                        print(navHeaderList[index]['children']
                                            [itemIndex]['is_clickable']);

                                        if (navHeaderList[index]['children']
                                                [itemIndex]['is_clickable'] ==
                                            1) {
                                          Navigator.of(context).pop();
                                          catId = navHeaderList[index]
                                              ['children'][itemIndex]['id'];
                                          final myProvider =
                                              Provider.of<MyProvider>(context,
                                                  listen: false);
                                          myProvider.updateHeader(
                                              navHeaderList[index]['children']
                                                      [itemIndex]['name']
                                                  .toString());
                                          myProvider.isproduct = true;
                                          myProvider.notifyListeners();
                                          context.go('/home/pdp',
                                              extra: navHeaderList[index]
                                                  ['children'][itemIndex]);

                                          /* Navigator.of(context).pop();
                                          catId = navHeaderList[index]['children']
                                              [itemIndex]['id'];
                                          final myProvider =
                                              Provider.of<MyProvider>(context,
                                                  listen: false);
                                          myProvider.updateHeader(
                                              navHeaderList[index]['children']
                                                  [itemIndex]['name']);
                                          myProvider.isproduct = true;
                                          myProvider.notifyListeners();
                                          context.go('/home/pdp');*/
                                        }

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

                                                print(navHeaderList[index]['children']
                                                [itemIndex]['children'][subitemIndex]['name'].toString());

                                                print(navHeaderList[index]['children'][itemIndex]['children']
                                                        [subitemIndex]['show_collection']);

                                                if (navHeaderList[index]['children'][itemIndex]
                                                                ['children'][subitemIndex]['show_collection'] == 1) {
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
                                                      navHeaderList[index]['children']
                                                                      [itemIndex]
                                                                  ['children'][subitemIndex]['name'].toString());
                                                  myProvider.isproduct = true;
                                                  myProvider.notifyListeners();
                                                  context.go(
                                                      '/home/cat_listing_filter',
                                                      extra:
                                                      navHeaderList[index]['children']
                                                      [itemIndex]
                                                      ['children'][subitemIndex]);
                                                } else {
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
                                                      extra: navHeaderList[
                                                                          index]
                                                                      [
                                                                      'children']
                                                                  [
                                                                  itemIndex]
                                                              ['children']
                                                          [subitemIndex]);
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
                            child: getbrandslist[itemIndex]['status'] == 1 ? Text(
                              getbrandslist[itemIndex]['name'].toUpperCase(),
                              style: const TextStyle(
                                  color: navTextColor,
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal),
                            ) : const Center(),
                          ),
                        );
                      },
                    )
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
