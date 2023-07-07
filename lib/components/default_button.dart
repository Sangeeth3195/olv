import 'package:flutter/material.dart';

import '../../constants.dart';
import 'size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(40),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white, shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
          backgroundColor: headingColor,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(15),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
