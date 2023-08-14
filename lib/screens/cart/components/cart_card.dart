import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Cart.dart';
import '../../../components/size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

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
      child: Row(
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
                    'https://www.omaliving.com/media/catalog/product/cache/0141941aeb4901c5334e6ba10ea3844d/I/T/ITEM-007993_3_1.png'),
              ),
            ),
          ),
          Expanded(
            child: buildProductInfo(),
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
          const Text(
            'Scheffera potted plant',
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              const Expanded(
                // Place `Expanded` inside `Row`
                child: SizedBox(
                  height: 15, // <-- Your height
                  child: Text(
                    '₹ 1,298',
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
                          onTap: () {},
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
                          child: const Text('2'),
                        ),
                        InkWell(
                          onTap: () {},
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
          const Row(
            children: <Widget>[
              Expanded(
                // Place `Expanded` inside `Row`
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
              SizedBox(
                width: 10.0,
                height: 0,
              ),
              Row(
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
                    style: TextStyle(color: headingColor, fontSize: 13,fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
