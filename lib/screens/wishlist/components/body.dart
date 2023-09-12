import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omaliving/models/CustomerModel.dart';

import '../../../API Services/graphql_service.dart';
import '../../../components/size_config.dart';
import '../../../constants.dart';
import '../../../models/Cart.dart';
import '../../cart/components/cart_card.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GraphQLService graphQLService = GraphQLService();
  List<dynamic> wishList = [];
  CustomerModel customerModel = CustomerModel();

  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    EasyLoading.show(status: 'loading...');
    customerModel = await graphQLService.get_customer_details();
    print(customerModel.customer?.addresses?.length);
    print(customerModel.customer!.wishlist!.items!.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (customerModel.customer == null ||
            customerModel.customer!.wishlist == null ||
            customerModel.customer!.wishlist!.items == null)
        ? const Center(child: CircularProgressIndicator())
        : Container(
            margin:
                const EdgeInsets.only(bottom: 55, left: 5, right: 5, top: 5),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.70),
              itemBuilder: (context, position) {
                return gridItem(context, position,
                    customerModel.customer!.wishlist!.items![position]);
              },
              itemCount: customerModel.customer!.wishlist!.items!.length,
            ),
          );
  }

  gridItem(BuildContext context, int position, wishList) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print(wishList);
        }
      },
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkResponse(
            onTap: () {},
            child: Material(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: 150.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Image(
                              image: NetworkImage(customerModel
                                  .customer!
                                  .wishlist!
                                  .items![position]
                                  .product!
                                  .mediaGallery![0]
                                  .url
                                  .toString()),
                              fit: BoxFit.contain,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (kDebugMode) {
                                print(customerModel
                                    .customer!.wishlist!.items![position].id
                                    .toString());

                                dynamic listData = await graphQLService
                                    .remove_Product_from_wishlist(
                                        wishlistId: "377",
                                        wishlistItemsIds: customerModel
                                            .customer!
                                            .wishlist!
                                            .items![position]
                                            .id
                                            .toString());
                              }
                            },
                            child: const Icon(
                              Icons.favorite,
                              color: Color(0xFFF4597D),
                              size: 22.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    customerModel.customer!.wishlist!.items![position].product!
                            .name ??
                        '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          "₹ ${customerModel.customer!.wishlist!.items![position].product!.priceRange!.minimumPrice!.regularPrice!.value.toString()}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14.0),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
          )),
    );
  }
}
