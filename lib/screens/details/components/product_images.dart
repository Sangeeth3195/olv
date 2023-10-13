import 'package:flutter/material.dart';
import '../../../constants.dart';

import '../../../models/Product_detail.dart';
import '../../../components/size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product, required this.isConfigurableProduct, required this.configurableProductIndex,
  }) : super(key: key);

  final dynamic product;
  final bool isConfigurableProduct;
  final int configurableProductIndex;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product[0]['id'].toString(),
              child: widget.product[0]['media_gallery'].length == 0?Image.asset('assets/images/placeholder.png'):Image.network(widget.isConfigurableProduct?widget.product[0]['variants'][widget.configurableProductIndex]['product']['media_gallery'][selectedImage]['url']:widget.product[0]['media_gallery'][selectedImage]['url']),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              ...List.generate(widget.isConfigurableProduct?widget.product[0]['variants'][widget.configurableProductIndex]['product']['media_gallery'].length:widget.product[0]['media_gallery'].length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(0),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(widget.isConfigurableProduct?widget.product[0]['variants'][widget.configurableProductIndex]['product']['media_gallery'][index]['url']:widget.product[0]['media_gallery'][index]['url']),
      ),
    );
  }
}
