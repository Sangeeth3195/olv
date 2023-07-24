import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omaliving/models/Product_detail.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../../API Services/graphql_service.dart';
import '../../../constants.dart';
import '../../../components/size_config.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Map<String, dynamic> product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  int quantity = 0;

  GraphQLService graphQLService = GraphQLService();

  void incrementQuantity() {
    quantity++;
    setState(() {});
  }

  void decrementQuantity() {
    if (quantity > 0) {
      quantity--;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('name--> ' + widget.product['name']);
    getNavdata();
  }

  void getNavdata() async {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider.updateProductDescriptionData(widget.product['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: Text(widget.product['name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 18)),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: Text(
                  "₹ ${provider.productData.toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: headingColor,
                      fontSize: 15)),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: const Text('OVERVIEW',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: headingColor)),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(10),
                right: getProportionateScreenWidth(10),
              ),
              child: Text(
                  provider.productData['short_description'].toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: headingColor,
                      height: 1.3,
                      fontSize: 15)),
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10)),
                  child: const Text('SIZE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: headingColor)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Chip(
                      backgroundColor: chipColor,
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '8.66 "',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        // Adjust the border radius for rectangle shape
                        side: const BorderSide(
                          color: omaColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Chip(
                      backgroundColor: chip2Color,
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('4.57 "'),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        // Adjust the border radius for rectangle shape
                        side: const BorderSide(color: omaColor),
                      ),
                    ),
                    // Add more chips as needed
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10)),
                  child: const Text('QUANTITY',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: headingColor)),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: omaColor,
                    border: Border.all(
                      color: headingColor, // Border color
                      width: 0.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 34,
                        child: IconButton(
                          icon: const Icon(
                            Icons.remove,
                            color: headingColor,
                          ),
                          onPressed: () {
                            decrementQuantity();
                          },
                        ),
                      ),
                      Container(
                        height: 34,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 8), // Adjust padding as needed
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: headingColor, // Border color
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(
                              0.0), // Adjust border radius as needed
                        ),
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 34,
                        child: IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: headingColor,
                          ),
                          onPressed: () {
                            incrementQuantity();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double
                  .infinity, // Set the container width to occupy the full width
              margin: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 4), // Adjust margins as needed
              child: ElevatedButton(
                onPressed: () {
                  // Button onPressed action
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(5),
                  primary: headingColor, // Set the background color
                ),
                child: const Text(
                  'ADD TO CART',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Container(
              width: double
                  .infinity, // Set the container width to occupy the full width
              margin: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 4), // Adjust margins as needed
              child: ElevatedButton(
                onPressed: () {
                  // Button onPressed action
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: headingColor),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(5), // Set the background color
                ),
                child: const Text(
                  'ADD TO WATCHLIST',
                  style: TextStyle(fontSize: 14, color: headingColor),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        );
      },
    );
  }
}
