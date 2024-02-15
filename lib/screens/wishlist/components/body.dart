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
                            childAspectRatio: 0.65,
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
                                  sku: myProvider!.customerModel.customer!
                                      .wishlist!.items![index].product!.sku!
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
                                      .specicalprice,
                                  spl_to_date: myProvider!
                                      .customerModel
                                      .customer!
                                      .wishlist!
                                      .items![index]
                                      .product!
                                      .special_to_date,
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
    required this.sku,
    required this.price,
    required this.price1,
    required this.spl_to_date,
    required this.press,
    required this.bgColor,
    this.product,
    required this.ids,
    required this.dy_val,
  }) : super(key: key);
  final String image, title, sku;
  final VoidCallback press;
  final String price;
  final String? price1;
  final String? spl_to_date;
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
  String price ="0";
  bool isExpired = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myProvider = Provider.of<MyProvider>(context, listen: false);

    calculatePrice();

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

  void calculatePrice(){

    DateTime dt1;
    print(widget.spl_to_date);

    if(widget.spl_to_date !=null){
      dt1 = DateTime.parse(widget.spl_to_date??'');
    }else {
      dt1 = DateTime.parse("2099-02-27 10:09:00");
    }

    DateTime date = DateTime.now();

    print(date);

    DateTime currentDate = DateTime.now();

    // Check if the current date is after the expiration date
    isExpired = currentDate.isAfter(dt1);
    print("isExoired"+isExpired.toString());

    if(widget.spl_to_date == null){
      price = widget.price1??'';
    } else if(isExpired){
      price = widget.price1??'';
    } else if (widget.price1 == null){
      price = widget.price;
    }

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
                    isExpired? Padding(
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
                    ): Padding(
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
                            fontSize: 13, color: Colors.black,decoration:TextDecoration.lineThrough ),
                      ),
                    ),
                    isExpired?Container():Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text(
                              price,
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black)
                            ),
                    ),
                    const SizedBox(height: 5.0),
                    GestureDetector(
                      onTap: () async {
                        EasyLoading.show(status: 'loading...');

                        print(widget.sku.toString());
                        graphQLService.addProductToCart(
                            widget.sku.toString(), '1',
                            context: context);

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
                        padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: headingColor,
                              height: 1.5,
                              fontSize: 12),
                        ),
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
