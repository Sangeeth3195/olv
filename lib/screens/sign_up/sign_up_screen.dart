/*import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}*/

import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:omaliving/constants.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import '../../API Services/graphql_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 0),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                      child: Text(
                        "Create a new account",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                      child: Text(
                        "If you have an account, sign in with your email address.",
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.9,
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 10.0, right: 10.0),
                      child: _buildMenuBar(context),
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        physics: const ClampingScrollPhysics(),
                        onPageChanged: (int i) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (i == 0) {
                            setState(() {
                              right = Colors.white;
                              left = Colors.black;
                            });
                          } else if (i == 1) {
                            setState(() {
                              right = Colors.black;
                              left = Colors.white;
                            });
                          }
                        },
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: const SignIn(),
                          ),
                          /*ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: const SignUp(),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: const BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: BubbleIndicatorPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: _onSignInButtonPress,
                child: Text(
                  'Email',
                  style: TextStyle(
                    color: left,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}

class BubbleIndicatorPainter extends CustomPainter {
  BubbleIndicatorPainter(
      {this.dxTarget = 345.0,
      this.dxEntry = 25.0,
      this.radius = 20.0,
      this.dy = 25.0,
      required this.pageController})
      : super(repaint: pageController) {
    painter = Paint()
      ..color = CustomTheme.white
      ..style = PaintingStyle.fill;
  }

  late Paint painter;
  final double dxTarget;
  final double dxEntry;
  final double radius;
  final double dy;

  final PageController pageController;

  @override
  void paint(Canvas canvas, Size size) {
    final ScrollPosition pos = pageController.position;
    final double fullExtent =
        pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension;

    final double pageOffset = pos.extentBefore / fullExtent;

    final bool left2right = dxEntry < dxTarget;
    final Offset entry = Offset(left2right ? dxEntry : dxTarget, dy);
    final Offset target = Offset(left2right ? dxTarget : dxEntry, dy);

    final Path path = Path();
    path.addArc(
        Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
    path.addRect(Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(
        Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);

    canvas.translate(size.width * pageOffset, 0.0);
    canvas.drawShadow(path, CustomTheme.loginGradientStart, 3.0, true);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(BubbleIndicatorPainter oldDelegate) => true;
}

class CustomTheme {
  const CustomTheme();

  static const Color loginGradientStart = Color(0xFFFFFFFF);
  static const Color loginGradientEnd = Color(0xFFFFFFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController loginfullnameController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  GraphQLService graphQLService = GraphQLService();
  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.only(top: 23.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 15.0, right: 0.0),
                child: Text(
                  'Full Name',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, right: 10.0, bottom: 20.0, left: 10.0),
                child: TextFormField(
                  obscureText: false,
                  controller: loginfullnameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'This is a required field.';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 22.0,
                      ),
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0, right: 0.0),
                child: Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, right: 10.0, bottom: 20.0, left: 10.0),
                child: TextFormField(
                  obscureText: false,
                  controller: loginEmailController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'This is a required field.';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
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
              const Padding(
                padding: EdgeInsets.only(left: 15.0, right: 0.0),
                child: Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, right: 10.0, bottom: 5.0, left: 10.0),
                child: TextFormField(
                  obscureText: passwordVisible,
                  controller: loginPasswordController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'This is a required field.';
                    }
                    return null;
                  },
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 22.0,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              /* DefaultButton(
            text: 'Login',
            press: () {},
          ),*/
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, right: 15.0, bottom: 0.0, left: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    backgroundColor: themecolor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(55)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      graphQLService.createuser(
                          loginfullnameController.text.toString(),
                          loginEmailController.text.toString(),
                          loginPasswordController.text.toString(),
                          true);
                    }
                  },
                  child: const Text('Register Now'),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                          TextSpan(
                            text: 'Log In',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed("/loginpage");
                              },
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: headingColor,
                                fontSize: 13.0),
                          ),
                        ],
                      ),
                    )),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[
                              Colors.black12,
                              Colors.black,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 1.0),
                            stops: <double>[0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        'Or Sign up with',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[
                              Colors.black,
                              Colors.black12,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 1.0),
                            stops: <double>[0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, right: 10.0, bottom: 0.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      // Place `Expanded` inside `Row`
                      child: SizedBox(
                        height: 50, // <-- Your height
                        child: ElevatedButton.icon(
                          icon: IconButton(
                            icon: Image.asset('assets/icons/facebook.png',height: 20,),
                            iconSize: 0,
                            onPressed: () {},
                          ),
                          label: const Text(
                            'Facebook',
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF345288),
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontStyle: FontStyle.normal),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {}, // Every button need a callback
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      // Place 2 `Expanded` mean: they try to get maximum size and they will have same size
                      child: SizedBox(
                        height: 50, // <-- Your height
                        child: ElevatedButton.icon(
                          icon: IconButton(
                            icon: Image.asset('assets/icons/google.png'),
                            iconSize: 0,
                            onPressed: () {},
                          ),
                          label: const Text(
                            'Google',
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            side: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontStyle: FontStyle.normal),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeName = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController =
      TextEditingController();

  final emailField = TextField(
    obscureText: false,
    textInputAction: TextInputAction.next,
    style: const TextStyle(fontSize: 14.0, color: Colors.black),
    decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.phone_iphone_outlined,
          color: Colors.grey,
          size: 22.0,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
        hintText: "Mobile Number",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  @override
  void dispose() {
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    focusNodeEmail.dispose();
    focusNodeName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 15.0, right: 0.0),
            child: Text(
              'Phone Number',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 5.0, right: 15.0, bottom: 35.0, left: 15.0),
            child: emailField,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 0.0, right: 15.0, bottom: 0.0, left: 15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
                backgroundColor: themecolor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(55)),
              ),
              onPressed: () {},
              child: const Text('Request OTP'),
            ),
          ),
          const SizedBox(
            height: 35.0,
          ),
          const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Don’t have an account? '),
                    TextSpan(
                      text: 'Create an Account',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: headingColor,
                          fontSize: 14.0),
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 35.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[
                          Colors.black12,
                          Colors.black,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 1.0),
                        stops: <double>[0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    'Or Sign in with',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[
                          Colors.black,
                          Colors.black12,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 1.0),
                        stops: <double>[0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 0.0, right: 10.0, bottom: 0.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  // Place `Expanded` inside `Row`
                  child: SizedBox(
                    height: 50, // <-- Your height
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Facebook',
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF345288),
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontStyle: FontStyle.normal),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {}, // Every button need a callback
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  // Place 2 `Expanded` mean: they try to get maximum size and they will have same size
                  child: SizedBox(
                    height: 50, // <-- Your height
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.save,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Google',
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: const BorderSide(color: Colors.grey, width: 1.5),
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontStyle: FontStyle.normal),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSignUpButton() {
    CustomSnackBar(context, const Text('SignUp button pressed'));
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }
}

class CustomSnackBar {
  CustomSnackBar(BuildContext context, Widget content,
      {Color backgroundColor = Colors.green}) {
    final SnackBar snackBar = SnackBar(
        backgroundColor: backgroundColor,
        content: content,
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
