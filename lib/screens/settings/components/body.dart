import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/screens/order_success/OrderSuccess.dart';
import 'package:omaliving/screens/settings/components/settings_menu.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../order_summary/ordersummary.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          const SizedBox(height: 5),
          SettingsMenu(
            text: "About Us",
            icon: Icons.person_outline,
            press: () => {
              _launchURLBrowser('https://www.omaliving.com/about-us'),
            },
          ),
          SettingsMenu(
            text: "A Life of Beauty",
            icon: Icons.shopping_basket,
            press: () {
              _launchURLBrowser('https://www.omaliving.com/a-life-of-beauty');
            },
          ),
          SettingsMenu(
            text: "Shipping & Payment",
            icon: Icons.add_business_outlined,
            press: () {
              _launchURLBrowser('https://www.omaliving.com/shipping-payment');
            },
          ),
          SettingsMenu(
            text: "Returns & Exchanges",
            icon: Icons.info_sharp,
            press: () {
              _launchURLBrowser('https://www.omaliving.com/returns-exchanges');
            },
          ),
          SettingsMenu(
            text: "Terms of Use",
            icon: Icons.shopping_cart,
            press: () {
              _launchURLBrowser('https://www.omaliving.com/terms-of-use');
            },
          ),
          SettingsMenu(
            text: "Privacy Policy",
            icon: FontAwesomeIcons.heart,
            press: () {
              _launchURLBrowser('https://www.omaliving.com/privacy-policy');
            },
          ),
          SettingsMenu(
            text: "Logout",
            icon: Icons.logout_rounded,
            press: () {
              /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const OrderSuccess()));*/
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Ordersummary()));
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Version 1.0',
            style: TextStyle(fontSize: 14.0, color: Colors.black45),
          )
        ],
      ),
    );
  }

  /*_launchURLBrowser(String _url) async {
    final url = _url;
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }*/

  _launchURLBrowser(String _url) async {
    final url = Uri.parse(_url);
    try {
      await launch(
        _url,
        enableJavaScript: true,
      );
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
