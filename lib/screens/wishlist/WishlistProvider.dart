/*import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';

import '../../models/CustomerModel.dart';

class WishlistProvider with ChangeNotifier {
  GraphQLService graphQLService = GraphQLService();
  CustomerModel customerModel = CustomerModel();

  void getwishlistData() async {
    EasyLoading.show(status: 'loading...');
    customerModel = await graphQLService.get_customer_details();
    print('wishlist id');
    notifyListeners();
  }

  void removeItem(String wishlistId,String wishlistItemsIds) async {
    EasyLoading.show(status: 'loading...');
    await graphQLService.remove_Product_from_wishlist(wishlistId:wishlistId, wishlistItemsIds:wishlistItemsIds);
    getwishlistData();
  }

}*/
