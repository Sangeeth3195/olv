import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omaliving/models/CustomerModel.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

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
  List<dynamic> wishList = [];

  GraphQLService graphQLService = GraphQLService();
  MyProvider? myProvider;


  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    myProvider = Provider.of<MyProvider>(context, listen: false);

    myProvider!.getuserdata();
    myProvider!.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, _) {
        return (myProvider!.customerModel.customer == null ||
            myProvider!.customerModel.customer!.wishlist == null ||
            myProvider!.customerModel.customer!.wishlist!.items == null)
            ? const Center(child: CircularProgressIndicator())
            : Container(
          margin:
          const EdgeInsets.only(bottom: 55, left: 5, right: 5, top: 5),
          child: myProvider!.customerModel.customer!.wishlist!.items!.isEmpty?            Center(
        child: Text('You have no items in your Cart.'),
        ):
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.8),
            itemBuilder: (context, position) {
              return gridItem(context, position,
                  myProvider!.customerModel.customer!.wishlist!.items![position]);
            },
            itemCount: myProvider!.customerModel.customer!.wishlist!.items!.length,
          ),
        );

      },
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
                              image: NetworkImage(myProvider!.customerModel
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
                                print(myProvider!.customerModel
                                    .customer!.wishlist!.items![position].id
                                    .toString());

                                dynamic listData = await graphQLService
                                    .remove_Product_from_wishlist(
                                        wishlistId: myProvider!.customerModel.customer!.wishlists![0].id!,
                                        wishlistItemsIds: myProvider!.customerModel
                                            .customer!
                                            .wishlist!
                                            .items![position]
                                            .id
                                            .toString());
                                EasyLoading.show();
                                myProvider!.getuserdata();
                                EasyLoading.show();

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
                    myProvider!.customerModel.customer!.wishlist!.items![position].product!
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
                          "₹ ${myProvider!.customerModel.customer!.wishlist!.items![position].product!.priceRange!.minimumPrice!.regularPrice!.value.toString()}",
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
