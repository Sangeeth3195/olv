import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/MainLayout.dart';
import 'package:omaliving/screens/settings/settings.dart';

import 'profile_menu.dart' as pmenu;
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // const ProfilePic(),
          const SizedBox(height: 20),
          pmenu.ProfileMenu(
            text: "Account",
            icon: Icons.person_outline,
            press: () => {
              navigate(context, '/account',
                  isRootNavigator: false,
                  arguments: {'id': '1'})

              // Navigator.of(context, rootNavigator: true).pushNamed("/account"),
            },
          ),
          pmenu.ProfileMenu(
            text: "My Orders",
            icon: Icons.shopping_basket,
            press: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/myorders");
            },
          ),
          pmenu.ProfileMenu(
            text: "Address",
            icon: Icons.add_business_outlined,
            press: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/address");
            },
          ),
          pmenu.ProfileMenu(
            text: "Information",
            icon: Icons.info_sharp,
            press: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/information");
            },
          ),
          pmenu.ProfileMenu(
            text: "Cart",
            icon: Icons.shopping_cart,
            press: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/CartScreen");
            },
          ),
          pmenu.ProfileMenu(
            text: "My Wishlist",
            icon: FontAwesomeIcons.heart,
            press: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/wishlist");
            },
          ),
          pmenu.ProfileMenu(
            text: "Newsletter",
            icon: Icons.email_sharp,
            press: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/newsletter");
            },
          ),
          pmenu.ProfileMenu(
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
