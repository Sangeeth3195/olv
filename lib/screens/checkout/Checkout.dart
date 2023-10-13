import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/screens/cart/CartProvider.dart';
import 'package:omaliving/screens/order_summary/ordersummary.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API Services/graphql_service.dart';
import '../../Razorpay.dart';
import '../../components/default_button.dart';
import '../../components/size_config.dart';
import '../../constants.dart';
import '../../models/CustomerModel.dart';
import '../cart/components/check_out_card.dart';
import '../order_details/orderdetails.dart';
import '../order_success/OrderSuccess.dart';
import 'components/body.dart';

class Checkout extends StatelessWidget {
  static String routeName = "/ordersummary";

  const Checkout({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black,size: 20),
        title: const Text('Shipping Address',style: TextStyle(color: Colors.black,fontSize: 16),),
      ),
      body: const Body(),
      bottomNavigationBar: CheckoutCard(title: '',),
    );
  }
}

class CheckoutCard extends StatefulWidget {
  CheckoutCard({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CheckoutCard> {

  GraphQLService graphQLService = GraphQLService();
  CustomerModel customerModel = CustomerModel();

  String? mob_number;
  String? email;

  SharedPreferences? prefs;
  var cart_token;
  var orderID;

  void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */

    Fluttertoast.showToast(msg: "Payment failed");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const OrderSuccess()));

    Fluttertoast.showToast(msg: 'Payment Successful');

    cleardata();

  }

  Future<void> cleardata() async {
    print('clear token');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('cart_token');
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: "Payment Successfully");
  }


  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {

    customerModel = await graphQLService.get_customer_details();

    print(customerModel.customer?.addresses?.length);
    setState(() {
      mob_number = customerModel.customer?.addresses?[0].telephone;
      email = customerModel.customer?.email ?? '';
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? sub_total = prefs.getDouble('sub_total');

    print(sub_total);

    prefs =
    await SharedPreferences.getInstance();
    cart_token = prefs!.getString('cart_token') ?? '';

    if(sub_total!  >= 10000 ){
     graphQLService.set_shipping_method_to_cart(context,cart_token,'freeshipping');

    }else{
      graphQLService.set_shipping_method_to_cart(context,cart_token,'flatrate');

    }
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<CartProvider>(
      builder: (context, provider, _) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(15),
            horizontal: getProportionateScreenWidth(10),
          ),
          // height: 174,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Expanded(
                      child: Text(
                        "₹ ${provider.cartModel.cart!.prices!.grandTotal!.value.toString()}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      // Place 2 `Expanded` mean: they try to get maximum size and they will have same size
                      child: SizedBox(
                        height: 40, // <-- Your height
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: headingColor,
                            side: const BorderSide(color: Colors.grey, width: 1.0),
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontStyle: FontStyle.normal),
                            // shape: const StadiumBorder(),
                          ),
                          onPressed: () async {

                            EasyLoading.show(status: 'loading...');

                            graphQLService.available_payment_methods(cart_token);

                            graphQLService.set_payment_to_cart(cart_token);

                            var resultvalue = await graphQLService.place_order();

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('order_ID', resultvalue);

                            prefs = await SharedPreferences.getInstance();
                            cart_token = prefs!.getString('cart_token') ?? '';
                            orderID = prefs!.getString('order_ID') ?? '';

                            Razorpay razorpay = Razorpay();
                            var options = {
                              'key': 'rzp_test_1RBFegXl5eMjV2',
                              'amount': (provider.cartModel.cart!.prices!.grandTotal!.value)! * 100,
                              'name': 'OMA Test Payment.',
                              "timeout": "180",
                              "currency": "INR",
                              'description': "",
                              'retry': {'enabled': true, 'max_count': 1},
                              'send_sms_hash': true,
                              'notes':{'referrer': 'Mobile App', 'merchand_order_id': resultvalue},
                              'prefill': {'contact': mob_number, 'email': email},
                              'external': {
                                'wallets': ["paytm"]
                              }
                            };

                            razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                            razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                            razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

                            try {
                              razorpay.open(options);
                            } catch (e) {
                              debugPrint('Error: $e');
                            }

                            /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Ordersummary()),
                        );*/

                          },
                          child: const Text(
                            'Continue to payment',
                            style: TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}