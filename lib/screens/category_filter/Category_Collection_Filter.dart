import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/CollectionModel.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../API Services/Constant.dart';
import '../Product_listing_PLP/Product_Listing_PLP.dart';

class Category_Collection_Filter extends StatefulWidget {
  final Map<String, dynamic> data;

  const Category_Collection_Filter({Key? key, required this.data})
      : super(key: key);
  static const String routeName = "/home_screen";

  @override
  State<Category_Collection_Filter> createState() =>
      _HomeScreenState(this.data);
}

class _HomeScreenState extends State<Category_Collection_Filter> {
  final Map<String, dynamic> data;
  _HomeScreenState(this.data);
  GraphQLService graphQLService = GraphQLService();
  CollectionModel collectionmdl = CollectionModel();

  String? title_text ='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavdata();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void getNavdata() async {
    print(widget.data['name']);

    if(widget.data['name'] != null || widget.data['name'] == '' ){

      print('widget');
      print(widget.data);

      title_text = widget.data['name'];

      collectionmdl = await graphQLService
          .get_cat_collection(widget.data['name']);
    }else{

      title_text = widget.data['children'][0]['name'];
      collectionmdl = await graphQLService
        .get_cat_collection(widget.data['children'][0]['name']);

    }


    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    title_text ?? '',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        color: navTextColor),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                (collectionmdl.getCollectionSetData == null ||
                        collectionmdl.getCollectionSetData![0].collections! ==
                            null)
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        margin: const EdgeInsets.only(
                            bottom: 0, left: 5, right: 5, top: 5),
                        child: collectionmdl
                                .getCollectionSetData![0].collections!.isEmpty
                            ? const Center(
                                child: Text(
                                  'You have no items in your Collection',
                                  style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      color: Colors.black),
                                ),
                              )
                            : GridView.extent(
                                primary: false,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(2),
                                childAspectRatio: 0.65,
                                maxCrossAxisExtent: 300,
                                cacheExtent: 10,
                                children: List.generate(
                                  collectionmdl.getCollectionSetData![0]
                                      .collections!.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: ProductCard(
                                      title: collectionmdl
                                          .getCollectionSetData![0]
                                          .collections![index]
                                          .name!,
                                      id: collectionmdl.getCollectionSetData![0]
                                          .collections![index].brandOptionId!,
                                      brand_id: collectionmdl
                                          .getCollectionSetData![0]
                                          .collections![index]
                                          .optionId!,
                                      sub_title: collectionmdl
                                              .getCollectionSetData![0]
                                              .collections![index]
                                              .brandName!
                                              .isEmpty
                                          ? ''
                                          : collectionmdl
                                              .getCollectionSetData![0]
                                              .collections![index]
                                              .brandName!
                                              .toUpperCase(),
                                      image:
                                          '${Urls.BASE_URL_Prod}${collectionmdl.getCollectionSetData![0].collections![index].image}',
                                    ),

                                    /*  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 0.0, 0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => Product_Listing_PLP(
                                                        name: collectionmdl
                                                            .getCollectionSetData![
                                                                0]
                                                            .collections![index]
                                                            .name!,
                                                        id: collectionmdl
                                                            .getCollectionSetData![
                                                                0]
                                                            .collections![index]
                                                            .brandOptionId!,
                                                        id1: collectionmdl
                                                            .getCollectionSetData![
                                                                0]
                                                            .collections![index]
                                                            .optionId!),
                                                  ));
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    demo_product[0].colors[0],
                                                borderRadius: const BorderRadius
                                                    .all(Radius.circular(
                                                        defaultBorderRadius)),
                                              ),
                                              child: Image.network(
                                                "https://omaliving.com/media/wysiwyg/collection/${collectionmdl.getCollectionSetData![0].collections![index].image}" ??
                                                    '',
                                                height: 180,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return Image.asset(
                                                    'assets/omalogo.png',
                                                    height: 180,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5.0, 0, 0, 0),
                                              child: Text(
                                                collectionmdl
                                                    .getCollectionSetData![0]
                                                    .collections![index]
                                                    .brandName!.toUpperCase(),
                                                style: const TextStyle(
                                                    fontFamily: 'Gotham',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15.0,
                                                    color: navTextColor),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2.0,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5.0, 0, 0, 0),
                                              child: Text(
                                                collectionmdl
                                                    .getCollectionSetData![0]
                                                    .collections![index]
                                                    .name!,
                                                style: const TextStyle(
                                                    fontFamily: 'Gotham',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.0,
                                                    color: navTextColor),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),*/
                                  ),
                                ),
                              ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.id,
    required this.brand_id,
    required this.title,
    required this.sub_title,
  }) : super(key: key);
  final String image, title, sub_title;
  final int id, brand_id;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  GraphQLService graphQLService = GraphQLService();
  int wishlist = 0;
  String cart_token = '';
  MyProvider? myProvider;
  String? wishListID;
  String? image, title;
  String? brand_banner;
  String? price;
  Color? bgColor;
  String spl_price = "0";
  bool isExpired = true;
  bool isVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.title);
    print(widget.sub_title);

    if (widget.sub_title == '' || widget.sub_title == null) {
      setState(() {
        isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

       /* final Map<String, dynamic> someMap = {
          "id": getbrandslist[itemIndex]['option_id'],
          "name": getbrandslist[itemIndex]['name'],
        };
        print(someMap);
        context.go('/home/product_listing_brandlist',
            extra: someMap);*/

        if(widget.id == 0){

          print('object 1 ');
          final Map<String, dynamic> someMap = {
            "id": widget.brand_id,
            "name": widget.title,
          };
          print(someMap);
          context.go('/home/product_listing_brandlist',
              extra: someMap);
        }else {
          print('object 2');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Product_Listing_PLP(
                    name: widget.title, id: widget.id, id1: widget.brand_id),
              ));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(defaultBorderRadius)),
                  ),
                  child: Image.network(
                    widget.image ?? '',
                    height: 180,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/omalogo.png',
                        height: 150,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: isVisible,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Text(
                          widget.sub_title ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: textColor,
                              fontFamily: 'Gotham',
                              height: 1.5,
                              fontSize: 11),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                      child: Text(
                        widget.title ?? '',
                        style: const TextStyle(
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: navTextColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
