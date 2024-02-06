import 'package:flutter/material.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/CollectionModel.dart';
import 'package:omaliving/models/Product.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

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
    collectionmdl = await graphQLService
        .get_cat_collection(widget.data['children'][0]['name']);
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
                    widget.data['children'][0]['name'] ?? '',
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
                        collectionmdl.getCollectionSetData![0].collections! == null)
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
                                childAspectRatio: 0.75,
                                maxCrossAxisExtent: 300,
                                cacheExtent: 10,
                                children: List.generate(
                                  collectionmdl.getCollectionSetData![0]
                                      .collections!.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Column(
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
                                        const SizedBox(height: 20),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5.0, 0, 0, 0),
                                              child: Center(
                                                child: Text(
                                                  collectionmdl
                                                      .getCollectionSetData![0]
                                                      .collections![index]
                                                      .name!,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontFamily: 'Gotham',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0,
                                                      color: navTextColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
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
