import 'package:flutter/material.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/Product_detail.dart';
import 'package:omaliving/screens/product_listing/components/search_form.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  final Map<String, dynamic> product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  GraphQLService graphQLService=GraphQLService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavdata();
  }
  void getNavdata() async {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    myProvider.updateProductDescriptionData(widget.product['sku']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MyProvider>(
        builder: (context,provider,_){
          if(provider.productData != null){
            return  Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Container(
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: searchBackgroundColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: const SearchForm(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProductImages(product: provider.productData),
                  TopRoundedContainer(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ProductDescription(
                          product: widget.product,
                          pressOnSeeMore: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );

          }else{
           return CircularProgressIndicator();
          }

        },
      ),
    );
  }
}
