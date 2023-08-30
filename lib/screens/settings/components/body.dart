import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/screens/order_success/OrderSuccess.dart';
import 'package:omaliving/screens/settings/components/settings_menu.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../order_summary/ordersummary.dart';
import '../../webview/WebView.dart';
import '../../webview/WebViewGQL.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          const SizedBox(height: 0),
          SettingsMenu(
            text: "About Us",
            icon: Icons.person_outline,
            press: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommonWebViewGraphql())),
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          SettingsMenu(
            text: "A Life of Beauty",
            icon: Icons.shopping_basket,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommonWebView(
                          url: "https://www.omaliving.com/a-life-of-beauty",
                          title: "A Life of Beauty")));
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          SettingsMenu(
            text: "Shipping & Payment",
            icon: Icons.add_business_outlined,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommonWebView(
                          url: "https://www.omaliving.com/shipping-payment",
                          title: "Shipping & Payment")));
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          SettingsMenu(
            text: "Returns & Exchanges",
            icon: Icons.info_sharp,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommonWebView(
                          url: "https://www.omaliving.com/returns-exchanges",
                          title: "Returns & Exchanges")));
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          SettingsMenu(
            text: "Terms of Use",
            icon: Icons.shopping_cart,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommonWebView(
                          url: "https://www.omaliving.com/terms-of-use",
                          title: "Terms of Use")));
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          SettingsMenu(
            text: "Privacy Policy",
            icon: FontAwesomeIcons.heart,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommonWebView(
                          url: "https://www.omaliving.com/privacy-policy",
                          title: "Privacy Policy")));
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          SettingsMenu(
            text: "Logout",
            icon: Icons.logout_rounded,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const OrderSuccess()));
            },
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Text(
            'Version 1.0',
            style: TextStyle(fontSize: 12.0, color: Colors.black),
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
