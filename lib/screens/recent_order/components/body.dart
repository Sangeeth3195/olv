import 'package:flutter/material.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
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
          const SizedBox(height: 15,),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
            child: Text(
              "Items Ordered",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  height: 1.5,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    "Order ID: 000000933",
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
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        width: 1.0, color: headingColor),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('Print Order'),
                )
              ],
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
                  DataColumn(label: Text('Product Name',style: TextStyle(fontSize: 13),)),
                  DataColumn(label: Text('Qty',style: TextStyle(fontSize: 13),)),
                  DataColumn(label: Text('Amount',style: TextStyle(fontSize: 13),)),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('Scheffera potted plant',style: TextStyle(fontSize: 13),)),
                    DataCell(Text(
                      '4',style: TextStyle(fontSize: 13),
                    )),
                    DataCell(Text('₹ 1,598',style: TextStyle(fontSize: 13),)),
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
          const Padding(
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
                        '₹ 1,298',
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
          const Padding(
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
                        '₹ 500',
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
          const Padding(
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
                        '- ₹ 200',
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
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Container(
              color: const Color(0xFFFFF2E1),
              height: 50,
              child: const Padding(
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
                            '₹ 1,598',
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
