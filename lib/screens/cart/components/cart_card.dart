import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omaliving/LoginPage.dart';
import 'package:omaliving/models/CartModel.dart';
import 'package:omaliving/screens/cart/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../components/size_config.dart';

class CartCard extends StatefulWidget {
  final Item item;
  final bool isFromActionBar;
  const CartCard({super.key, required this.item, required this.isFromActionBar});

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
    setState(() {
      if (quantity > 0 && quantity != 1) {
        // will stop at 1
        quantity--;
      }
    });

    setState(() {});
  }

  void getNavdata() async {
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    quantity = widget.item.quantity!;
    setState(() {});
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
                      widget.item.product!.mediaGallery![0].url ?? '',
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/omalogo.png',
                          height: 150,
                        );
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
          const SizedBox(
            height: 12,
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
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.item.product!.dynamicAttributes![0].attributeValue!.toUpperCase(),
            style: const TextStyle(
                fontSize: 12, color: Colors.black45, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 0,
          ),
          Text(
            widget.item.product!.name ?? '',
            style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                height: 1.5,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w600),
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
                    style: const TextStyle(color: Colors.black,fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(
                width: 1.0,
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: SizedBox(
                    height: 25, // <-- Your height
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(children: [
                        InkWell(
                          onTap: () {
                            decrementQuantity();
                            cartProvider!
                                .updateItem(widget.item.uid!, quantity);
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
                          child: Text(widget.item.quantity!.toString()),
                        ),
                        InkWell(
                          onTap: () {
                            incrementQuantity();
                            cartProvider!
                                .updateItem(widget.item.uid!, quantity);
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
          /*widget.isFromActionBar?Container():*/Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              widget.isFromActionBar?Container():
                 GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    var token = prefs.getString('token') ?? '';

                    if (token.isEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    } else {
                      EasyLoading.show(status: 'loading...');
                      cartProvider!.removeItem(widget.item.id!);
                      cartProvider!.addToWishList(
                        sku: widget.item.product!.sku!,
                        qty: widget.item.quantity!.toString(),
                        // wishlistId:''
                      );
                    }
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Move to wishlist |',
                        style: TextStyle(color: headingColor, fontSize: 13),
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: 13,
                        color: headingColor,
                      ),
                    ],
                  ),
                ),

              const SizedBox(
                width: 10.0,
                height: 0,
              ),
              GestureDetector(
                onTap: () {
                  EasyLoading.show(status: 'loading...');
                  cartProvider!.removeItem(widget.item.id!);
                },
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_outline,
                      size: 16,
                      color: headingColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Remove',
                      style: TextStyle(
                          color: headingColor,
                          fontSize: 12,
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
