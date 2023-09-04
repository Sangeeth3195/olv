import 'package:flutter/material.dart';
import 'package:omaliving/models/OrderModel.dart';

import 'components/body.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key, required this.ordersItem});
  final OrdersItem? ordersItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black,size: 20),
        title: const Text('Orders',style: TextStyle(color: Colors.black,fontSize: 16),),
      ),
      body:  Body(ordersItem: ordersItem!!,),
    );
  }
}
