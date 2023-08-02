import 'package:flutter/material.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';

class MyProvider extends ChangeNotifier {
  List<dynamic> _data = [];
  List<dynamic> aggrecation = [];

  List<dynamic> get data => _data;


  GraphQLService graphQLService = GraphQLService();
  List<dynamic> pList = [];
  dynamic productData;
  void updateData(int id) async{
    dynamic listData = await graphQLService.getproductlist(limit: 100, id: id);
    print(listData.data?['products']['aggregations']);
    List? res = listData.data?['products']['items'];
    pList = res!;
    aggrecation=listData.data?['products']['aggregations'];

    dynamic dataFromAPi = await graphQLService.getproductlist(limit: 100, id: id);
    print(dataFromAPi.data?['products']['aggregations']);
    List? res1 = dataFromAPi.data?['products']['items'];
    _data = res1!;
    aggrecation=dataFromAPi.data?['products']['aggregations'];
    notifyListeners();
  }

  void updateAggrecation(List<dynamic> aggrecationFromApi){
    aggrecation=aggrecationFromApi;
    notifyListeners();

  }
  void updateProductDescriptionData(String id) async{
    productData = await graphQLService.getproductdescription(limit: 100, id: id);
    notifyListeners();
  }
}
