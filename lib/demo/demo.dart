import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:omaliving/screens/forgot_password/forgot_password_screen.dart';
import 'package:omaliving/screens/sign_up/sign_up_screen.dart';

import '../API Services/graphql_service.dart';
import '../constants.dart';

const double borderRadius = 25.0;

class CustomSwitchState extends StatefulWidget {
  @override
  _CustomSwitchStateState createState() => _CustomSwitchStateState();
}

class _CustomSwitchStateState extends State<CustomSwitchState>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int activePageIndex = 0;

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
    return Scaffold(
        body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                child: Text(
                  "Login Account",
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                child: Text(
                  "Hello, welcome back to your account",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: _menuBar(context),
              ),
              Expanded(
                flex: 2,
                child: PageView(
                  controller: _pageController,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (int i) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      activePageIndex = i;
                    });
                  },
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: const SignIn(),
                    ),
                    /* ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: const Center(
                        child: Text("Buy Now"),
                      ),
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    ));
  }

  Widget _menuBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52.0,
      decoration: const BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 5.0),
                // color: Colors.indigo[900],
                borderRadius:
                const BorderRadius.all(Radius.circular(borderRadius)),
              ),
              child: InkWell(
                borderRadius:
                    const BorderRadius.all(Radius.circular(borderRadius)),
                onTap: _onPlaceBidButtonPress,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: (activePageIndex == 0)
                      ? const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(30)),
                        )
                      : null,
                  child: Text(
                    'Email',
                    style: (activePageIndex == 0)
                        ? const TextStyle(color: Colors.grey)
                        : const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          /*  Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
              onTap: _onBuyNowButtonPress,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: (activePageIndex == 1)
                    ? const BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            BorderRadius.all(Radius.circular(borderRadius)),
                      )
                    : null,
                child: Text(
                  "Buy Now",
                  style: (activePageIndex == 1)
                      ? const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)
                      : const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  void _onPlaceBidButtonPress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onBuyNowButtonPress() {
    _pageController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool passwordVisible = false;

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  bool? remember = false;

  GraphQLService graphQLService = GraphQLService();
  final _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn1 = GoogleSignIn();

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  void _handleSignIn() async {
    try {
      _googleSignIn.signIn().then((userData) {
        setState(() {
          // _isLoggedIn = true;
          _userObj = userData!;
        });
      }).catchError((e) {
        print(e);
      });

      Fluttertoast.showToast(msg: _userObj.email);
      Fluttertoast.showToast(msg: _userObj.displayName.toString());
      // User signed in, you can proceed with the app logic
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
            const SizedBox(
              height: 15,
            ),
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
                controller: loginPasswordController,
                obscureText: passwordVisible,
                validator: (val) {
                  if (val!.isEmpty) return 'This is a required field.';
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
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: [
                  Checkbox(
                    value: remember,
                    activeColor: headingColor,
                    onChanged: (value) {
                      setState(() {
                        remember = value;
                      });
                    },
                  ),
                  const Text(
                    'Remember me',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, ForgotPasswordScreen.routeName),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
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
                      borderRadius: BorderRadius.circular(55)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    graphQLService.Login(
                        loginEmailController.text.toString(),
                        loginPasswordController.text.toString(),
                        context); //'maideen.i@gmail.com', 'Magento@123'
                  }
                },
                child: const Text('Login'),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Don’t have an account? '),
                        TextSpan(
                          text: 'Create an Account',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              /*Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/signupscreen',
                                  (Route<dynamic> route) => false);*/
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
                              );
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
                      'Or Sign in with',
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
                          icon: Image.asset(
                            'assets/icons/facebook.png',
                            height: 20,
                          ),
                          iconSize: 0,
                          onPressed: () {},
                        ),
                        label: const Text(
                          'Facebook',
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF345288),
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
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
                          onPressed: () {
                            _handleSignIn();
                          },
                        ),
                        label: const Text(
                          'Google',
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side:
                          const BorderSide(color: Colors.grey, width: 1.0),
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
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
      ),
    );
  }
}