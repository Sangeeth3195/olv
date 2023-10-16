import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../API Services/graphql_service.dart';
import '../../../components/no_account_text.dart';
import '../../../constants.dart';
import '../../../components/size_config.dart';
import '../../../models/CustomerModel.dart';
import '../../provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  GraphQLService graphQLService = GraphQLService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset('assets/images/resetpassword.png',
                    height: 200, width: 200),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 20.0, 10.0, 0),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0),
                child: Text(
                  "Please enter your email and we will send you a link to return to your account",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: getProportionateScreenWidth(12),
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0),
                child: Text(
                  "New Password",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: getProportionateScreenWidth(12),
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;
  GraphQLService graphQLService = GraphQLService();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confrmnewpasswordController = TextEditingController();
  dynamic revokeloggedinuser = [];
  bool _obscureText1 = true;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 0.0, right: 10.0, bottom: 20.0, left: 10.0),
            child: TextFormField(
              controller: newpasswordController,
              obscureText: _obscureText,
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val!.isEmpty) return 'This is a required field.';
                return null;
              },
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                  hintText: "New Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 5.0, 0),
            child: Text(
              "Confirm Password",
              textAlign: TextAlign.start,
              style: TextStyle(
                height: 1.5,
                fontSize: getProportionateScreenWidth(12),
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 5.0, right: 10.0, bottom: 20.0, left: 10.0),
            child: TextFormField(
              controller: confrmnewpasswordController,
              obscureText: _obscureText1,
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val!.isEmpty) return 'Password field is Empty';
                if (val != newpasswordController.text) {
                  return 'Confirm Password not matching';
                }
                return null;
              },
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText1 ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText1 = !_obscureText1;
                      });
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                  hintText: "Confirm New Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 0.0, right: 10.0, bottom: 0.0, left: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
                backgroundColor: themecolor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {

                  EasyLoading.show(status: 'loading...');

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? old_password1 = prefs.getString('loginPassword');

                  print(confrmnewpasswordController.text);
                  print(old_password1);

                  String result;
                  result = await graphQLService.update_reset_password(password:confrmnewpasswordController.text.toString(),
                      old_password:old_password1.toString());

                  if (result == "200") {
                    EasyLoading.dismiss();
                    Navigator.of(context).pop();
                    MyProvider myProvider = Provider.of<MyProvider>(context, listen: false);

                    myProvider.customerModel=CustomerModel();
                    myProvider.getuserdata();
                    revokeloggedinuser = await graphQLService.revokeuser(context);
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    await preferences.clear();
                    Fluttertoast.showToast(
                        msg: "Password updated Successfully");
                  } else {
                    EasyLoading.dismiss();
                    Fluttertoast.showToast(msg: "Password updation failed");
                  }

                }
              },
              child: const Text('Submit'),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
        ],
      ),
    );
  }
}
