
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:omaliving/models/OrderModel.dart';
import 'package:omaliving/screens/recent_order/recentorder.dart';

import '../../../API Services/graphql_service.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GraphQLService graphQLService = GraphQLService();
  OrderModel ordersModel = OrderModel();
  dynamic productData;
  List<dynamic> pList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    EasyLoading.show(status: 'loading...');
    ordersModel = await graphQLService.getorderdetails(limit: 1000, context: context);
    setState(() {});
  }

  void call_reorder(String? order_id) async {
    EasyLoading.show(status: 'loading...');

    dynamic listData = await graphQLService.re_order(order_id!);
    List<Map<String, dynamic>> jsonArray = [];

    for (int i = 0; i < listData['reorderItems']['cart']['items'].length; i++) {

      print(listData['reorderItems']['cart']['items'][i]['product']['sku']);

      print(listData['reorderItems']['cart']['items'][i]['quantity']);
      jsonArray.add( {"quantity": "${listData['reorderItems']['cart']['items'][i]['quantity']}",
          "sku": "${listData['reorderItems']['cart']['items'][i]['product']['sku']}"});
      /// add to cart API call
    }
    graphQLService.addProductToCartNew(jsonArray);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: (ordersModel.customer == null ||
                ordersModel.customer!.orders == null)
            ? const Center()
            : Container(
                margin:
                    const EdgeInsets.only(bottom: 0, left: 5, right: 5, top: 5),
                child: ordersModel.customer!.orders!.items!.isEmpty
                    ? const Center(
                        child: Text('Your order list is empty',style: TextStyle(  fontFamily: 'Gotham',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Colors.black),),
                      )
                    : ListView.builder(
                        itemCount: ordersModel.customer!.orders!.items!.length,
                        itemBuilder: (context, index) {
                          DateTime? date = ordersModel.customer?.orders?.items?[index].orderDate;
                          print(date);
                          print(DateFormat.yMMMd().format(date!));
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              height: 170,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                borderOnForeground: true,
                                elevation: 2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Order ID: ${ordersModel.customer?.orders?.items?[index].orderNumber}",
                                              style: const TextStyle(
                                                  fontFamily: 'Gotham',
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "Total: ₹ ${ordersModel.customer?.orders?.items![index].total?.grandTotal!.value}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                height: 1.5,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Order Status: ${ordersModel.customer?.orders?.items?[index].status}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              DateFormat.yMMMMd().format(date),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Ship To : ${ordersModel.customer?.orders?.items?[index].shippingAddress?.firstname}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),

                                          /// Reorder
                                         /*   MaterialButton(
                                        color: headingColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0.0),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          "Reorder",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 13),
                                        ),
                                      ),*/

                                          OutlinedButton(
                                            onPressed: () {

                                              print(ordersModel
                                                  .customer
                                                  ?.orders
                                                  ?.items?[index].orderNumber);

                                              call_reorder(ordersModel
                                                  .customer
                                                  ?.orders
                                                  ?.items?[index].orderNumber);

                                            },
                                            style: OutlinedButton.styleFrom(
                                              backgroundColor: headingColor,
                                                textStyle: const TextStyle(fontSize: 12, fontStyle: FontStyle.normal,color: Colors.white),
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(5)))),
                                            child: const Text(
                                              'Reorder',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ),

                                          const SizedBox(
                                            width: 4,
                                          ),

                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              RecentOrders(
                                                                ordersItem:
                                                                    ordersModel
                                                                        .customer
                                                                        ?.orders
                                                                        ?.items?[index],
                                                              )));
                                            },
                                            style: OutlinedButton.styleFrom(

                                                primary: headingColor,
                                                textStyle: const TextStyle(fontSize: 12, fontStyle: FontStyle.normal),
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(5)))),
                                           /* style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  width: 1.0,
                                                  color: headingColor),
                                              // shape: const StadiumBorder(),
                                            ),*/
                                            child: const Text(
                                              'View Order',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: headingColor,
                                                  fontSize: 14),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ));
  }
}
