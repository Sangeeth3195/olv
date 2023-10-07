import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/LoginPage.dart';
import 'package:omaliving/models/CartModel.dart';
import 'package:omaliving/screens/cart/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/default_button.dart';
import '../../models/Cart.dart';
import '../provider/provider.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

/*class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,

      body: Body(),
      // bottomNavigationBar: CheckoutCard(),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:omaliving/screens/order_details/orderdetails.dart';

import '../../components/size_config.dart';
import '../../constants.dart';
import '../order_success/OrderSuccess.dart';
import 'components/body.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/ordersummary";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GraphQLService graphQLService = GraphQLService();
  CartProvider? cartProvider;
  void initState() {
    super.initState();
    getNavdata();
  }

  void getNavdata() async {
    cartProvider = Provider.of<CartProvider>(context, listen: false);

    cartProvider!.getCartData();
    if (kDebugMode) {}

    graphQLService.get_cart_list();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, provider, _) {
        if (provider.cartModel.cart == null ||
            cartProvider!.cartModel.cart == null ||
            cartProvider!.cartModel.cart!.items == null||
            cartProvider!.cartModel.cart!.items!.isEmpty) {
          return const Center(
            child: Text('You have no items in your Cart.'),
          );
        }
        return Scaffold(
          body: Body(cartModel: provider.cartModel),
          bottomNavigationBar: CheckoutCard(
            cartModel: provider.cartModel,
            cartProvider: cartProvider!,
          ),
        );
      },
    );
  }
}

class CheckoutCard extends StatefulWidget {
  final CartModel cartModel;
  final CartProvider cartProvider;

  const CheckoutCard({
    Key? key,
    required this.cartModel,
    required this.cartProvider,
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  TextEditingController applyCouponController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(5),
        horizontal: getProportionateScreenWidth(5),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenWidth(15),
                horizontal: getProportionateScreenWidth(10),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -15),
                    blurRadius: 20,
                    color: const Color(0xFFDADADA).withOpacity(0.15),
                  )
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Apply Coupon code",
                          style: TextStyle(
                            fontSize: 14.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            enabled: widget
                                    .cartModel.cart!.prices!.discounts!.isEmpty
                                ? true
                                : false,
                            controller: applyCouponController,
                            onSubmitted: (s) {},
                            decoration: const InputDecoration(
                                hintText: "Enter coupon code",
                                fillColor: Color(0xFFF5F6F9),
                                filled: true,
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: SizedBox(
                            height: 45, // <-- Your height
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: headingColor,
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal),
                                // shape: const StadiumBorder(),
                              ),
                              onPressed: () {
                                if (widget.cartModel.cart!.prices!.discounts!
                                    .isNotEmpty) {
                                  widget.cartProvider.removeApplyCouponCode();
                                  applyCouponController.clear();
                                  return;
                                }
                                if (applyCouponController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'Please enter coupon');
                                  return;
                                }
                                widget.cartProvider.setapplyCouponCode(
                                    applyCouponController.text);
                              },
                              child: Text(
                                widget.cartModel.cart!.prices!.discounts!
                                        .isEmpty
                                    ? 'Apply'
                                    : 'Cancel',
                                style: const TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const Row(
                      children: [
                        Text(
                          "Payment Summary",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          // Place `Expanded` inside `Row`
                          child: SizedBox(
                            height: 15, // <-- Your height
                            child: Text(
                              'Subtotal',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30, // <-- Your height
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(children: [
                              Text(
                                '₹ ${widget.cartModel.cart!.prices!.subtotalExcludingTax!.value.toString()}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          // Place `Expanded` inside `Row`
                          child: SizedBox(
                            height: 15, // <-- Your height
                            child: Text(
                              'Standard Shipping',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30, // <-- Your height
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(children: [
                              Text(
                                '₹ ${widget.cartModel.cart!.prices!.subtotalExcludingTax!.value! > 10000 ? 0 : 500}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          // Place `Expanded` inside `Row`
                          child: SizedBox(
                            height: 15, // <-- Your height
                            child: Text(
                              'Discount',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30, // <-- Your height
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(children: [
                              Text(
                                '- ₹ ${widget.cartModel.cart!.prices!.discounts!.isEmpty ? 0 : widget.cartModel.cart!.prices!.discounts![0].amount!.value}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      // color: const Color(0xFFFFF2E1),
                      color: kPrimaryLightColor,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                              // Place `Expanded` inside `Row`
                              child: SizedBox(
                                height: 15, // <-- Your height
                                child: Text(
                                  'Order Total',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30, // <-- Your height
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(children: [
                                  Text(
                                    '₹ ${widget.cartModel.cart!.prices!.grandTotal!.value.toString()}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: DefaultButton(
                        text: "Continue to Checkout",
                        press: () async {
                          final myProvider =
                              Provider.of<MyProvider>(context, listen: false);
                          myProvider.navBar = true;
                          myProvider.notifyListeners();

                          /// set payment to cart
                          widget.cartProvider.setpaymentoncart();

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          var token = prefs.getString('token') ?? '';

                          if (token.isEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          } else {
                            CartProvider cartProvider =
                                Provider.of<CartProvider>(context,
                                    listen: false);

                            context.go('/cart/continue');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
