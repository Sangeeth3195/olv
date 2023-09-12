import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/screens/forgot_password/forgot_password_screen.dart';
import 'package:omaliving/screens/sign_up/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API Services/graphql_service.dart';
import 'models/CustomerModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
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
                            child: const SignUp(),
                          ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  void _onPlaceBidButtonPress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      decoration: const BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
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
                    const BorderRadius.all(Radius.circular(0)),
              ),
              child: InkWell(
                borderRadius:
                    const BorderRadius.all(Radius.circular(0)),
                onTap: _onPlaceBidButtonPress,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: (activePageIndex == 0)
                      ? const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        )
                      : null,
                  child: Text(
                    'Email',
                    style: (activePageIndex == 0)
                        ? const TextStyle(color: Colors.black)
                        : const TextStyle(color: Colors.black),
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

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
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
  CustomerModel customerModel = CustomerModel();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  bool? remember = false;
  bool isLoggedIn = false;
  var profileData;

  GraphQLService graphQLService = GraphQLService();
  final _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  late GoogleSignInAccount _userObj;

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

 /* Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }*/

  void _handleGoogleSignIn() async {
    try {
      _googleSignIn.signIn().then((userData) {
        setState(() {
          // _isLoggedIn = true;
          _userObj = userData!;
        });
      }).catchError((e) {
        print(e);
      });

      print(_userObj.email.toString());
      print(_userObj.displayName.toString());
      print(_userObj.id.toString());

      graphQLService.Social_Login(
          _userObj.displayName.toString(),
          _userObj.displayName.toString(),
          _userObj.email.toString(),
          _userObj.id,
          true,
          context);

      // User signed in, you can proceed with the app logic
    } catch (error) {
      if (kDebugMode) {
        print('Error signing in: $error');
      }
    }
  }

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  /*void _handleFBSignIn() async {
    try {

      var facebookLoginResult =
      await facebookLogin.logInWithReadPermissions(['email']);

      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.error:
          onLoginStatusChanged(false);
          break;
        case FacebookLoginStatus.cancel:
          onLoginStatusChanged(false);
          break;
        case FacebookLoginStatus.success:
          var graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(400)&access_token=${facebookLoginResult
                  .accessToken.token}');

          var profile = json.decode(graphResponse.body);
          print(profile.toString());

          onLoginStatusChanged(true, profileData: profile);
          break;
      }

      // User signed in, you can proceed with the app logic
    } catch (error) {
      if (kDebugMode) {
        print('Error signing in: $error');
      }
    }
  }*/

  void getuserdata() async {
    customerModel = await graphQLService.get_customer_details();

    print('customerModel length');
    print(customerModel.customer?.addresses?.length);

    print(customerModel.customer!.wishlists![0].id!);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('wishlist_id', customerModel.customer!.wishlists![0].id!);
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
                  fontSize: 13.0,
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
                      size: 18.0,
                    ),
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 0.0),
                    hintText: "Email",
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0))),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 0.0),
              child: Text(
                'Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
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
                        size: 18.0,
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
                        const EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 0.0),
                    hintText: "Password",
                    hintStyle: const TextStyle(fontSize: 13), // you need this
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 15.0),
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
                    style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.w600,color: Colors.black54),
                  ),
                  const Spacer(),
                  GestureDetector(
                    /*onTap: () => Navigator.pushNamed(
                        context, ForgotPasswordScreen.routeName),*/

                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen()),
                      );
                    },

                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(fontSize: 13.0,color: headingColor,fontWeight: FontWeight.w600),
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
                      borderRadius: BorderRadius.circular(0)),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String result;
                    result = await graphQLService.Login(
                        loginEmailController.text.toString(),
                        loginPasswordController.text.toString(),
                        context);

                    if (result == "200") {
                      EasyLoading.dismiss();
                      getuserdata();
                    } else {
                      EasyLoading.dismiss();
                    }
                  }
                },
                child: const Text('Login'),
              ),
            ),
            const SizedBox(
              height: 35.0,
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Don’t have an account? ',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
                        TextSpan(
                          text: 'Create an Account',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
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
                        fontWeight: FontWeight.w600,
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
                        icon: Image.asset(
                          'assets/icons/facebook.png',
                          height: 20,
                        ),
                        label: const Text(
                          'Facebook',
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF345288),
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontStyle: FontStyle.normal),
                          // shape: const StadiumBorder(),
                        ),
                        onPressed: () {

                          /*signInWithFacebook();*/

                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      FBOOK()));*/

                        }, // Every button need a callback
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
                      child: GestureDetector(
                        onTap: () {
                          // _handleSignIn();
                        },
                        child: ElevatedButton.icon(
                          icon: Image.asset('assets/icons/google.png'),
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
                                fontSize: 14,
                                fontStyle: FontStyle.normal),
                            // shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            _handleGoogleSignIn();
                          },
                        ),
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

class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }

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
    style: const TextStyle(fontSize: 12.0),
    obscureText: false,
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
        hintText: "Enter Your Mobile Number",
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
      padding: const EdgeInsets.only(top: 23.0),
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
                fontSize: 15.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, right: 15.0, bottom: 35.0, left: 15.0),
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
          const Center(
            child: Padding(
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
          ),
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
