import 'package:flutter/material.dart';
import 'package:omaliving/screens/order_summary/ordersummary.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../Razorpay.dart';
import '../../components/default_button.dart';
import '../../components/size_config.dart';
import '../../constants.dart';
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
      bottomNavigationBar: const CheckoutCard(title: '',),
    );
  }
}

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CheckoutCard> {

  void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                const Expanded(
                  child: Text(
                    "₹ 1,598",
                    style: TextStyle(
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
                      onPressed: () {

                        Razorpay razorpay = Razorpay();
                        var options = {
                          'key': 'rzp_test_1RBFegXl5eMjV2',
                          'amount': 100,
                          'name': 'Acme Corp.',
                          'description': 'Fine T-Shirt',
                          'retry': {'enabled': true, 'max_count': 1},
                          'send_sms_hash': true,
                          'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
                          'external': {
                            'wallets': ['paytm']
                          }
                        };
                        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                        razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                        razorpay.open(options);


                       /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Ordersummary()),
                        );*/

                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RazorpayTEST(title: '',)),
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
  }
}