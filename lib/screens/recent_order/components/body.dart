import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/OrderModel.dart';

class Body extends StatelessWidget {
  final OrdersItem ordersItem;

  const Body({super.key, required this.ordersItem});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
            child: Text(
              "My Recent Orders",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  height: 1.5,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 5,),*/

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Expanded(
                  child: Text(
                    "Order ID: ${ordersItem.id??00}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1.0, color: headingColor),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('Print Order'),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
            child: Text(
              "Items Ordered",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DataTable(
                columns: const [
                  DataColumn(
                      label: Text(
                    'Product Name',
                    style: TextStyle(fontSize: 13),
                  )),
                  DataColumn(
                      label: Text(
                    'Qty',
                    style: TextStyle(fontSize: 13),
                  )),
                  DataColumn(
                      label: Text(
                    'Amount',
                    style: TextStyle(fontSize: 13),
                  )),
                ],
                rows:  [
                  DataRow(cells: [
                    DataCell(Text(
                      ordersItem.items![0].productName??'',
                      style: TextStyle(fontSize: 13),
                    )),
                    DataCell(Text(
                      ordersItem.items![0].quantityOrdered.toString(),
                      style: TextStyle(fontSize: 13),
                    )),
                    DataCell(Text(
                      ordersItem.items![0].productSalePrice!.value.toString()??'',
                      style: TextStyle(fontSize: 13),
                    )),
                  ]),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              children: [
                Text(
                  "Payment Summary",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
           Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 0),
            child: Row(
              children: <Widget>[
                Expanded(
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
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(children: [
                      Text(
                        '₹ ${ordersItem.total!.subtotal!.value??''}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
           Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 0),
            child: Row(
              children: <Widget>[
                Expanded(
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
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(children: [
                      Text(
                        '₹ ${ordersItem.total!.totalShipping!.value??''}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
           Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 0),
            child: Row(
              children: <Widget>[
                Expanded(
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
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(children: [
                      Text(
                        '- ₹ 0',
                        style: TextStyle(color: Colors.black),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding:  EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Container(
              color: const Color(0xFFFFF2E1),
              height: 50,
              child:  Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      // Place `Expanded` inside `Row`
                      child: SizedBox(
                        height: 15, // <-- Your height
                        child: Text(
                          'Order Total',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30, // <-- Your height
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(children: [
                          Text(
                            '₹ ${ordersItem.total!.grandTotal!.value??''}',
                            style: TextStyle(
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
          ),
          const SizedBox(height: 30),
           Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              children: [
                Text(
                  "Order Information",
                  style: TextStyle(
                      fontSize: 17,
                      color: headingColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: headingColor),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Expanded(
                      child: Text(
                        'Shipping Address',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 40,),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text(
                              'Shipping Method',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 0,
                ),
                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     Expanded(
                       child: Text(
                         "${ordersItem.shippingAddress!.street![0]??''}",
                         style: TextStyle(
                             color: Colors.black,
                             fontSize: 13,
                             height: 1.5,
                             fontWeight: FontWeight.w500),
                       ),
                     ),
                    SizedBox(width: 40,),

                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child:  Text(
                          '${ordersItem.shippingMethod??''}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'Billing Address',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 40,),

                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text(
                              'Payment Method',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Expanded(
                      child: Text(
                        "${ordersItem.billingAddress!.street![0].toString()??''}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            height: 1.5,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(width: 40,),

                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child:  Row(
                          children: [
                            Text(
                              "${ordersItem.paymentMethods!.first.name!.toString()??''}",
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
