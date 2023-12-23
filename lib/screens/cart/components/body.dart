import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/models/CartModel.dart';

import '../../../components/size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  final CartModel cartModel;
  const Body( {super.key, required this.cartModel});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.only(bottom: 5),

      child: Padding(
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
                  child: CartCard(item: widget.cartModel.cart!.items![index])),
            ),
          )),
    );
  }
}
