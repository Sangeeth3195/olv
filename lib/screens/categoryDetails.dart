import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/models/ProductListJson.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import 'product_listing/components/product_card.dart';

class CategoryDetails extends StatefulWidget {
  final Map<String,dynamic> data;
  const CategoryDetails({super.key, required this.data});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(jsonEncode(widget.data));
  }
  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 5),
                child: Text(
                  widget.data['name'],
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: headingColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            ],
          ),
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: ListView.builder(

            itemCount: widget.data['children'].length,
            itemBuilder: (context,index){

              return   Container(
                height: 250,
                width: 200,
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: backgroundCategoryColor,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(defaultBorderRadius)),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(widget.data['children'][index]['image']??'https://www.omaliving.com/media/.renditions/catalog/category/category_thumbnail/RI006960_3.png',
                        height: 100,width: 100,),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          dynamic catId = widget.data['children'][index]['id'];
                          final myProvider =
                          Provider.of<MyProvider>(context,
                              listen: false);
                          myProvider.updateData(catId);
                          myProvider.updateHeader(
                              widget.data['children'][index]['name']);
                          myProvider.isproduct = true;
                          myProvider.notifyListeners();
                          context.go('/home/pdp');
                        },
                        child: Text(
                          widget.data['children'][index]['name'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: headingColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              );
            },
            scrollDirection: Axis.horizontal,

          ),
        ),
        ListView.builder(
           itemCount: widget.data['children'].length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),

          itemBuilder: (context,parentIndex){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 5),
                  child: Text(
                    widget.data['children'][parentIndex]['name'],
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: headingColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();


                   dynamic catId = widget.data['children'][parentIndex]['id'];
                    final myProvider =
                        Provider.of<MyProvider>(context,
                            listen: false);
                    myProvider.updateData(catId);
                    myProvider.updateHeader(
                        widget.data['children'][parentIndex]['name']);
                    myProvider.isproduct = true;
                    myProvider.notifyListeners();
                    context.go('/home/pdp');

                    // Navigator.of(context, rootNavigator: true).pushNamed("/productlisting", arguments: catId);
                  },

                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 5),
                    child: Text(
                      "Shop All ("+widget.data['children'][parentIndex]['products']['total_count'].toString()+")",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: headingColor,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,

                      ),
                    ),
                  ),
                ),
                GridView.extent(
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(2),
                  childAspectRatio: 0.60,
                  maxCrossAxisExtent: 300,
                  children: List.generate(
                    widget.data['children'][parentIndex]['products']['items'].length,
                        (index) => Padding(
                      padding: const EdgeInsets.all(3),
                      child: ProductCard(
                        title: widget.data['children'][parentIndex]['products']['items'][index]['name'],
                        image: widget.data['children'][parentIndex]['products']['items'][index]['small_image']['url'],
                        price: widget.data['children'][parentIndex]['products']['items'][index]['typename'] == "SimpleProduct"
                            ? widget.data['children'][parentIndex]['products']['items'][index]['price_range']['minimum_price']
                        ['regular_price']['value']
                            .toString()
                            : "${widget.data['children'][parentIndex]['products']['items'][index]['price_range']['minimum_price']
                        ['regular_price']['value']}"
                            " - ${widget.data['children'][parentIndex]['products']['items'][index]['price_range']['minimum_price']
                        ['regular_price']['value']}",
                        product: widget.data['children'][parentIndex]['products']['items'][index],
                        bgColor: demo_product[0].colors[0],
                        item: Item.fromJson(widget.data['children'][parentIndex]['products']['items'][index]),
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    product: widget.data['children'][parentIndex]['products']['items'][index]['sku']),
                              ));

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           DetailsPage(product: provider.pList[index]),
                          //     ));
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin:EdgeInsets.all(12),
                  child: SizedBox(
                    width:MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();


                        dynamic catId = widget.data['children'][parentIndex]['id'];
                        final myProvider =
                        Provider.of<MyProvider>(context,
                            listen: false);
                        myProvider.updateData(catId);
                        myProvider.updateHeader(
                            widget.data['children'][parentIndex]['name']);
                        myProvider.isproduct = true;
                        myProvider.notifyListeners();
                        context.go('/home/pdp');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5),
                        primary: headingColor, // Set the background color
                      ),
                      child:  Text(
                        "Shop All ("+widget.data['children'][parentIndex]['products']['total_count'].toString()+")",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),

      ],
    );
  }
}
