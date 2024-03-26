import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/CustomerModel.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:omaliving/screens/settings/components/settings_menu.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../API Services/graphql_service.dart';
import '../../../demo/btm.dart';
import '../../../demo/slider.dart';
import '../../webview/WebViewGQL.dart';
import '../../webview/Webview_dyn.dart';

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
                      builder: (context) => const Webview_Dyn(
                          url: 'https://www.omaliving.com/about-us', title: 'About Us'))),///url: 'about-us', title: 'About Us'
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
                      builder: (context) => const Webview_Dyn(
                          url: 'https://www.omaliving.com/a-life-of-beauty', title: 'A Life of Beauty')));
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
                      builder: (context) => const Webview_Dyn(
                          url: 'https://www.omaliving.com/shipping-payment',
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
                      builder: (context) => const Webview_Dyn(
                          url: 'https://www.omaliving.com/returns-exchanges',
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
                      builder: (context) => const Webview_Dyn(
                          url: 'https://www.omaliving.com/terms-of-use', title: 'Terms of Use')));
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
                      builder: (context) => const Webview_Dyn(
                          url: 'https://www.omaliving.com/privacy-policy', title: 'Privacy Policy')));
            },
          ),
          /*const Padding(
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
                      builder: (context) => const Ordersummary()));
            },
          ),*/
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
            style: TextStyle(
                // fontSize: 12.0,
                // color: navTextColor
              fontFamily: 'Gotham',
              fontWeight: FontWeight.w500,
              color: navTextColor,
              fontSize: 11.0,
            ),
          )
        ],
      ),
    );
  }
}
