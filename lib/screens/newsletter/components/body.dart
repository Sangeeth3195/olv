import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omaliving/components/default_button.dart';

import '../../../API Services/graphql_service.dart';
import '../../../models/CustomerModel.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GraphQLService graphQLService = GraphQLService();
  CustomerModel customerModel = CustomerModel();

  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    EasyLoading.show(status: 'loading...');
    customerModel = await graphQLService.get_customer_details();
    setState(() {
      isChecked = customerModel.customer!.issubscribed!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                        print(isChecked);
                      });
                    },
                  ),
                  const Text(
                    'General Subscription',
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Colors.black),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.all(15),
                child: DefaultButton(
                  text: 'Save',
                  press: () async {
                    EasyLoading.show(status: 'loading...');
                    String? nam = customerModel.customer?.firstname;
                    String? lm = customerModel.customer?.lastname;
                    String? em = customerModel.customer?.email;
                    String result;
                    result = await graphQLService.update_customer_details_api(
                        firstname: nam!,
                        lastname: lm!,
                        email: em!,
                        isSubscribed: isChecked);
                    if (result == "200") {
                      EasyLoading.dismiss();
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(msg: "Subscribed Successfully");
                    } else {
                      EasyLoading.dismiss();
                      Fluttertoast.showToast(msg: "Subscribed updation failed");
                    }
                  },
                ),
              ), //Row
            ],
          ), //Column
        ), //Padding
      ), //Card
    );
  }

  void checkBoxCallBack(bool? checkBoxState) {
    if (checkBoxState != null) {
      setState(() {
        isChecked = checkBoxState ?? true;
      });
    }
  }
}
