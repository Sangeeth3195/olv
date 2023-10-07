import 'dart:developer';

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

  void getuserdata() async {
    customerModel = await graphQLService.get_customer_details();
    print(customerModel.customer?.addresses?.length);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('emailid', customerModel.customer?.email ?? '');
    notifyListeners();
  }

  void updateData(int id) async {
    dynamic listData = await graphQLService.getproductlist(limit: 100, id: id);
    List? res = listData.data?['products']['items'];
    pList = res!;
    aggrecation = listData.data?['products']['aggregations'];

    dynamic dataFromAPi =
        await graphQLService.getproductlist(limit: 100, id: id);
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

  void sort(int value) {
    if (value == 0) {
      items = oldItems;
    } else if (value == 1) {
      items.sort((a, b) => a.name.compareTo(b.name));
    } else if (value == 2) {
      items.sort((a, b) => a.priceRange.minimumPrice.regularPrice.value
          .compareTo(b.priceRange.minimumPrice.regularPrice.value));
    } else if (value == 3) {
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
    productData = await graphQLService.getproductdescription(id: id);
    notifyListeners();
  }
}
