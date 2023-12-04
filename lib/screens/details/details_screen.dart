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

  final String product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
    GraphQLService graphQLService=GraphQLService();

   MyProvider? myProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     myProvider = Provider.of<MyProvider>(context, listen: false);

    getNavdata();
  }
  void getNavdata() async {


    print(widget.product);

    print('sku ->' + widget.product);

    myProvider!.updateProductDescriptionData(widget.product);

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
        builder: (context,provider,_){
          if(provider.productData != null){
            print(provider.productData);

            return Container(
              child:


              ProductDescription(
                product: provider.productData[0]['sku'],
                pressOnSeeMore: () {},
              )
            );

          }else{
           return Container();
          }

        },
    );
  }
}
