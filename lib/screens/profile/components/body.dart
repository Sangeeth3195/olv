import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/screens/settings/settings.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Account",
            icon: Icons.person_outline,
            press: () => {},
          ),
          ProfileMenu(
            text: "My Orders",
            icon: Icons.shopping_basket,
            press: () {},
          ),
          ProfileMenu(
            text: "Address",
            icon: Icons.add_business_outlined,
            press: () {},
          ),
          ProfileMenu(
            text: "Information",
            icon: Icons.info_sharp,
            press: () {},
          ),
          ProfileMenu(
            text: "Cart",
            icon: Icons.shopping_cart,
            press: () {},
          ),
          ProfileMenu(
            text: "My Wishlist",
            icon: FontAwesomeIcons.heart,
            press: () {},
          ),
          ProfileMenu(
            text: "Newsletter",
            icon: Icons.email_sharp,
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: Icons.settings,
            press: () {
              print('click');
              Navigator.pushNamed(context, Settings.routeName);
            },
          ),
        ],
      ),
    );
  }
}
