import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:omaliving/MainLayout.dart';
import 'package:omaliving/screens/my_orders/Myorders.dart';
import 'package:omaliving/screens/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../API Services/graphql_service.dart';
import '../../../models/CustomerModel.dart';
import 'profile_menu.dart' as pmenu;
import 'profile_pic.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CustomerModel customerModel = CustomerModel();
  GraphQLService graphQLService = GraphQLService();

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    customerModel = await graphQLService.get_customer_details();
    print(customerModel.customer?.addresses?.length);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('emailid', customerModel.customer!.email!);

    setState(() {
      _firstnameController.text = customerModel.customer?.firstname ?? '';
      _emailController.text = customerModel.customer?.email ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // const ProfilePic(),
          const SizedBox(height: 0),

          ListTile(
            leading: const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/photo.jpg'),
            ),
            title: Text(
              //TODO: take from profile info
              customerModel.customer?.firstname ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              //TODO: take from profile info
              customerModel.customer?.email ?? '',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 20),
          pmenu.ProfileMenu(
            text: "Account",
            icon: Icons.person_outline,
            press: () => {
              navigate(context, '/account',
                  isRootNavigator: true, arguments: {'id': '1'})

              // Navigator.of(context, rootNavigator: true).pushNamed("/account"),
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),

          /*   pmenu.ProfileMenu(
            text: "Account",
            icon: Icons.person_outline,
            press: () => {
              navigate(context, '/account',
                  isRootNavigator: false,
                  arguments: {'id': '1'})

              // Navigator.of(context, rootNavigator: true).pushNamed("/account"),
            },
          ),*/
          /*  const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),*/

          pmenu.ProfileMenu(
            text: "My Orders",
            icon: Icons.shopping_basket,
            press: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/myorders");
              /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyOrders()));*/
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),

          pmenu.ProfileMenu(
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
          /*pmenu.ProfileMenu(
            text: "Information",
            icon: Icons.info_sharp,
            press: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/information");
            },
          ),*/
          /* pmenu.ProfileMenu(
            text: "Cart",
            icon: Icons.shopping_cart,
            press: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/CartScreen");
            },
          ),*/
          pmenu.ProfileMenu(
            text: "Change Password",
            icon: Icons.password,
            press: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed("/resetpassword");
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
          pmenu.ProfileMenu(
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
