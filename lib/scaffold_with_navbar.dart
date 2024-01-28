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
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

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
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: const Icon(Icons.arrow_back),
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
                    return cartProd.cartNumbers==0?Container():Positioned(
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
                        child: provider.wishListNumbers==0?Container():Container(
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
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
              child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                   /* leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),*/
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
                  )

              ),
            ),
            Expanded(child: CartScreen(isFromActionBar: true,)),
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
        leading: _showLeading(context) ? _leadButton(context) :          null /*Row(
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
        )*/,
        elevation: 0,
        iconTheme: const IconThemeData(color: chipColor),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image.asset('assets/omalogo.png', height: 25, width: 80),
        ),
        actions: [
          Center(
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: const Icon(Icons.search, size: 25,),
              ),
              onTap: () => _key.currentState?.openEndDrawer(),
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
          Center(
            child: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                  child: const Icon(Icons.shopping_bag, size: 25,),
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
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  } else {
                    setState(() {
                      _selectedIndex = 4;
                    });
                    _onTap(4);
                  }
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 12,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/photo.jpg'),
                  ),
                ),
              ),
            ),
          ),

          /*  IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black54,
              size: 20,
            ),
            onPressed: () {
              */ /*getNavdata();*/ /*
            },
          ),*/

          const SizedBox(
            width: 0,
          ),
          // IconButton(
          //   icon: const FaIcon(
          //     Icons.shopping_bag_sharp,
          //     size: 28,
          //     color: headingColor,
          //   ),
          //   onPressed: () {
          //     CartProvider cartProvider =
          //         Provider.of<CartProvider>(context, listen: false);
          //     cartProvider.getCartData();
          //   },
          // ),
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
              automaticallyImplyLeading: false,
              backgroundColor: navBackground,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const LoginPage()),
                      // );
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

                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.black54,
                    size: 20,
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
                return Divider(
                  color: navHeaderList[index]['include_in_menu'] != 1
                      ? Colors.transparent
                      : textColor,
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
                              // myProvider.updateData(catId);
                              myProvider
                                  .updateHeader(navHeaderList[index]['name']);
                              myProvider.isproduct = true;
                              myProvider.notifyListeners();
                              context.go('/home/pdp',extra: navHeaderList[index]);
                            },
                            child: Text(
                              navHeaderList[index]['name'],
                              style: const TextStyle(
                                  color: navTextColor,
                                  fontSize: 12,
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
                                        Navigator.of(context).pop();
                                        print('item_id --> $catId');
                                        context.go('/home/catDetails',
                                            extra: navHeaderList[index]
                                                ['children'][itemIndex]);

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
                                                // myProvider.updateData(catId);
                                                myProvider.updateHeader(
                                                    navHeaderList[index][
                                                                        'children']
                                                                    [itemIndex]
                                                                ['children'][
                                                            subitemIndex]['name']
                                                        .toString());
                                                myProvider.isproduct = true;
                                                myProvider.notifyListeners();
                                                context.go('/home/pdp',extra: navHeaderList[index]['children'][itemIndex]);
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
          ],
        ),
      ),
    );
  } /*  bottomNavigationBar: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            color: Colors.white,
            child: TabBar(
                onTap: (x) {
                  if (x == 1) {
                    _key.currentState!.openDrawer();
                    setState(() {
                      _selectedIndex = 0;
                    });
                    return;
                  }

                  _onTap(x);
                  setState(() {
                    _selectedIndex = x;
                  });
                },
                labelColor: Colors.grey,
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
      ),*/

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
                onPressed: (){

                },
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