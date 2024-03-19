import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API Services/graphql_service.dart';
import '../../constants.dart';
import '../../models/CustomerModel.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Account> {

  GraphQLService graphQLService = GraphQLService();
  final _formKey = GlobalKey<FormState>();
  List<dynamic> navHeaderList = [];

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  CustomerModel customerModel = CustomerModel();

  bool isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  void getuserdata() async {

    EasyLoading.show(status: 'loading...');

    customerModel = await graphQLService.get_customer_details();

    print(customerModel);

    print(customerModel.customer?.addresses?.length);
    setState(() {
      _firstnameController.text = customerModel.customer?.firstname ?? '';
      _lastnameController.text = customerModel.customer?.lastname ?? '';
      _emailController.text = customerModel.customer?.email ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        title: const Text(
          'Profile',
          style: TextStyle(fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              icon: Image.asset(
                'assets/icons/edit.png',
                width: 18,
                height: 18,
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/photo.jpg'),
                ),
                title: Text(
                  '${customerModel.customer?.firstname}' + ' ${customerModel.customer?.lastname}' ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  //TODO: take from profile info
                  customerModel.customer?.email ?? '',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 0.0),
                child: Text(
                  'First Name',
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      color: blackColor
                    // color: Colors.black,
                    // fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  controller: _firstnameController,
                  obscureText: false,
                  enabled: isVisible,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) return 'This is a required field.';
                    return null;
                  },
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      hintText: "First Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 0.0),
                child: Text(
                  'Last Name',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: TextFormField(
                  controller: _lastnameController,
                  obscureText: false,
                  enabled: isVisible,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) return 'This is a required field.';
                    return null;
                  },
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      hintText: "Last Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              /*const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 0.0),
              child: Text(
                'Email',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ),*/

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_formKey.currentState!.validate()) {

                        EasyLoading.show(status: 'loading...');

                        String result;
                        result = await graphQLService.update_customer_details_api(
                            firstname: _firstnameController.text,
                            lastname: _lastnameController.text,
                            email: _emailController.text,
                            isSubscribed: false);

                        if (result == "200") {

                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('first_name', _firstnameController.text);
                          prefs.setString('last_name', _lastnameController.text);

                          EasyLoading.dismiss();
                          Navigator.of(context).pop();

                          Fluttertoast.showToast(
                              msg: "Profile updated Successfully");
                        } else {
                          EasyLoading.dismiss();
                          Fluttertoast.showToast(msg: "Profile updation  Failed");
                        }
                      }
                    }
                  },
                  child:  Visibility(
                    visible: isVisible,
                    child:Container(
                    //width: 100.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: headingColor,
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ),
                  ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
