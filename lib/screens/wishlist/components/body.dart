import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  GraphQLService graphQLService = GraphQLService();
  List<dynamic> wishList = [];

  final List<String> imageList = [
    "https://staging2.omaliving.com/media/catalog/product/cache/e6afa270acd1ebb244ff9314a1640bb7/R/I/RI002927_3.png",
    "https://staging2.omaliving.com/media/catalog/product/cache/e6afa270acd1ebb244ff9314a1640bb7/R/I/RI004463_4.png",
    "https://staging2.omaliving.com/media/catalog/product/cache/e6afa270acd1ebb244ff9314a1640bb7/I/T/ITEM-007993_3_1.png",
    "https://staging2.omaliving.com/media/catalog/product/cache/e6afa270acd1ebb244ff9314a1640bb7/R/I/RI001805_3_1.png",
    "https://staging2.omaliving.com/media/catalog/product/cache/e6afa270acd1ebb244ff9314a1640bb7/R/I/RI002244_4_1.png",
    "https://staging2.omaliving.com/media/catalog/product/cache/e6afa270acd1ebb244ff9314a1640bb7/R/I/RI002839_2.png"
        "https://staging2.omaliving.com/media/catalog/product/cache/e6afa270acd1ebb244ff9314a1640bb7/R/I/RI004463_4.png",
    "https://staging2.omaliving.com/media/catalog/product/cache/e6afa270acd1ebb244ff9314a1640bb7/R/I/RI004463_4.png",
  ];

  void initState() {
    // TODO: implement initState
    super.initState();
    getwishlistdata();
  }

  void getwishlistdata() async {
    wishList = await graphQLService.getWishlist();
    setState(() {});

    print('wishList --> ${wishList.length}');

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.75),
        itemBuilder: (context, position) {
          return gridItem(context, position);
        },
        itemCount: wishList.length,
      ),
    );
  }

  gridItem(BuildContext context, int position) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.grey.shade200)),
        padding: const EdgeInsets.only(left: 5, top: 5),
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 5),
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Color(0xFFF4597D),
                  size: 24,
                ),
                onPressed: () {},
              ),
            ),
            Image(
              image: NetworkImage(imageList[position]),
              height: 150,
              fit: BoxFit.cover,
            ),
            gridBottomView()
          ],
        ),
      ),
    );
  }

  gridBottomView() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: const Text(
            "Scheffera potted plant",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "\₹ 2,595",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
