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
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Order ID: ${ordersItem.orderNumber ?? 00}",
                    style: const TextStyle(
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
                    // shape: const StadiumBorder(),
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
                borderRadius: BorderRadius.circular(0.0),
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
                rows: [
                  for (var item in ordersItem.items!!)
                    DataRow(cells: [
                      DataCell(Text(
                        item.productName ?? '',
                        style: const TextStyle(fontSize: 13),
                      )),
                      DataCell(Text(
                        item.quantityOrdered.toString(),
                        style: const TextStyle(fontSize: 13),
                      )),
                      DataCell(Text(
                        item.productSalePrice!.value.toString() ??
                            '',
                        style: const TextStyle(fontSize: 13),
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
            padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
            child: Row(
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
                        '₹ ${ordersItem.total!.subtotal!.value ?? ''}',
                        style: const TextStyle(color: Colors.black),
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
            padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
            child: Row(
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
                        '₹ ${ordersItem.total!.totalShipping!.value ?? ''}',
                        style: const TextStyle(color: Colors.black),
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
            padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
            child: Row(
              children: <Widget>[
                const Expanded(
                  // Place `Expanded` inside `Row`

                  child: SizedBox(
                    height: 15, // <-- Your height
                    child: Text(
                      "Discount",
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
                        ordersItem.total!.discounts!.isEmpty ?'0': ' - ₹ ${ordersItem.total!.discounts?[0].amount!.value! ?? '0'}',
                        style: const TextStyle(color: Colors.black),
                      )
                    ]),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Container(
              color: const Color(0xFFFFF2E1),
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
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30, // <-- Your height
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(children: [
                          Text(
                            '₹ ${ordersItem.total!.grandTotal!.value ?? ''}',
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
          ),
          const SizedBox(height: 30),
          const Padding(
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
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'Shipping Address',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(

                        "${ordersItem.shippingAddress!.firstname!} "
                        "${ordersItem.shippingAddress!.lastname!} \n"
                        "${ordersItem.shippingAddress!.street![0]}, "
                        "${ordersItem.shippingAddress!.city!} \n"
                            "${ordersItem.shippingAddress!.region!}, "
                            "${ordersItem.shippingAddress!.postcode!} \n"
                            "Tel: ${ordersItem.shippingAddress!.telephone!}",


                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            height: 1.5,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              ordersItem.shippingMethod ?? '',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
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
                    const SizedBox(
                      width: 40,
                    ),
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

                        "${ordersItem.billingAddress!.firstname!} "
                            "${ordersItem.billingAddress!.lastname!} \n"
                            "${ordersItem.billingAddress!.street![0]}, "
                            "${ordersItem.billingAddress!.city!} \n"
                            "${ordersItem.billingAddress!.region!}, "
                            "${ordersItem.billingAddress!.postcode!} \n"
                            "Tel: ${ordersItem.billingAddress!.telephone!}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            height: 1.5,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              ordersItem.paymentMethods!.first.name!
                                      .toString() ??
                                  '',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
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
