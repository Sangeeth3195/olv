import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/models/CustomerModel.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:omaliving/screens/settings/components/settings_menu.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../API Services/graphql_service.dart';
import '../../webview/WebViewGQL.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GraphQLService graphQLService = GraphQLService();
  dynamic revokeloggedinuser = [];

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
                      builder: (context) => const CommonWebViewGraphql(
                          url: 'about-us', title: 'About Us'))),
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
          ),
          SettingsMenu(
            text: "A Life of Beauty",
            icon: Icons.shopping_basket,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommonWebViewGraphql(
                          url: 'a-life-of-beauty', title: 'A Life of Beauty')));
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
          ),
          SettingsMenu(
            text: "Shipping & Payment",
            icon: Icons.add_business_outlined,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommonWebViewGraphql(
                          url: 'shipping-payment',
                          title: 'Shipping & Payment')));
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
          ),
          SettingsMenu(
            text: "Returns & Exchanges",
            icon: Icons.info_sharp,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommonWebViewGraphql(
                          url: 'returns-exchanges',
                          title: 'Returns & Exchanges')));
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
          ),
          SettingsMenu(
            text: "Terms of Use",
            icon: Icons.shopping_cart,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommonWebViewGraphql(
                          url: 'terms-of-use', title: 'Terms of Use')));
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
          ),
          SettingsMenu(
            text: "Privacy Policy",
            icon: FontAwesomeIcons.heart,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommonWebViewGraphql(
                          url: 'privacy-policy', title: 'Privacy Policy')));
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
          ),
          SettingsMenu(
            text: "Logout",
            icon: Icons.logout_rounded,
            press: () async {
             MyProvider myProvider = Provider.of<MyProvider>(context, listen: false);

             myProvider.customerModel=CustomerModel();
             myProvider.getuserdata();
              revokeloggedinuser = await graphQLService.revokeuser(context);
              SharedPreferences preferences = await SharedPreferences.getInstance();
              await preferences.clear();
            },
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Text(
            'Version 1.0',
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
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

  // _launchURLBrowser(String url) async {
  //   final url = Uri.parse(url);
  //   try {
  //     await launch(
  //       url,
  //       enableJavaScript: true,
  //     );
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }
}
