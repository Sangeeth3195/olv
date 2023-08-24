import 'package:flutter/material.dart';
import 'package:omaliving/screens/forgot_password/forgot_password_screen.dart';
import 'package:omaliving/screens/reset_password/reset_password.dart';

import '../../../API Services/graphql_service.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../components/no_account_text.dart';
import '../../../constants.dart';
import '../../../components/default_button.dart';
import '../../../components/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

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
                child: Image.asset('assets/images/forgotpassword.png',
                    height: 200, width: 200),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 20.0, 10.0, 0),
                child: Text(
                  "Forgot Password",
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
                  "Email",
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
  TextEditingController loginEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 0.0, right: 10.0, bottom: 20.0, left: 10.0),
            child: TextFormField(
              controller: loginEmailController,
              obscureText: false,
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val!.isEmpty) return 'This is a required field.';
                return null;
              },
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
              decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                    size: 22.0,
                  ),
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0))),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(
                top: 0.0, right: 10.0, bottom: 0.0, left: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: themecolor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(55)),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  graphQLService.resetpassword(loginEmailController.text.toString(),context);
                }
              },
              child: const Text('Submit'),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don’t have an account? ",
                style: TextStyle(fontSize: getProportionateScreenWidth(14)),
              ),
              GestureDetector(
                onTap: (){
                  /*Navigator.of(context, rootNavigator: true).pushNamed("/signupscreen");*/
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ResetPassword()),
                    );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kPrimaryColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
