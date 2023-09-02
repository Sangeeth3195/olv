

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omaliving/models/CustomerModel.dart';

import '../../../API Services/graphql_service.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GraphQLService graphQLService = GraphQLService();
  final _formKey = GlobalKey<FormState>();
  List<dynamic> navHeaderList = [];

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  CustomerModel customerModel = CustomerModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    // navHeaderList = await graphQLService.getcustomeraddresslist(limit: 100);
    // setState(() {});
    customerModel = await graphQLService.get_customer_details();

    print(customerModel.customer?.addresses?.length);
    setState(() {

      _firstnameController.text=customerModel.customer?.firstname??'';
      _lastnameController.text=customerModel.customer?.lastname??'';
      _emailController.text=customerModel.customer?.email??'';
    });
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             ListTile(
              leading: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                    'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/HEADER.webp'),
              ),
              title: Text(
                customerModel?.customer?.firstname??'',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                //TODO: take from profile info
                customerModel?.customer?.email??'',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
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
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: TextFormField(
                controller: _firstnameController,
                obscureText: false,
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
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 0.0),
              child: Text(
                'Email',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: TextFormField(
                controller: _emailController,
                obscureText: false,
                textInputAction: TextInputAction.next,
                validator: (val) {
                  if (val!.isEmpty) return 'This is a required field.';
                  return null;
                },
                style: const TextStyle(fontSize: 14.0, color: Colors.black),
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: InkWell(
                onTap: () async{
                  if (_formKey.currentState!.validate()) {
                    /*graphQLService.Login(loginEmailController.text.toString(),
                        loginPasswordController.text.toString(), context);*/

                    if (_formKey.currentState!.validate()) {
                      String result;

                      result= await  graphQLService.update_customer_details_api(firstname: _firstnameController.text, lastname: _lastnameController.text, email: _emailController.text, isSubscribed: false);

                      if(result=="200"){
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(msg: "Address Added Successfully");
                      }else{
                        Fluttertoast.showToast(msg: "Address Added Failed");

                      }
                    }

                  }
                },
                child: Container(
                  //width: 100.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: headingColor,
                    border: Border.all(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
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
          ],
        ),
      ),
    );
  }
}
