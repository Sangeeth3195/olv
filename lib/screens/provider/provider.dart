import 'package:flutter/material.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';

class MyProvider extends ChangeNotifier {
  List<dynamic> _data = [];

  List<dynamic> get data => _data;


  GraphQLService graphQLService = GraphQLService();
  List<dynamic> pList = [];
  dynamic productData;
  void updateData(int id) async{
    pList = await graphQLService.getproductlist(limit: 100, id: id);
    _data = await graphQLService.getproductlist(limit: 100, id: id);

    notifyListeners();
  }

  void updateProductDescriptionData(int id) async{
    productData = await graphQLService.getproductdescription(limit: 100, id: id);
    notifyListeners();
  }
}
