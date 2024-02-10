import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/models/CustomerModel.dart';
// import 'package:omaliving/models/CustomerModel.dart';
import 'package:omaliving/models/ProductListJson.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider extends ChangeNotifier {
  List<dynamic> _data = [];
  List<dynamic> aggrecation = [];

  var navBar = false;

  bool isSearch= false;

  List<dynamic> get data => _data;

  GraphQLService graphQLService = GraphQLService();
  List<dynamic> pList = [];
  dynamic productData;

  List<Aggregation> aggregationList = [];
  List<Item> items = [];
  List<Item> oldItems = [];

  String title = "New Arrival";

  bool isDetailScreen = false;
  bool isproduct = false;
  int? bottombar;
  CustomerModel customerModel = CustomerModel();

  int wishListNumbers = 0;

  void updateHeader(String header) {
    title = header;
    notifyListeners();
  }

  void updateHeaderScreen(bool value) {
    isDetailScreen = value;
    notifyListeners();
  }

  void bottomBar(int bottomIndex) {
    bottombar = bottomIndex;
    notifyListeners();
  }

  void showHideSearch(){
    isSearch = !isSearch;
    notifyListeners();
  }

  Future<void> getuserdata() async {
    customerModel = await graphQLService.get_customer_details();
    print(customerModel.customer?.addresses?.length);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('emailid', customerModel.customer?.email ?? '');
    if (customerModel.customer != null ||
        customerModel.customer!.wishlist != null ||
        customerModel.customer!.wishlist!.items != null) {
      wishListNumbers = customerModel.customer!.wishlist!.items!.length;
    }
    notifyListeners();
  }

  void updateData(int id, {int limit = 8}) async {
    dynamic dataFromAPi =
        await graphQLService.getproductlist(limit: limit, id: id);
    List? res1 = dataFromAPi.data?['products']['items'];
    _data = res1!;
    pList = res1;
    aggrecation = dataFromAPi.data?['products']['aggregations'];
    final List<dynamic> postList =
        dataFromAPi.data?['products']['aggregations'];
    aggregationList =
        postList.map((postJson) => Aggregation.fromJson(postJson)).toList();
    final List<dynamic> itemList = dataFromAPi.data?['products']['items'];
    items = itemList.map((postJson) => Item.fromJson(postJson)).toList();
    oldItems = itemList.map((postJson) => Item.fromJson(postJson)).toList();

    notifyListeners();
  }

  void updatebrandData(int id,int id1, {int limit = 2}) async {
    dynamic dataFromAPi =
    await graphQLService.getbrandFilter(limit: limit, id: id,id1: id1);
    List? res1 = dataFromAPi.data?['products']['items'];
    _data = res1!;
    pList = res1;
    final List<dynamic> itemList = dataFromAPi.data?['products']['items'];
    items = itemList.map((postJson) => Item.fromJson(postJson)).toList();
    oldItems = itemList.map((postJson) => Item.fromJson(postJson)).toList();
    notifyListeners();
  }

  void updateSearchData(String id) async {
    dynamic listData = await graphQLService.productsearch(id);
    List? res = listData['products']['items'];
    pList = res!;
    aggrecation = listData['products']['aggregations'];

    dynamic dataFromAPi = await graphQLService.productsearch(id);
    List? res1 = dataFromAPi['products']['items'];
    _data = res1!;
    aggrecation = dataFromAPi['products']['aggregations'];
    final List<dynamic> postList = dataFromAPi['products']['aggregations'];
    aggregationList =
        postList.map((postJson) => Aggregation.fromJson(postJson)).toList();
    final List<dynamic> itemList = dataFromAPi['products']['items'];
    items = itemList.map((postJson) => Item.fromJson(postJson)).toList();
    oldItems = itemList.map((postJson) => Item.fromJson(postJson)).toList();

    notifyListeners();
  }

  void updateDataWithFilter(int id, Map<String, dynamic> filter) async {
    EasyLoading.dismiss();
    dynamic listData = await graphQLService.getproductlistBySorting(
        limit: 100, id: id, hashMap: filter);
    print(listData.data?['products']['aggregations']);
    List? res = listData.data?['products']['items'];
    pList = res!;
    aggrecation = listData.data?['products']['aggregations'];

    dynamic dataFromAPi = await graphQLService.getproductlistBySorting(
        limit: 100, id: id, hashMap: filter);
    List? res1 = dataFromAPi.data?['products']['items'];
    _data = res1!;
    aggrecation = dataFromAPi.data?['products']['aggregations'];
    final List<dynamic> postList =
        dataFromAPi.data?['products']['aggregations'];
    aggregationList =
        postList.map((postJson) => Aggregation.fromJson(postJson)).toList();
    final List<dynamic> itemList = dataFromAPi.data?['products']['items'];
    items = itemList.map((postJson) => Item.fromJson(postJson)).toList();
    oldItems = itemList.map((postJson) => Item.fromJson(postJson)).toList();

    notifyListeners();
  }

  void sort(String value) {
    if (value == "Most Relevant") {
      items = oldItems;
    } else if (value == "Product Name") {
      items.sort((a, b) => a.name.compareTo(b.name));
    } else if (value == "Low to high") {
      items.sort((a, b) => a.priceRange.minimumPrice.regularPrice.value
          .compareTo(b.priceRange.minimumPrice.regularPrice.value));
    } else if (value == "High to low") {
      items.sort((a, b) => a.priceRange.minimumPrice.regularPrice.value
          .compareTo(b.priceRange.minimumPrice.regularPrice.value));
      items = items.reversed.toList();
    }
    notifyListeners();
  }

  void updateAggrecation(List<dynamic> aggrecationFromApi) {
    aggrecation = aggrecationFromApi;
    notifyListeners();
  }

  void updateProductDescriptionData(String id) async {
    productData = null;
    productData = await graphQLService.getproductdescription(id: id);
    notifyListeners();
  }
}
