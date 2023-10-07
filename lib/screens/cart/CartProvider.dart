import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/models/CartModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  GraphQLService graphQLService = GraphQLService();
  CartModel cartModel = CartModel();
  SharedPreferences? prefs;
  var cart_token;

  void getCartData() async {

    prefs = await SharedPreferences.getInstance();
    cart_token = prefs!.getString('cart_token') ?? '';

    print(cart_token);

    if (cart_token == '') {
      await graphQLService.create_cart();
      cart_token = prefs!.getString('cart_token') ?? '';
    }

    dynamic data = await graphQLService.get_cart_list();
    cartModel = CartModel.fromJson(data);

    notifyListeners();
  }

  void removeItem(String id) async {
    await graphQLService.remove_item_from_cart(cart_token, id);
    getCartData();
  }

  void updateItem(String id, int quantity) async {
    print(id);
    print(quantity);
    EasyLoading.show(status: 'loading...');
    await graphQLService.update_product_to_cart(id, quantity.toString());
    getCartData();
  }

  void setapplyCouponCode(String applyCouponController) async {
    EasyLoading.show(status: 'loading...');
    await graphQLService.apply_coupon_to_cart(
        cart_token, applyCouponController);
    getCartData();
  }

  void removeApplyCouponCode() async {
    EasyLoading.show(status: 'loading...');
    await graphQLService.remove_coupon_to_cart(cart_token);
    getCartData();
  }

  void addToWishList({required String sku, required String qty}) async {
    await graphQLService.add_Product_from_wishlist(
        sku: sku, qty: qty, wishlistId: '');
    getCartData();
  }

  void aval_pay_method() async {
    await graphQLService.available_payment_methods(cart_token);
    // getCartData();
  }

  void setpaymentoncart() async {
    await graphQLService.set_payment_to_cart(cart_token);
    // getCartData();
  }

  void shp_free() async {
    graphQLService.set_shipping_method_to_cart(cart_token, 'freeshipping');
    getCartData();
  }

  void shp_flat() async {
    graphQLService.set_shipping_method_to_cart(cart_token, 'flatrate');
    getCartData();
  }

}
