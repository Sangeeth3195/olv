import 'package:flutter/material.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/models/searchmodel.dart';
import 'package:omaliving/screens/details/details_screen.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(0)),
  borderSide: BorderSide(
    color: tileColor,
    width: 2.0,
  ),
);

class SearchForm extends StatefulWidget {
  const SearchForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  SearchModel searchModel = SearchModel();

  GraphQLService graphQLService = GraphQLService();

  Future<SearchModel> getData(value) async {
    searchModel = await graphQLService.productsearch_suggestion(value);
    return searchModel;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Form(
        child: AutocompleteBasicExample(),
      ),
    );

    return Card(
      elevation: 1,
      child: Form(
        child: Column(
          children: [
            TextFormField(
              onSaved: (value) {},
              onChanged: (txt) {
                if (txt.length > 1) {
                  getData(txt);
                  setState(() {});
                }
              },
              style: const TextStyle(fontSize: 16),
              autofocus: false,
              focusNode: FocusNode(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintStyle: const TextStyle(color: Colors.black),
                hintText: "what are you looking for",
                border: outlineInputBorder,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: outlineInputBorder,
                errorBorder: outlineInputBorder,
                suffixIcon: SizedBox(
                  width: 50,
                  child: IconButton(
                    onPressed: () {
                      print('search button pressed');
                    },
                    /*icon: SvgPicture.asset(
                          "assets/icons/Search.svg",
                          color: Colors.black,
                          height: 20,
                          width: 20,
                        ),*/
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),

                  /*Row(
                    children: [
                     */ /* IconButton(
                        onPressed: () {
                          print('mic button pressed');
                        },
                        icon: const Icon(Icons.mic,color: Colors.black,),
                      ),*/ /*
                      IconButton(
                        onPressed: () {
                          print('search button pressed');
                        },
                        */ /*icon: SvgPicture.asset(
                          "assets/icons/Search.svg",
                          color: Colors.black,
                          height: 20,
                          width: 20,
                        ),*/ /*
                        icon: const Icon(Icons.search,color: Colors.black,),
                      ),
                    ],
                  ),*/
                ),

                /*Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset("assets/icons/Search.svg",
                      color: Colors.black),
                ),*/
              ),
            ),
            searchModel.products == null
                ? Container()
                : ListView.builder(
                    itemCount: searchModel.products!.items!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 60,
                          child: ListTile(
                            tileColor: Colors.grey.withOpacity(0.5),
                            title: Text('Comment $index'),
                          ),
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }
}

class AutocompleteBasicExample extends StatefulWidget {
  const AutocompleteBasicExample({super.key});

  @override
  State<AutocompleteBasicExample> createState() =>
      _AutocompleteBasicExampleState();
}

class _AutocompleteBasicExampleState extends State<AutocompleteBasicExample> {
  String? _searchingWithQuery;

  // The most recent options received from the API.

  SearchModel searchModel = SearchModel();

  GraphQLService graphQLService = GraphQLService();
  late Iterable<SearchModel> _lastOptions = <SearchModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<SearchModel> getData(value) async {
    searchModel = await graphQLService.productsearch_suggestion(value);
    setState(() {});
    return searchModel;
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Item>(
      optionsViewBuilder: (context, onSelected, options) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              searchModel.products == null
                  ? Container(
                      height: 100,
                      child: Center(child: Text('No Data')),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: searchModel.products!.items!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 60,
                                child: Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    onTap: () {
                                      navToProductDeatils(searchModel
                                              .products!.items![index].sku ??
                                          '');
                                    },
                                    tileColor: Colors.white,
                                    title: Text(searchModel
                                            .products!.items![index].name ??
                                        ''),
                                    
                                    leading: Image.network(searchModel.products!
                                            .items![index].image!.url ??
                                        ''),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
            ],
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text == '') {
          return const Iterable<Item>.empty();
        }

        if (textEditingValue.text.length >= 3) {
          await getData(textEditingValue.text);
        }

        return searchModel.products!.items!.where((Item option) {
          return true;
        });
      },
      optionsMaxHeight: 100,
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(color: Colors.black),
            hintText: "what are you looking for",
            border: outlineInputBorder,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            focusedBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            suffixIcon: SizedBox(
              width: 50,
              child: IconButton(
                onPressed: () {
                  print('search button pressed');
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  final myProvider =
                      Provider.of<MyProvider>(context, listen: false);
                  myProvider.updateSearchData(textEditingController.text);
                  myProvider.updateHeader('search');
                  myProvider.isproduct = true;
                  myProvider.notifyListeners();
                  context.go('/home/pdp');

                  // Navigator.of(context).pop();
                },
                /*icon: SvgPicture.asset(
                          "assets/icons/Search.svg",
                          color: Colors.black,
                          height: 20,
                          width: 20,
                        ),*/
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),

              /*Row(
                    children: [
                     */ /* IconButton(
                        onPressed: () {
                          print('mic button pressed');
                        },
                        icon: const Icon(Icons.mic,color: Colors.black,),
                      ),*/ /*
                      IconButton(
                        onPressed: () {
                          print('search button pressed');
                        },
                        */ /*icon: SvgPicture.asset(
                          "assets/icons/Search.svg",
                          color: Colors.black,
                          height: 20,
                          width: 20,
                        ),*/ /*
                        icon: const Icon(Icons.search,color: Colors.black,),
                      ),
                    ],
                  ),*/
            ),

            /*Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset("assets/icons/Search.svg",
                      color: Colors.black),
                ),*/
          ),
        );
      },
      onSelected: (Item selection) {
        debugPrint('You just selected $selection');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(product: selection.sku ?? ''),
            ));
      },
    );
  }

  void navToProductDeatils(String s) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(product: s ?? ''),
        ));
  }
}

class _AsyncAutocomplete extends StatefulWidget {
  const _AsyncAutocomplete();

  @override
  State<_AsyncAutocomplete> createState() => _AsyncAutocompleteState();
}

class _AsyncAutocompleteState extends State<_AsyncAutocomplete> {
  // The query currently being searched for. If null, there is no pending
  // request.
  String? _searchingWithQuery;

  // The most recent options received from the API.

  SearchModel searchModel = SearchModel();

  GraphQLService graphQLService = GraphQLService();
  late Iterable<SearchModel> _lastOptions = <SearchModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<SearchModel> getData(value) async {
    searchModel = await graphQLService.productsearch_suggestion(value);
    return searchModel;
  }

  @override
  Widget build(BuildContext context) {

    return Autocomplete<SearchModel>(
      optionsViewBuilder: (context, onSelected, options) {
        return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  child: ListTile(
                    tileColor: Colors.grey.withOpacity(0.5),
                    title: Text('Comment $index'),
                  ),
                ),
              );
            });
      },
      
      optionsBuilder: (TextEditingValue textEditingValue) async {
        _searchingWithQuery = textEditingValue.text;
        getData(textEditingValue.text);
        final Iterable<SearchModel> options =
            await _FakeAPI.search(_searchingWithQuery!);

        // If another search happened after this one, throw away these options.
        // Use the previous options intead and wait for the newer request to
        // finish.
        if (_searchingWithQuery != textEditingValue.text) {
          return _lastOptions;
        }

        _lastOptions = options;
        return options;

        // If another search happened after this one, throw away these options.
        // Use the previous options intead and wait for the newer request to
        // finish.
      },
      onSelected: (SearchModel selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}

// Mimics a remote API.
class _FakeAPI {

  GraphQLService graphQLService = GraphQLService();

  // Searches the options, but injects a fake "network" delay.
  static Future<Iterable<SearchModel>> search(String query) async {
    if (query == '') {
      return const Iterable<SearchModel>.empty();
    }
    SearchModel searchModel =
        await GraphQLService().productsearch_suggestion(query);
    return Iterable<SearchModel>.generate(searchModel.products!.items!.length);
  }
}
