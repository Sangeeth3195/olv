import 'package:flutter/material.dart';

import '../constants.dart';
import 'size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(14)),
        ),
        GestureDetector(
          onTap: (){
            Navigator.of(context, rootNavigator: true).pushNamed("/signupscreen");
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
