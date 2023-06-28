import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/screens/settings/components/settings_menu.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          SettingsMenu(
            text: "Account",
            icon: Icons.person_outline,
            press: () => {},
          ),
          SettingsMenu(
            text: "My Orders",
            icon: Icons.shopping_basket,
            press: () {},
          ),
          SettingsMenu(
            text: "Address",
            icon: Icons.add_business_outlined,
            press: () {},
          ),
          SettingsMenu(
            text: "Information",
            icon: Icons.info_sharp,
            press: () {},
          ),
          SettingsMenu(
            text: "Cart",
            icon: Icons.shopping_cart,
            press: () {},
          ),
          SettingsMenu(
            text: "My Wishlist",
            icon: FontAwesomeIcons.heart,
            press: () {},
          ),
          SettingsMenu(
            text: "Newsletter",
            icon: Icons.email_sharp,
            press: () {},
          ),
          SettingsMenu(
            text: "Settings",
            icon: Icons.settings,
            press: () {},
          ),
          SettingsMenu(
            text: "Logout",
            icon: Icons.logout_rounded,
            press: () {},
          ),
        ],
      ),
    );
  }
}
