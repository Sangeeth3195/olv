import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;


class FBLoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<FBLoginPage> {
  bool isLoggedIn = false;
  var profileData;

  var facebookLogin = FacebookLogin();

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Facebook Login"),
        ),
        body: Center(
          child: isLoggedIn
              ? _displayUserData(profileData)
              : _displayLoginButton(),
        ),
      ),
    );
  }

  void loginButtonClicked() async {

    print('profile.toString()');


    var facebookLoginResult =
    await facebookLogin.logIn(customPermissions: ['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancel:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.success:
        var graphResponse = await http.get(
            Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult
                .accessToken?.token}'));

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        onLoginStatusChanged(true, profileData: profile);
        break;
    }
  }

  _displayUserData(profileData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                profileData['picture']['data']['url'],
              ),
            ),
          ),
        ),
        const SizedBox(height: 28.0),
        Text(
          "Name: ${profileData['name']}",
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
        Text(
          "Email: ${profileData['email']}",
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
        ElevatedButton(
          child: const Text("Logout"),
          onPressed: () => facebookLogin.isLoggedIn
              .then((isLoggedIn) => isLoggedIn ? _logout() : {}),
        )
      ],
    );
  }

  _displayLoginButton() {
    return ElevatedButton(
      child: const Text("Login with Facebook"),
      onPressed: () => loginButtonClicked(),
    );
  }

  _logout() async {
    await facebookLogin.logOut();
    onLoginStatusChanged(false);
    print("Logged out");
  }
}