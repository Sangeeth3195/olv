import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../../API Services/graphql_service.dart';
import '../../../constants.dart';
import '../../../models/Product.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<dynamic> wishList = [];

  GraphQLService graphQLService = GraphQLService();
  MyProvider? myProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider!.getuserdata();
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
                    const EdgeInsets.only(bottom: 0, left: 5, right: 5, top: 5),
                child:
                    myProvider!.customerModel.customer!.wishlist!.items!.isEmpty
                        ? const Center(
                            child: Text(
                              'You have no items in your wishlist',
                              style: TextStyle(
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.black),
                            ),
                          )
                        : GridView.extent(
                            primary: false,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(2),
                            childAspectRatio: 0.70,
                            maxCrossAxisExtent: 300,
                            children: List.generate(
                              myProvider!.customerModel.customer!.wishlist!
                                  .items!.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(3),
                                child: ProductCard(
                                  title: myProvider!.customerModel.customer!
                                      .wishlist!.items![index].product!.name
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
                                  price: myProvider!
                                      .customerModel
                                      .customer!
                                      .wishlist!
                                      .items![index]
                                      .product!
                                      .priceRange!
                                      .minimumPrice!
                                      .regularPrice!
                                      .value
                                      .toString(),
                                  price1: myProvider!
                                      .customerModel
                                      .customer!
                                      .wishlist!
                                      .items![index]
                                      .product!
                                      .textAttributes![0]
                                      .specicalprice
                                      .toString(),
                                  spl_to_date: myProvider!
                                      .customerModel
                                      .customer!
                                      .wishlist!
                                      .items![index]
                                      .product!
                                      .special_to_date
                                      .toString(),
                                  product: '',
                                  ids: myProvider!.customerModel.customer!
                                      .wishlist!.items![index].id!,
                                  dy_val: myProvider!
                                      .customerModel
                                      .customer!
                                      .wishlist!
                                      .items![index]
                                      .product!
                                      .dynamicAttributes![0]
                                      .attributeValue
                                      .toString(),
                                  bgColor: demo_product[0].colors[0],
                                  press: () {
                                    context.go("/wishlist/pdp",
                                        extra: myProvider!
                                            .customerModel
                                            .customer!
                                            .wishlist!
                                            .items![index]
                                            .product!
                                            .sku!
                                            .toString());
                                  },
                                ),
                              ),
                            ),
                          ),
              );
      },
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.price1,
    required this.spl_to_date,
    required this.press,
    required this.bgColor,
    this.product,
    required this.ids,
    required this.dy_val,
  }) : super(key: key);
  final String image, title;
  final VoidCallback press;
  final String price;
  final String price1;
  final String spl_to_date;
  final Color bgColor;
  final dynamic product;
  final int ids;
  final String dy_val;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  GraphQLService graphQLService = GraphQLService();

  int wishlist = 0;

  String cart_token = '';
  MyProvider? myProvider;
  String? wishListID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myProvider = Provider.of<MyProvider>(context, listen: false);

    print('spl_to_date');
    print(widget.spl_to_date);

    DateTime dt1 = DateTime.parse("2021-12-23 11:47:00");
    DateTime dt2 = DateTime.parse("2018-02-27 10:09:00");
    DateTime date = DateTime.now();

    print(date);

    if(dt1.compareTo(dt2) == 0){
      print("Both date time are at same moment.");
    }

    if(dt1.compareTo(dt2) < 0){
      print("DT1 is before DT2");
    }

    if(dt1.compareTo(dt2) > 0){
      print("DT1 is after DT2");
    }

    if(dt1.compareTo(date) > 0){
      print("DT1 is after DT332");
    }

    /*DateTime dt1 = DateTime.parse(widget.spl_to_date);
    DateTime dt2 = DateTime.parse("2018-02-27 10:09:00");
    DateTime date =DateTime.now();

    // if(widget.spl_to_date)
    if(dt1.isBefore(date)){
      print("DT1 is before DT2");
    }else {
      print("DT1 is else DT2");
    }*/

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
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/omalogo.png',
                        height: 150,
                      );
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
                            fontSize: 11),
                      ),
                    ),
                    const SizedBox(height: 0.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            height: 1.5,
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: widget.price.isEmpty
                          ? Text(
                              "₹${widget.price}",
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black),
                            )
                          : Text(
                              "₹${widget.price}",
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black),
                            ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: widget.price.isEmpty
                          ? Text(
                        widget.price1,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black),
                      )
                          : Text(
                        widget.price1,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
                top: 0,
                right: 5,
                child: InkWell(
                  onTap: () async {
                    dynamic listData =
                        await graphQLService.remove_Product_from_wishlist(
                            wishlistId: myProvider!
                                .customerModel.customer!.wishlists![0].id!,
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
