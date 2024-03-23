import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/CustomerModel.dart';
import 'package:omaliving/screens/add_address/add_address.dart';

import '../../../API Services/graphql_service.dart';
import '../../../components/size_config.dart';

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
    EasyLoading.show(status: 'loading...');

    customerModel = await graphQLService.get_customer_details();

    print(customerModel.customer?.addresses?.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (customerModel.customer == null ||
              customerModel.customer!.addresses == null)
          ? const Center(
              child: Text('Your address list is empty'),
            )
          : Container(
              margin:
                  const EdgeInsets.only(bottom: 0, left: 5, right: 5, top: 5),
              child: customerModel.customer!.addresses!.isEmpty
                  ? const Center(
                      child: Text('Your address list is empty'),
                    )
                  : ListView.builder(
                      itemCount: customerModel.customer!.addresses!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddAddress(
                                        title:'Edit Address',
                                            arguments: customerModel
                                                .customer?.addresses?[index],
                                          )),
                                ).then((value) {
                                  getData();
                                });
                              },
                              title: Text(
                                customerModel.customer?.addresses?[index]
                                        .firstname ??
                                    '',
                                style: const TextStyle(fontSize: 15, fontFamily: 'Gotham', fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    customerModel.customer?.addresses?[index].street
                                            ?.first ??
                                        '',
                                    style: const TextStyle(fontSize: 13, fontFamily: 'Gotham',),
                                  ),
                                  Text(
                                    customerModel.customer?.addresses?[index].city
                                             ??
                                        '',
                                    style: const TextStyle(fontSize: 13, fontFamily: 'Gotham',),
                                  ),
                                  Text(
                                    customerModel.customer?.addresses?[index].telephone
                                             ??
                                        '',
                                    style: const TextStyle(fontSize: 13, fontFamily: 'Gotham',),
                                  ),
                                ],
                              ),
                              trailing: const SizedBox(
                                width: 70,
                                child: Row(
                                  children: [
                                    Text(
                                      'Edit |',
                                      style: TextStyle(
                                          color: headingColor, fontSize: 16),
                                    ),
                                    Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: headingColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(15),
                                right: getProportionateScreenWidth(15),
                              ),
                              child: const Divider(
                                color: Colors.black12,
                                height: 0.1,
                              ), //                           <-- Divider
                            ), //                           <-- Divider
                          ],
                        );
                      },
                    ),
            ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width-30,
        child: ElevatedButton(
          onPressed: () {
            // Button pressed action
            print('Button Pressed!');
            Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddAddress( title:'Add Address',)),
                    );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(themecolor)
            // Add your customizations here
          ),
          child: Text('Add Address',style: TextStyle(color: Colors.white),),
          // color: Colors.blue,
          // textColor: Colors.white,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Navigator.of(context, rootNavigator: true).pushNamed("/addaddress");
      //
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const AddAddress( title:'Add Address',)),
      //     );
      //   },
      //   backgroundColor: headingColor,
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
