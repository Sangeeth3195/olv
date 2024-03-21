import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/screens/cart/cart_screen.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';
import '../../models/CategoryInfo.dart';
import 'components/product_card.dart';

class ProductListing extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProductListing({Key? key, required this.data}) : super(key: key);
  static const String routeName = "/home_screen";

  @override
  State<ProductListing> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProductListing> {
  String _selectedOption = "Most Relevant";
  GraphQLService graphQLService = GraphQLService();
  List<dynamic> pList = [];
  CategoryInfo getcategoryInfo = CategoryInfo();

  var selectedColor = 0;

  final List<String> _options = [
    'Most Relevant',
    'Product Name',
    'Low to high',
    'High to low',
  ];

  final GlobalKey<ScaffoldState> _childDrawerKey = GlobalKey();

  int currentPage = 1;
  int itemsPerPage = 10;
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int cat_id = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    isLoading = true;
    print(widget.data['name']);

    setState(() {});

    if (widget.data['rt_from'] == 'home_screen') {
      print(widget.data['rt_from']);
      print(widget.data['link_data']);
      print(widget.data['id']);
      cat_id = int.parse(widget.data['id']);
      getNavdata();
    } else {
      getNavdata();
      cat_id = widget.data['id'];
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    print("scroll listener");
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        currentPage++;
      });
      Map<String, dynamic> myMap = {};
      final provider = Provider.of<MyProvider>(context, listen: false);

      myMap['category_id'] = "{eq: $cat_id}"; //widget.data['id']
      for (int i = 0; i < provider.aggregationList.length; i++) {
        myMap[provider.aggregationList[i].attributeCode] =
            "{in: ${provider.aggregationList[i].selected}}";
      }
      myMap.remove('price');
      // myMap.remove('category_id');
      myMap.remove('category_uid');

      log(myMap.toString());
      provider.loadMoreData(cat_id,
          limit: 20,
          currentPage: currentPage,
          filter: myMap); // widget.data['id']
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void getNavdata() async {
    if (widget.data['rt_from'] == 'home_screen') {
      cat_id = int.parse(widget.data['id']);
    } else {
      cat_id = widget.data['id'];
    }

    getcategoryInfo = await graphQLService.getCategoryInfo(cat_id.toString());
    final provider = Provider.of<MyProvider>(context, listen: false);
    provider.rangeValues = null;
    filterData();
  }

  void filterData() async {
    Map<String, dynamic> myMap = {};
    final provider = Provider.of<MyProvider>(context, listen: false);

    myMap['category_id'] = "{eq: $cat_id}";

    /// widget.data['id']
    for (int i = 0; i < provider.aggregationList.length; i++) {
      myMap[provider.aggregationList[i].attributeCode] =
          "{in: ${provider.aggregationList[i].selected}}";
    }
    myMap.remove('price');
    if(provider.rangeValues != null){
      myMap["price"] ="{from:${provider.rangeValues!.start.ceil()},to:${provider.rangeValues!.end.ceil()}}";
    }
    print('cat_id Test');
    print(cat_id);

    log(myMap.toString());
    provider.updateData(cat_id, filter: myMap); //widget.data['id']
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final myProvider = Provider.of<MyProvider>(context, listen: false);
        if (myProvider.isproduct) {
          myProvider.isproduct = false;
          myProvider.notifyListeners();
        }
        return Future.value(true);
      },
      child: Consumer<MyProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            key: _childDrawerKey,
            drawer: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 15, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Apply Filters',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: priceColor,
                                  height: 1.5,
                                  fontSize: 16)),
                          Container(
                            height: 30,
                            width: 35,
                            color: priceColor,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                size: 14,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(
                                    context); // Close the navigation drawer
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: provider.aggregationList.length,
                      itemBuilder: (BuildContext context, int subitemIndex) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5.0, 0, 10, 5),
                                  child: Text(
                                    provider.aggregationList[subitemIndex].label
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: priceColor,
                                        height: 1.5,
                                        fontFamily: 'Gotham',
                                        fontSize: 14),
                                  ),
                                ),
                                children: [
                                  provider.aggregationList[subitemIndex]
                                              .label ==
                                          "Price"
                                      ? Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              provider.rangeValues == null ? Container(): RangeSlider(
                                                values: provider.rangeValues!,
                                                max: provider.rangeValues!.end,
                                                // divisions: 30,
                                                // Optional: Increase for a smoother slider
                                                onChanged:
                                                    (RangeValues values) {
                                                  setState(() {
                                                    provider.rangeValues =
                                                        values;
                                                  });

                                                },
                                                onChangeEnd: (RangeValues values) {
                                                  // Call the method to fetch data when slider is released
                                                  filterData();
                                                },
                                                labels: RangeLabels(
                                                  '\$${provider.rangeValues!.start.round()}',
                                                  '\$${provider.rangeValues!.end.round()}',
                                                ),
                                              ),
                                              provider.rangeValues == null ? Container():Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20.0, 0, 10, 5),
                                                child: Text(
                                                    " ${provider.rangeValues!.start.ceil()} -  ${provider.rangeValues!.end.ceil()}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54,
                                                        fontFamily: 'Gotham',
                                                        height: 1,
                                                        fontSize: 15)),
                                              )
                                            ],
                                          ),
                                        )
                                      : provider.aggregationList[subitemIndex]
                                                  .label ==
                                              "Color"
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5.0, 0, 10, 5),
                                              child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 9,
                                                  // Number of columns
                                                  crossAxisSpacing: 5,
                                                  // Horizontal spacing between items
                                                  mainAxisSpacing:
                                                      5, // Vertical spacing between rows
                                                ),
                                                shrinkWrap: true,
                                                itemCount: provider
                                                    .aggregationList[
                                                        subitemIndex]
                                                    .options
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final option = provider
                                                      .aggregationList[
                                                          subitemIndex]
                                                      .options[index];
                                                  final isSelected = provider
                                                      .aggregationList[
                                                          subitemIndex]
                                                      .selected
                                                      .contains(option.value);

                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (isSelected) {
                                                          provider
                                                              .aggregationList[
                                                                  subitemIndex]
                                                              .selected
                                                              .remove(
                                                                  option.value);
                                                        } else {
                                                          provider
                                                              .aggregationList[
                                                                  subitemIndex]
                                                              .selected
                                                              .add(
                                                                  option.value);
                                                        }
                                                      });
                                                      print(provider
                                                          .aggregationList[
                                                              subitemIndex]
                                                          .selected);
                                                      filterData();
                                                    },
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: isSelected
                                                              ? Colors.red
                                                              : Colors
                                                                  .transparent
                                                                  .withOpacity(
                                                                      0.2),
                                                          // Change border color if selected
                                                          width: 2.0,
                                                        ),
                                                        shape: BoxShape.circle,
                                                        color: colorFromHex(
                                                            option.swatchData!
                                                                .value),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          /*Container(
                                              color: priceColor.withOpacity(0.3),

                                              child: Wrap(
                                                children: List.generate(
                                                  provider
                                                      .aggregationList[
                                                          subitemIndex]
                                                      .options
                                                      .length,
                                                  (int index) {
                                                    return CheckboxListTile(
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      title: SizedBox(
                                                        height: 12,
                                                        width: 12,
                                                        child: Container(
                                                          margin: const EdgeInsets
                                                              .symmetric(horizontal: 5),
                                                          padding:
                                                          const EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .transparent,
                                                                width:
                                                                2.0), // Using BorderSide with BoxDecoration

                                                            shape: BoxShape.circle,
                                                            color: colorFromHex(provider
                                                                .aggregationList[
                                                            subitemIndex]
                                                                .options[index].swatchData!.value),
                                                          ),
                                                        ),
                                                      ),
                                                      value: provider
                                                          .aggregationList[
                                                              subitemIndex]
                                                          .selected
                                                          .contains(provider
                                                              .aggregationList[
                                                                  subitemIndex]
                                                              .options[index]
                                                              .value),
                                                      // onselected method
                                                      onChanged:
                                                          (bool? selected) {
                                                        setState(() {
                                                          if (selected!) {
                                                            provider
                                                                .aggregationList[
                                                                    subitemIndex]
                                                                .selected
                                                                .add(provider
                                                                    .aggregationList[
                                                                        subitemIndex]
                                                                    .options[
                                                                        index]
                                                                    .value);
                                                          } else {
                                                            provider
                                                                .aggregationList[
                                                                    subitemIndex]
                                                                .selected
                                                                .remove(provider
                                                                    .aggregationList[
                                                                        subitemIndex]
                                                                    .options[
                                                                        index]
                                                                    .value);
                                                          }
                                                        });
                                                        print(provider
                                                            .aggregationList[
                                                                subitemIndex]
                                                            .selected);
                                                      },
                                                    );
                                                  },
                                                ).toList(),
                                              ),
                                            )
                              */
                                          : Column(
                                              // list of length 3
                                              children: List.generate(
                                                provider
                                                    .aggregationList[
                                                        subitemIndex]
                                                    .options
                                                    .length,
                                                (int index) {
                                                  return CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title: Text(
                                                        "${provider.aggregationList[subitemIndex].options[index].label} (${provider.aggregationList[subitemIndex].options[index].count}) ",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                'Gotham',
                                                            height: 1,
                                                            fontSize: 12)),
                                                    value: provider
                                                        .aggregationList[
                                                            subitemIndex]
                                                        .selected
                                                        .contains(provider
                                                            .aggregationList[
                                                                subitemIndex]
                                                            .options[index]
                                                            .value),
                                                    onChanged:
                                                        (bool? selected) {
                                                      setState(() {
                                                        if (selected!) {
                                                          provider
                                                              .aggregationList[
                                                                  subitemIndex]
                                                              .selected
                                                              .add(provider
                                                                  .aggregationList[
                                                                      subitemIndex]
                                                                  .options[
                                                                      index]
                                                                  .value);
                                                        } else {
                                                          provider
                                                              .aggregationList[
                                                                  subitemIndex]
                                                              .selected
                                                              .remove(provider
                                                                  .aggregationList[
                                                                      subitemIndex]
                                                                  .options[
                                                                      index]
                                                                  .value);
                                                        }
                                                      });
                                                      print(provider
                                                          .aggregationList[
                                                              subitemIndex]
                                                          .selected);
                                                      filterData();
                                                    },
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(color: Colors.black12);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width / 2 - 25,
                          height: 63,
                          child: ElevatedButton(
                            onPressed: () {
                              getNavdata();
                              Navigator.of(context).pop();
                              // Define the action to perform when the button is pressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: themecolor),
                                borderRadius: BorderRadius.circular(
                                    3.0), // Set the corner radius here
                              ),
                              padding: const EdgeInsets.all(
                                  10.0), // Optional: Set padding for the button
                              // Customize other properties like background color, elevation, etc.
                            ),
                            child: const Text(
                              'Clear All',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Gotham',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width / 2 - 25,
                          height: 63,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Define the action to perform when the button is pressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themecolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    3.0), // Set the corner radius here
                              ),
                              padding: const EdgeInsets.all(
                                  10.0), // Optional: Set padding for the button
                              // Customize other properties like background color, elevation, etc.
                            ),
                            child: const Text(
                              'Apply',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gotham',
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // endDrawer : Drawer(
            //     clipBehavior: Clip.none,
            //     shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.only(
            //           topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         SizedBox(
            //           height: 0,
            //           child: DrawerHeader(
            //             child: Container(),
            //             /*ListTile(
            //         contentPadding: EdgeInsets.zero,
            //        */
            //             /* leading: IconButton(
            //           icon: const Icon(Icons.arrow_back_ios),
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //         ),*/
            //             /*
            //         title: const Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //           //  Icon(Icons.shopping_cart),
            //             Text(
            //               'My Cart',
            //             )
            //           ],
            //         ),
            //         onTap: () {},
            //       )*/
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 35,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: <Widget>[
            //             Padding(
            //               padding: const EdgeInsets.only(left: 5.0),
            //               child: Text(
            //                 'My Cart (0)',
            //                 style: const TextStyle(color: Colors.black54, fontSize: 18),
            //               ),
            //             ),
            //             // FlutterLogo(),
            //             IconButton(
            //               icon: const Icon(
            //                 Icons.close,
            //                 size: 20,
            //                 color: Colors.black54,
            //               ),
            //               onPressed: () {
            //                 Navigator.of(context).pop();
            //               },
            //             ),
            //           ],
            //         ),
            //
            //         const Expanded(
            //             child: CartScreen(
            //               isFromActionBar: true,
            //             )),
            //         //const Expanded(child: CartContent())
            //       ],
            //     ),
            //   ),
            body: Column(
              children: [
                /*Container(
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: searchBackgroundColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: const SearchForm(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),*/

                Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 148,
                          child: Text(
                            getcategoryInfo.category?.name ??
                                widget.data['name'],
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: headingColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 0),
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _childDrawerKey.currentState?.openDrawer();
                            },
                            // styling the button
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                                side: const BorderSide(
                                  color: themecolor,
                                  width: 0.5,
                                ),
                              ),
                              padding: const EdgeInsets.all(8),
                              // Button color
                              backgroundColor: omaColor,
                              // Splash color
                              foregroundColor: omaColor,
                            ),
                            // icon of the button
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/adjustment.png',
                                  width: 28,
                                  height: 22,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "FILTER",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: headingColor,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${getcategoryInfo.category?.products.totalCount ?? widget.data['product_count']} ITEMS',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: headingColor,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.0,
                                ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 35,
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: omaColor,
                              border: Border.all(
                                color: themecolor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: DropdownButton<String>(
                              value: _selectedOption,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedOption = newValue!;
                                });
                                provider.sort(newValue!);
                                getNavdata();
                              },
                              underline: Container(),
                              items: _options.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0,
                                        color: navTextColor),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                provider.items.length == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 250,
                          ),
                          Text(
                            "We are curating the perfect list of products for you.",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: headingColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Meanwhile please browse our other categories.",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: headingColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                          ),
                        ],
                      )
                    : Expanded(
                        child: GridView.extent(
                          primary: false,
                          padding: const EdgeInsets.all(2),
                          childAspectRatio: 0.55,
                          maxCrossAxisExtent: 300,
                          cacheExtent: 10,
                          controller: _scrollController,
                          children: List.generate(
                            provider.items.length + 1,
                            (index) {
                              if (index < provider.items.length) {
                                return Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: ProductCard(
                                    openDrawer: () {
                                      Scaffold.of(context).openEndDrawer();
                                    },
                                    title: provider.items[index].name,
                                    image: provider.items[index].smallImage.url,
                                    price: provider.items[index].typename ==
                                            "SimpleProduct"
                                        ? provider.items[index].price
                                            .regularPrice.amount.value
                                            .toString()
                                        : "",
                                    product: provider.items[index],
                                    bgColor: demo_product[0].colors[0],
                                    item: provider.items[index],
                                    press: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                                product:
                                                    provider.items[index].sku),
                                          ));
                                    },
                                  ),
                                );
                              } else {
                                return const Center();
                              }
                            },
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color colorFromHex(String hexColor) {
    // Remove the '#' character from the hex color code, if present.
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    // Check if the hex color code is valid.
    if (hexColor.length != 6) {
      throw const FormatException(
          "Invalid hex color code. It should be 6 characters long (excluding the '#').");
    }

    print(int.parse('FF$hexColor', radix: 16));
    // Parse the hexadecimal values and construct the Color object.
    return Color(int.parse('FF$hexColor', radix: 16));
  }
}
