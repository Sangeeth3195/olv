import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:omaliving/LoginPage.dart';
import 'package:omaliving/models/CartModel.dart';
import 'package:omaliving/screens/cart/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../models/Cart.dart';
import '../../../components/size_config.dart';
import '../../checkout/Checkout.dart';
import '../../provider/provider.dart';

class CartCard extends StatefulWidget {
  final Item item;
  CartCard({super.key, required this.item});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<CartCard> {
  CartProvider? cartProvider;
  int quantity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavdata();
  }

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

  void getNavdata() async {
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    quantity=widget.item.quantity!;
    setState(() {

    });
  }

  Widget showWidget(int qty) {
    if (qty == 0) {
      return TextButton(
        child: const Text(
          'Add Item',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        onPressed: () {},
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(
              Icons.remove,
              color: blackColor,
            ),
            onPressed: () {},
          ),
          const Text('14'),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.black54,
            ),
            onPressed: () {},
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                child: AspectRatio(
                  aspectRatio: 0.80,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.network(
                        widget.item.product!.mediaGallery![0].url??'',
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Image.asset('assets/omalogo.png',height: 150,);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: buildProductInfo(),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Padding buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Text(
            widget.item.product!.name??'',
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
               Expanded(
                // Place `Expanded` inside `Row`
                child: SizedBox(
                  height: 15, // <-- Your height
                  child: Text(
                    '₹ ${widget.item.product!.priceRange!.minimumPrice!.regularPrice!.value.toString()}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: SizedBox(
                    height: 30, // <-- Your height
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(children: [
                        InkWell(
                          onTap: () {
                            decrementQuantity();
                            cartProvider!.updateItem(widget.item!.product!.uid!, quantity);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            child: const Text('-'),
                          ),
                        ),
                        Container(
                          width: 20,
                          alignment: Alignment.center,
                          child:  Text(widget.item.quantity!.toString()),
                        ),
                        InkWell(
                          onTap: () {
                            incrementQuantity();
                            cartProvider!.updateItem(widget.item!.product!.sku!, quantity);

                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            child: const Text('+'),
                          ),
                        ),
                      ]),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
           Row(
            children: <Widget>[
              Expanded(
                // Place `Expanded` inside `Row`
                child: GestureDetector(
                  onTap:() async{

                    SharedPreferences prefs = await SharedPreferences.getInstance();

                    var token = prefs.getString('token') ?? '';

                    if (token.isEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    } else {
                      cartProvider!.removeItem(widget.item!.id!);
                      cartProvider!.addToWishList(sku: widget.item!.product!.sku!, qty: widget.item!.quantity!.toString());

                    }
                    },
                  child: Row(
                    children: [
                      Text(
                        'Move to wishlist |',
                        style: TextStyle(color: headingColor, fontSize: 13),
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: 14,
                        color: headingColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
                height: 0,
              ),
              GestureDetector(
                onTap: (){
                  cartProvider!.removeItem(widget.item!.id!);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: headingColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Remove',
                      style: TextStyle(
                          color: headingColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
