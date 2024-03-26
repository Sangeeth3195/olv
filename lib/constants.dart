import 'package:flutter/material.dart';
import 'package:omaliving/components/size_config.dart';


const Color primaryColor = Color(0xFFF67952);
const Color bgColor = Color(0xFFFBFBFD);
const Color tileColor = Color(0xFFEFEEEC);
const Color textColor = Color(0xFF6D6861);
const Color priceColor = Color(0xFF554C48);
const Color headingColor = Color(0xFF8c7359);
const Color filter = Color(0xFFFFF1E0);
const Color bg_color = Color(0xFFF5F3F0);
const Color themecolor = Color(0xFF8D7557);
const Color searchBackgroundColor = Color(0xFFE3E1DF);
const Color omaColor = Color(0xFFF6F4F2);
const Color blackColor = Color(0xFF000000);
const Color chipColor = Color(0xFFB09F8C);
const Color chip2Color = Color(0xFFEBE1D9);
const Color navBackground = Color(0xFFF6F6F4);
const Color navTextColor = Color(0xFF7F7671);
const Color backgroundCategoryColor = Color(0xFFEDEBE7);
const Color productDescribtionColor = Color(0xFFF7F7F7);
const Color headingFontColor = Color(0xFF5B5559);
const Color quantitityBackgroundColor = Color(0xFF8c7359);
const Color headingTextColor = Color(0xFF534335);
const Color describtionTextColor = Color(0xFF524941);

const double defaultPadding = 16.0;
const double defaultBorderRadius = 5.0;


const kPrimaryColor = Color(0xFF6D6861);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}
