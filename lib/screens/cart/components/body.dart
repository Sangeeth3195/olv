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
    return Container(
      margin:  const EdgeInsets.only(bottom: 5),

      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.cartModel.cart!.items!.length,
                itemBuilder: (context, index) =>  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: InkWell(
                      onTap: (){
                        context.go('/cart/pdp',extra: widget.cartModel.cart!.items![index].product!.sku.toString());
                      },
                      child: CartCard(item: widget.cartModel.cart!.items![index],isFromActionBar: widget.isFromActionBar,)),
                ),
              )),
          Column(
            children: [
              Divider(),
              SizedBox(height: 5,),
              Row(
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
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
