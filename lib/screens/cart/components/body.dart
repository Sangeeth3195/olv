import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/models/CartModel.dart';

import '../../../components/size_config.dart';
import '../../../constants.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  final CartModel cartModel;
  final bool isFromActionBar;
  const Body( {super.key, required this.cartModel, required this.isFromActionBar});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.cartModel.cart!.items!.length,
                  itemBuilder: (context, index) =>  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: InkWell(
                        onTap: (){
                          context.go('/cart/pdp',extra: widget.cartModel.cart!.items![index].product!.sku.toString());
                        },
                        child: CartCard(item: widget.cartModel.cart!.items![index],isFromActionBar: widget.isFromActionBar,)),
                  ),
                ),
              )),
          widget.isFromActionBar?Column(
            children: [
              Divider(),
              // SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      // Place `Expanded` inside `Row`
                      child: Text(
                        'Subtotal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: headingColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22, // <-- Your height
                      child: Padding(
                        padding:  EdgeInsets.only(left: 10, right: 10),
                        child: Row(children: [
                          Text(
                              '₹ ${widget.cartModel.cart!.prices!.subtotalExcludingTax!.value.toString()}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: headingColor,
                              )                        ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ):Container(),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
