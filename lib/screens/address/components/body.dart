import 'package:flutter/material.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/CustomerModel.dart';

import '../../../API Services/graphql_service.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GraphQLService graphQLService = GraphQLService();

  CustomerModel customerModel = CustomerModel();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    customerModel = await graphQLService.get_customer_details();

    print(customerModel.customer?.addresses?.length);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: customerModel.customer?.addresses?.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: (){
              Navigator.of(context, rootNavigator: true).pushNamed("/addaddress",arguments: customerModel.customer?.addresses?[index]).then((value) => ({
                getData()
              }));
            },
            title: Text(
              customerModel.customer?.addresses?[index].firstname??'',
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              customerModel.customer?.addresses?[index].street?.first??'',
              style: TextStyle(fontSize: 13),
            ),
            trailing: SizedBox(
              width: 46,
              child: Expanded(
                // Place `Expanded` inside `Row`
                child: Row(
                  children: [
                    Text(
                      'Edit |',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      size: 14,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pushNamed("/addaddress");
        },
        backgroundColor: headingColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
