import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';
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
  final int _value = 0;

  var selectedColor = 0;

  final List<String> _options = [
    'Most Relevant',
    'Product Name',
    'Low to high',
    'High to low',
  ];

  final GlobalKey<ScaffoldState> _childDrawerKey = GlobalKey();
  RangeValues _currentRangeValues = RangeValues(50, 200);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavdata();

    print('widget');
    print('widget');
    print(widget.data['name']);
    print(widget.data['id']);
    print(widget.data);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  void getNavdata() async {
    print(widget.data);
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider.updateData(widget.data['id'],
        limit: widget.data['product_count']);
  }

  void filterData(Map<String, dynamic> filter) async {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider.updateDataWithFilter(widget.data['id'], filter);
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: priceColor,
                                  height: 1.5,
                                  fontSize: 18)),
                          Container(
                            height: 30,
                            width: 35,
                            color: priceColor,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                size: 16,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: provider.aggregationList.length,
                        itemBuilder: (BuildContext context, int subitemIndex) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              ExpansionTile(
                                title: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5.0, 0, 10, 5),
                                  child: Text(
                                    provider
                                        .aggregationList[subitemIndex].label,
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
                                          padding: const EdgeInsets.all(16.0),
                                          child: RangeSlider(
                                            values: _currentRangeValues,
                                            min: 0,
                                            max: 300,
                                            divisions:
                                                30, // Optional: Increase for a smoother slider
                                            onChanged: (RangeValues values) {
                                              setState(() {
                                                _currentRangeValues = values;
                                              });
                                            },
                                            labels: RangeLabels(
                                              '\$${_currentRangeValues.start.round()}',
                                              '\$${_currentRangeValues.end.round()}',
                                            ),
                                          ),
                                        )
                                      : provider.aggregationList[subitemIndex]
                                                  .label ==
                                              "Color"
                                          ? Container(
                                              color: priceColor,
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
                                                        child: Text(provider
                                                            .aggregationList[
                                                                subitemIndex]
                                                            .options[index]
                                                            .value),
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
                                          : Column(
                                              // list of length 3
                                              children: List.generate(
                                                provider
                                                    .aggregationList[
                                                        subitemIndex]
                                                    .options
                                                    .length,
                                                (int index) {
                                                  // choice chip allow us to
                                                  // set its properties.
                                                  return CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title: Text(
                                                        "${provider
                                                                .aggregationList[
                                                                    subitemIndex]
                                                                .options[index]
                                                                .label} (${provider.aggregationList[subitemIndex].options[index].count}) ",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w200,
                                                            color: blackColor,
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
                                                    },
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                ],
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container();
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          Map<String, dynamic> myMap = {};

                          for (int i = 0;
                              i < provider.aggregationList.length;
                              i++) {
                            myMap[provider.aggregationList[i].attributeCode] =
                                "{in: ${provider.aggregationList[i].selected}}";
                          }

                          log(myMap.toString());
                          filterData(myMap);
                          Navigator.of(context).pop();
                          // Define the action to perform when the button is pressed
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0), // Set the corner radius here
                          ),
                          padding: const EdgeInsets.all(
                              16.0), // Optional: Set padding for the button
                          // Customize other properties like background color, elevation, etc.
                        ),
                        child: const Text('Apply'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
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

                                // showModalBottomSheet(
                                //     isScrollControlled: true,
                                //     context: context,
                                //     shape: const RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.only(
                                //         // <-- SEE HERE
                                //         topLeft: Radius.circular(25.0),
                                //         topRight: Radius.circular(25.0),
                                //       ),
                                //     ),
                                //     builder: (context) {
                                //       return FractionallySizedBox(
                                //         heightFactor: 0.8,
                                //         child: StatefulBuilder(builder: (BuildContext
                                //         context,
                                //             StateSetter
                                //             setState /*You can rename this!*/) {
                                //           return SingleChildScrollView(
                                //             child: Column(
                                //               children: [
                                //                 SizedBox(
                                //                   height:MediaQuery.of(context).size.height/1.75,
                                //                   child: ListView.builder(
                                //                     shrinkWrap: true,
                                //                     physics:
                                //                     const ClampingScrollPhysics(),
                                //                     itemCount:
                                //                     provider.aggregationList.length,
                                //                     // Replace with the actual number of items
                                //                     itemBuilder: (BuildContext context,
                                //                         int subitemIndex) {
                                //                       return Column(
                                //                         mainAxisAlignment: MainAxisAlignment.start,
                                //                         crossAxisAlignment: CrossAxisAlignment.start,
                                //                         children: [
                                //                           const SizedBox(height: 20,),
                                //                           Padding(
                                //                             padding:
                                //                             const EdgeInsets.fromLTRB(
                                //                                 15.0, 0, 0, 5),
                                //                             child: Text(
                                //                               provider
                                //                                   .aggregationList[
                                //                               subitemIndex]
                                //                                   .label,
                                //                               style: const TextStyle(
                                //                                   fontWeight:
                                //                                   FontWeight.w700,
                                //                                   color: blackColor,
                                //                                   height: 1.5,
                                //                                   fontSize: 12),
                                //                             ),
                                //                           ),
                                //                           Padding(
                                //                             padding:
                                //                             const EdgeInsets.all(8.0),
                                //                             child: Column(
                                //                               // list of length 3
                                //                               children: List.generate(
                                //                                 provider
                                //                                     .aggregationList[subitemIndex].options
                                //                                     .length,
                                //                                     (int index) {
                                //                                   // choice chip allow us to
                                //                                   // set its properties.
                                //                                   return InputChip(
                                //                                     padding:
                                //                                     const EdgeInsets
                                //                                         .all(8),
                                //                                     label: Text(
                                //                                         provider.aggregationList[
                                //                                         subitemIndex].options
                                //                                         [index].label,
                                //                                         style: const TextStyle(
                                //                                             fontWeight:
                                //                                             FontWeight
                                //                                                 .w200,
                                //                                             color:
                                //                                             blackColor,
                                //                                             height: 1,
                                //                                             fontSize:
                                //                                             16)),
                                //                                     // color of selected chip
                                //                                     selectedColor:
                                //                                     chipColor,
                                //
                                //                                     backgroundColor:
                                //                                     const Color(0xFFEFEFEF),
                                //                                     // selected chip value
                                //                                     selected:
                                //                                     provider.aggregationList[
                                //                                     subitemIndex].selected.contains(provider.aggregationList[
                                //                                     subitemIndex].options
                                //                                     [index].value),
                                //                                     // onselected method
                                //                                     onSelected:
                                //                                         (bool selected) {
                                //                                       setState(() {
                                //                                         if(selected){
                                //                                           provider.aggregationList[
                                //                                           subitemIndex].selected.add(provider.aggregationList[
                                //                                           subitemIndex].options
                                //                                           [index].value);
                                //                                         }else{
                                //                                           provider.aggregationList[
                                //                                           subitemIndex].selected.remove(provider.aggregationList[
                                //                                           subitemIndex].options
                                //                                           [index].value);
                                //                                         }
                                //                                       });
                                //                                       print(
                                //                                           provider.aggregationList[
                                //                                           subitemIndex].selected);
                                //                                     },
                                //                                   );
                                //                                 },
                                //                               ).toList(),
                                //                             ),
                                //                           ),
                                //                         ],
                                //                       );
                                //                     },
                                //                   ),
                                //                 ),
                                //                 Container(
                                //                   margin: const EdgeInsets.all(10),
                                //
                                //                   width:MediaQuery.of(context).size.width,
                                //                   child: ElevatedButton(
                                //                     onPressed: () {
                                //                       Map<String, dynamic> myMap = {
                                //                       };
                                //
                                //                       for(int i=0;i<provider.aggregationList.length;i++){
                                //                         myMap[provider.aggregationList[i].attributeCode]= "{in: ${provider.aggregationList[i].selected}}";
                                //                       }
                                //
                                //                       log(myMap.toString());
                                //                       filterData(myMap);
                                //                       Navigator.of(context).pop();
                                //                       // Define the action to perform when the button is pressed
                                //                     },
                                //                     style: ElevatedButton.styleFrom(
                                //                       shape: RoundedRectangleBorder(
                                //                         borderRadius: BorderRadius.circular(16.0), // Set the corner radius here
                                //                       ),
                                //                       padding: const EdgeInsets.all(16.0), // Optional: Set padding for the button
                                //                       // Customize other properties like background color, elevation, etc.
                                //                     ),
                                //                     child: const Text('Apply'),
                                //                   ),
                                //                 )
                                //               ],
                                //             ),
                                //           );
                                //         }),
                                //       );
                                //     });
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
                              '${widget.data['product_count']} ITEMS',
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

                        // ElevatedButton(
                        //   onPressed: () {
                        //     showModalBottomSheet(
                        //         context: context,
                        //         shape: const RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.only(
                        //             // <-- SEE HERE
                        //             topLeft: Radius.circular(25.0),
                        //             topRight: Radius.circular(25.0),
                        //           ),
                        //         ),
                        //         builder: (context) {
                        //           return StatefulBuilder(builder: (BuildContext
                        //           context,
                        //               StateSetter
                        //               setState /*You can rename this!*/) {
                        //             return Column(
                        //               crossAxisAlignment:
                        //               CrossAxisAlignment.start,
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: <Widget>[
                        //                 const Center(
                        //                   child: SizedBox(
                        //                       width: 100,
                        //                       child: Divider(
                        //                         thickness: 4.0,
                        //                       )),
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.end,
                        //                   crossAxisAlignment:
                        //                   CrossAxisAlignment.end,
                        //                   children: [
                        //                     GestureDetector(
                        //                       onTap: () {
                        //                         Navigator.of(context).pop();
                        //                       },
                        //                       child: Container(
                        //                         margin:
                        //                         const EdgeInsets.only(right: 10),
                        //                         width: 24,
                        //                         height: 24,
                        //                         decoration: const BoxDecoration(
                        //                           color: Color(0xFFE6E6E6),
                        //                           shape: BoxShape.circle,
                        //                         ),
                        //                         child: const Center(
                        //                           child: Icon(
                        //                             Icons.close,
                        //                             color: Colors.black,
                        //                             size: 24 * 0.6,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 const Padding(
                        //                   padding: EdgeInsets.fromLTRB(
                        //                       15.0, 0, 0, 10),
                        //                   child: Text(
                        //                     'Sort By',
                        //                     style: TextStyle(
                        //                         fontWeight: FontWeight.w700,
                        //                         color: blackColor,
                        //                         height: 1.5,
                        //                         fontSize: 16),
                        //                   ),
                        //                 ),
                        //
                        //                 const Padding(
                        //                   padding: EdgeInsets.fromLTRB(
                        //                       15.0, 0, 0, 5),
                        //                   child: Text(
                        //                     'Price',
                        //                     style: TextStyle(
                        //                         fontWeight: FontWeight.w700,
                        //                         color: blackColor,
                        //                         height: 1.5,
                        //                         fontSize: 12),
                        //                   ),
                        //                 ),
                        //
                        //                 Padding(
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   child: Wrap(
                        //                     // list of length 3
                        //                     children: List.generate(
                        //                       _options.length,
                        //                           (int index) {
                        //                         // choice chip allow us to
                        //                         // set its properties.
                        //                         return ChoiceChip(
                        //                           padding:
                        //                           const EdgeInsets.all(8),
                        //                           label: Text(_options[index],
                        //                               style: const TextStyle(
                        //                                   fontWeight:
                        //                                   FontWeight.w200,
                        //                                   color: blackColor,
                        //                                   height: 1,
                        //                                   fontSize: 16)),
                        //                           // color of selected chip
                        //                           selectedColor: chipColor,
                        //
                        //                           backgroundColor:
                        //                           const Color(0xFFEFEFEF),
                        //                           // selected chip value
                        //                           selected: _value == index,
                        //                           // onselected method
                        //                           onSelected: (bool selected) {
                        //                             setState(() {
                        //                               _value = selected
                        //                                   ? index
                        //                                   : null;
                        //                             });
                        //                             print(_value);
                        //                             provider.sort(_value!);
                        //                             Navigator.of(context).pop();
                        //                           },
                        //                         );
                        //                       },
                        //                     ).toList(),
                        //                   ),
                        //                 ),
                        //
                        //                 const SizedBox(
                        //                   height: 20,
                        //                 ),
                        //                 // Container(
                        //                 //   margin: EdgeInsets.all(10),
                        //                 //
                        //                 //   width:MediaQuery.of(context).size.width,
                        //                 //   child: ElevatedButton(
                        //                 //     onPressed: () {
                        //                 //       // Define the action to perform when the button is pressed
                        //                 //       print('Button Pressed');
                        //                 //     },
                        //                 //     child: Text('Apply'),
                        //                 //     style: ElevatedButton.styleFrom(
                        //                 //       shape: RoundedRectangleBorder(
                        //                 //         borderRadius: BorderRadius.circular(16.0), // Set the corner radius here
                        //                 //       ),
                        //                 //       padding: EdgeInsets.all(16.0), // Optional: Set padding for the button
                        //                 //       // Customize other properties like background color, elevation, etc.
                        //                 //     ),
                        //                 //   ),
                        //                 // ),
                        //                 const SizedBox(
                        //                   height: 20,
                        //                 ),
                        //               ],
                        //             );
                        //           });
                        //         });
                        //   },
                        //   // styling the button
                        //   style: ElevatedButton.styleFrom(
                        //     shape: const CircleBorder(),
                        //     padding: const EdgeInsets.all(2),
                        //     // Button color
                        //     backgroundColor: filter,
                        //     // Splash color
                        //     foregroundColor: Colors.cyan,
                        //   ),
                        //   // icon of the button
                        //   child: SvgPicture.asset(
                        //     "assets/icons/filter.svg",
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  GridView.extent(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(2),
                    childAspectRatio: 0.60,
                    maxCrossAxisExtent: 300,
                    cacheExtent: 10,
                    children: List.generate(
                      provider.items.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(3),
                        child: ProductCard(
                          title: provider.items[index].name,
                          image: provider.items[index].smallImage.url,
                          price: provider.items[index].typename ==
                                  "SimpleProduct"
                              ? provider.items[index].priceRange.minimumPrice
                                  .regularPrice.value
                                  .toString()
                              : "${provider.items[index].priceRange.minimumPrice.regularPrice.value}"
                                  " - ${provider.items[index].priceRange.minimumPrice.regularPrice.value}",
                          product: provider.items[index],
                          bgColor: demo_product[0].colors[0],
                          item: provider.items[index],
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                      product: provider.pList[index]['sku']),
                                ));

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) =>
                            //           DetailsPage(product: provider.pList[index]),
                            //     ));
                          },
                        ),
                      ),
                    ),
                  ),

                  /*Expanded(
                      child: GridView.builder(
                          primary: false,
                          itemCount: pList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0,
                              childAspectRatio: 2 / 3),
                          padding: const EdgeInsets.all(2),
                          itemBuilder:  (BuildContext ctx, i) {
                            return Padding(
                              padding: const EdgeInsets.only(right: defaultPadding),
                              child: ProductCard(
                                title: provider.pList[i]['name'],
                                image: provider.pList[i]['small_image']['url'],
                                price: provider.pList[i]['__typename'] ==
                                    "SimpleProduct"
                                    ? provider.pList[i]['price_range']
                                ['minimum_price']['regular_price']['value']
                                    .toString()
                                    : "${provider.pList[i]['price_range']['minimum_price']['regular_price']['value']}"
                                    " - ${provider.pList[i]['price_range']['minimum_price']['regular_price']['value']}",
                                product: provider.pList[i],
                                bgColor: demo_product[0].colors[0],
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                            product: provider.pList[i]),
                                      ));
                                },
                              ),
                            );
                          }
                      ),
                    )*/
                ],
              ),
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

    // Parse the hexadecimal values and construct the Color object.
    return Color(int.parse('FF$hexColor', radix: 16));
  }
}
