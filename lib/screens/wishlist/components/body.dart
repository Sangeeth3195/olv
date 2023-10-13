import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omaliving/models/CustomerModel.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../../API Services/graphql_service.dart';
import '../../../components/size_config.dart';
import '../../../constants.dart';
import '../../../models/Cart.dart';
import '../../../models/Product.dart';
import '../../cart/components/cart_card.dart';
import '../../details/details_screen.dart';
import '../../product_listing/components/product_card.dart';

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
                margin: const EdgeInsets.only(
                    bottom: 55, left: 5, right: 5, top: 5),
                child:
                    myProvider!.customerModel.customer!.wishlist!.items!.isEmpty
                        ? const Center(
                            child: Text('You have no items in your wishlist'),
                          )
                        :
                    GridView.extent(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(2),
                      childAspectRatio: 0.75,
                      maxCrossAxisExtent: 300,
                      children: List.generate(
                          myProvider!.customerModel.customer!
                              .wishlist!.items!.length,
                            (index) => Padding(
                          padding: const EdgeInsets.all(3),
                          child: ProductCard(
                            title: myProvider!
                                .customerModel
                                .customer!
                                .wishlist!
                                .items![index]
                                .product!
                                .name
                                .toString(),
                            image: myProvider!
                                .customerModel
                                .customer!
                                .wishlist!
                                .items![index]
                                .product!
                                .mediaGallery![0]
                                .url
                                .toString(),
                            price: myProvider!.customerModel.customer!.wishlist!.items![index].product!.priceRange!.minimumPrice!.regularPrice!.value.toString(),
                            product: '',
                            ids :  myProvider!.customerModel.customer!.wishlist!.items![index].id!,
                            dy_val :  myProvider!.customerModel.customer!.wishlist!.items![index].product!.dynamicAttributes![0].attributeValue.toString(),
                            bgColor: demo_product[0].colors[0],
                            press: () {

                            },
                          ),
                        ),
                      ),
                    ),

                    /*GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 0.7),
                            itemBuilder: (context, position) {
                              return gridItem(
                                  context,
                                  position,
                                  myProvider!.customerModel.customer!.wishlist!
                                      .items![position]);
                            },
                            itemCount: myProvider!.customerModel.customer!
                                .wishlist!.items!.length,
                          ),*/
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
            onTap: () {
              print(myProvider!.customerModel.customer!.wishlist!
                  .items![position].product!.sku);

              String? vxc = myProvider!.customerModel.customer!.wishlist!
                  .items![position].product!.sku;
            },
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
                              image: NetworkImage(myProvider!
                                  .customerModel
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
                                print(myProvider!.customerModel.customer!
                                    .wishlist!.items![position].id
                                    .toString());

                                dynamic listData = await graphQLService
                                    .remove_Product_from_wishlist(
                                        wishlistId: myProvider!.customerModel
                                            .customer!.wishlists![0].id!,
                                        wishlistItemsIds: myProvider!
                                            .customerModel
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
                    myProvider!.customerModel.customer!.wishlist!
                            .items![position].product!.name ??
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


class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.press,
    required this.bgColor,
    this.product,
    required this.ids,
    required this.dy_val,
  }) : super(key: key);
  final String image, title;
  final VoidCallback press;
  final String price;
  final Color bgColor;
  final dynamic product;
  final int ids;
  final String dy_val;


  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  GraphQLService graphQLService = GraphQLService();

  int wishlist=0;

  String cart_token = '';
  int _selected = 0;
  MyProvider? myProvider;
  String? wishListID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myProvider = Provider.of<MyProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child:
        /*Card(
          elevation: 0,
          child:*/
        Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.bgColor,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(defaultBorderRadius)),
                  ),
                  child: Image.network(
                    widget.image,
                    height: 150,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset('assets/omalogo.png',height: 150,);
                    },
                  ),
                ),
                const SizedBox(height: 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text(
                        widget.dy_val.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            height: 1.5,
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            height: 1.5,
                            fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: widget.price.isEmpty
                          ? Text("₹${widget.price}",style: const TextStyle(fontSize: 15,color: Colors.black),)
                          : Text("₹${widget.price}",style: const TextStyle(fontSize: 15,color: Colors.black),),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
                top: 0,
                right: 5,
                child: InkWell(
                  onTap: () async{

                    print(widget.title);

                    print(widget.ids.toString());
                    dynamic listData = await graphQLService
                        .remove_Product_from_wishlist(
                        wishlistId: myProvider!.customerModel
                            .customer!.wishlists![0].id!,
                        wishlistItemsIds: widget.ids.toString());
                    EasyLoading.show();
                    myProvider!.getuserdata();
                    EasyLoading.show();

                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 6),
                    child: Icon(
                     Icons.favorite,
                      color: Color(0xFFF4597D),
                      size: 22,
                    ),
                  ),
                )),
          ],
        ),
        /*),*/
      ),
    );
  }
}