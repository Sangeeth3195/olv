import 'package:flutter/material.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/CustomerModel.dart';
import 'package:omaliving/screens/address/address.dart';
import 'package:omaliving/screens/cart/CartProvider.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../../components/size_config.dart';
import '../../order_summary/ordersummary.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

enum Fruit { apple, banana }

class _BodyState extends State<Body> {
  Fruit? _fruit = Fruit.apple;
  Address? shippingAddress;
  Address? billingAddress;
  CustomerModel? customerModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 getData();

  }
  void getData()async{

    MyProvider myProvider = Provider.of<MyProvider>(context, listen: false);
    CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
    if(myProvider.customerModel.customer !=null){
      myProvider.customerModel.customer!.addresses!.forEach((element) {
        if(element.defaultShipping!){
          shippingAddress=element;
        }
        if(element.defaultBilling!){
          billingAddress=element;
        }
      });
    }else{
      myProvider.getuserdata();
      myProvider.customerModel.customer!.addresses!.forEach((element) {
        if(element.defaultShipping!){
          shippingAddress=element;
        }
        if(element.defaultBilling!){
          billingAddress=element;
        }
      });

    }
    myProvider.graphQLService.set_shipping_address_to_cart(cartProvider.cart_token,shippingAddress!);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, provider, _) {

        return SingleChildScrollView(
            padding:  EdgeInsets.symmetric(vertical: 10),
            child: Container(
                margin:  EdgeInsets.only(bottom: 5),
                child: Column(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                       SizedBox(height: 20),

                       Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                        child: Text(
                          'Shipping Address',
                          style: TextStyle(
                              color: headingColor, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.symmetric(
                            vertical: 0, horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* const Text(
                          "Delivering to Home",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 8,
                        ),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 Expanded(
                                  child: Text(
                                    shippingAddress != null?"${shippingAddress!.street![0]}\n${shippingAddress!.city}, ${shippingAddress!.city}":"",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        height: 1.5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const AddEditAddress()),
                                    );
                                  },
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Change Address |',
                                        style: TextStyle(
                                            color: headingColor, fontSize: 13),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        size: 13,
                                        color: headingColor,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                        child: Text(
                          'Billing Address',
                          style: TextStyle(
                              color: headingColor, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 Expanded(
                                  child: Text(
                                    billingAddress != null?"${billingAddress!.street![0]}\n${billingAddress!.city}, ${billingAddress!.city}":"",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        height: 1.5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const AddEditAddress()),
                                    );
                                  },
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Change Address |',
                                        style: TextStyle(
                                            color: headingColor, fontSize: 13),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        size: 13,
                                        color: headingColor,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                       Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                        child: Text(
                          'Shipping Method',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),

                      ListTile(
                        title: const Text('Standard Shipping'),
                        leading: Radio<Fruit>(
                          value: Fruit.apple,
                          groupValue: _fruit,
                          onChanged: (Fruit? value) {
                            setState(() {
                              _fruit = value;
                            });
                          },
                        ),
                      ),

                       Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 85),
                        child: Text(

                          '₹ ${provider.cartModel.cart!.prices!.grandTotal!.value!>1000?500:0}',
                          style: TextStyle(
                              color: headingColor, fontWeight: FontWeight.bold),
                        ),
                      ),

                      /* const Padding(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                    child: Text(
                      'Payment Method',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 0),
                    child: Center(
                      child: Image.asset('assets/razorpay.png',
                          height: 200, width: 200),
                    ),
                  ),*/

                    ],
                  ),

                ])));

      },
    );

  }
}
