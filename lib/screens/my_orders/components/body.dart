import 'package:flutter/material.dart';
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

  OrdersModel ordersModel = OrdersModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    ordersModel = await graphQLService.getorderdetails(limit: 100);
    print(ordersModel.data?.customer?.orders?.items?.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: ordersModel.data?.customer?.orders?.items?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SizedBox(
              height: 170,
              child: Card(
                color: const Color(0xFFFCF6FD),
                borderOnForeground: true,
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Order ID: ${ordersModel.data?.customer?.orders?.items?[index].orderNumber}",
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
                          Text(
                            "Total: ₹ ${ordersModel.data?.customer?.orders?.items![index].total?.grandTotal!.value}",
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
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Order Status: ${ordersModel.data?.customer?.orders?.items![index].status}",
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
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "${ordersModel.data?.customer?.orders?.items![index].orderDate}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          /*const SizedBox(
                            width: 4,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('View Order'),
                          )*/
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Ship To : ${ordersModel.data?.customer?.orders?.items![index].shippingAddress?.firstname}",
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
                          MaterialButton(
                            color: headingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Reorder",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          /* MaterialButton(
                            color: headingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "View Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),*/
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RecentOrders()));
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: headingColor),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text(
                              'View Order',
                              style:
                                  TextStyle(color: headingColor, fontSize: 13),
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
    );
  }
}
