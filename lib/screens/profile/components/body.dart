import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/screens/my_orders/Myorders.dart';
import 'package:omaliving/screens/reset_password/reset_password.dart';
import 'package:omaliving/screens/settings/settings.dart';

import '../../../constants.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ListTile(
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/HEADER.webp'),
            ),
            title: Text(
              //TODO: take from profile info
              'Matilda Brown',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              //TODO: take from profile info
              'matildabrown@gmail.com',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),

            ),
          ),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Account",
            icon: Icons.person_outline,
            press: () => {
              Navigator.of(context, rootNavigator: true).pushNamed("/account"),
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          ProfileMenu(
            text: "My Orders",
            icon: Icons.shopping_basket,
            press: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/myorders");
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          ProfileMenu(
            text: "Address",
            icon: Icons.add_business_outlined,
            press: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/address");
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          ProfileMenu(
            text: "Change Password",
            icon: Icons.password,
            press: () {

              Navigator.of(context, rootNavigator: true).pushNamed("/resetpassword");

            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          ProfileMenu(
            text: "Newsletter",
            icon: Icons.email_sharp,
            press: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed("/newsletter");
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          ProfileMenu(
            text: "Settings",
            icon: Icons.settings,
            press: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/settings");
            },
          ),
        ],
      ),
    );
  }
}
