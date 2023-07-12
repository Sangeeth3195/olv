import 'package:flutter/material.dart';
import '../../../components/no_account_text.dart';
import '../../../components/socal_card.dart';
import '../../../components/size_config.dart';
import 'sign_form.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                Text(
                  "Welcome to OMA ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(25),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.2,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                const SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    SocalCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(25)),
                const NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
