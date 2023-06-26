import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omaliving/models/Product_detail.dart';

import '../../../constants.dart';
import '../../../components/size_config.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final ProductDetail product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  int quantity = 0;

  void incrementQuantity() {
    quantity++;
    setState(() {

    });
  }

  void decrementQuantity() {
    if (quantity > 0) {
      quantity--;
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: Text(
            widget.product.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: blackColor),
          ),
        ),

        const SizedBox(height: 16,),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: Text(
            "₹ "+widget.product.price.toStringAsFixed(2),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: blackColor),
          ),
        ),

        const SizedBox(height: 16,),
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: Text(
            'OVERVIEW',
            style: Theme.of(context).textTheme.headline6!.copyWith(color: headingColor),
          ),
        ),
        const SizedBox(height: 8,),


        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(10),
            right: getProportionateScreenWidth(10),
          ),
          child: Text(
            widget.product.description,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(color: headingColor),

          ),
        ),
        const SizedBox(height: 32,),

        Row(
          children: [
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
              child: Text(
                'SIZE',
                style: Theme.of(context).textTheme.headline6!.copyWith(color: headingColor),
              ),
            ),
            const SizedBox(width: 16,),
            Column(
              children: [
                Chip(
                  backgroundColor: chipColor,
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('8.66 "',style: TextStyle(color: Colors.white),),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0), // Adjust the border radius for rectangle shape
                    side: const BorderSide(color: omaColor,),
                  ),
                ),
                Chip(
                  backgroundColor: chip2Color,

                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('4.57 "'),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0), // Adjust the border radius for rectangle shape
                    side: const BorderSide(color: omaColor),
                  ),
                ),
                // Add more chips as needed
              ],
            ),
          ],
        ),
        const SizedBox(height: 32,),

        Row(
          children: [
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
              child: Text(
                'QUANTITY',
                style: Theme.of(context).textTheme.headline6!.copyWith(color: headingColor),
              ),
            ),
            const SizedBox(width: 16,),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 4), // Adjust padding as needed
              decoration: BoxDecoration(
                color: omaColor,
                border: Border.all(
                  color: headingColor, // Border color
                  width: 0.0, // Border width
                ),
                borderRadius: BorderRadius.circular(0.0), // Adjust border radius as needed
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    child: IconButton(
                      icon: const Icon(Icons.remove,color: headingColor,),
                      onPressed: () {
                        decrementQuantity();
                      },
                    ),
                  ),
                  Container(
                    height: 40,

                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 12), // Adjust padding as needed
                    decoration: BoxDecoration(
                      color: Colors.white,

                      border: Border.all(
                        color: headingColor, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(0.0), // Adjust border radius as needed
                    ),
                    child: Text(
                      quantity.toString(),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    height: 40,

                    child: IconButton(
                      icon: const Icon(Icons.add,color: headingColor,),
                      onPressed: () {
                        incrementQuantity();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32,),
        Container(
          width: double.infinity, // Set the container width to occupy the full width
          margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 4), // Adjust margins as needed
          child: ElevatedButton(
            onPressed: () {
              // Button onPressed action
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              primary: headingColor, // Set the background color
            ),
            child: const Text(
              'ADD TO CART',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
        Container(
          width: double.infinity, // Set the container width to occupy the full width
          margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 4), // Adjust margins as needed
          child: ElevatedButton(
            onPressed: () {
              // Button onPressed action
            },
            style: ElevatedButton.styleFrom(

              side: const BorderSide(color: headingColor),
              padding: const EdgeInsets.all(10),

              primary: Colors.white, // Set the background color
            ),
            child: const Text(
              'ADD TO WATCHLIST',
              style: TextStyle(fontSize: 15,color: headingColor),
            ),
          ),
        ),
        const SizedBox(height: 8,),

      ],
    );
  }
}
