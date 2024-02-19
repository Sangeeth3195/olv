import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../API Services/graphql_service.dart';
import '../../../models/CustomerModel.dart';
import '../../provider/provider.dart';
import 'profile_menu.dart' as pmenu;

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CustomerModel customerModel = CustomerModel();
  GraphQLService graphQLService = GraphQLService();
  MyProvider? myProvider;
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    myProvider = Provider.of<MyProvider>(context, listen: false);

    myProvider!.getuserdata();
    customerModel = await graphQLService.get_customer_details();
    print(customerModel.customer?.addresses?.length);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('emailid', customerModel.customer!.email!);

    var cartToken = prefs.getString('first_name');

    print(cartToken);


    setState(() {
      var cartToken = prefs.getString('first_name');

      print(cartToken);
      _firstnameController.text = customerModel.customer?.firstname ?? '';
      _emailController.text = customerModel.customer?.email ?? '';
    });

    myProvider!.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, _) {
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
                  '${provider.customerModel.customer?.firstname}'
                          ' ${provider.customerModel.customer?.lastname}' ??
                      '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "Gotham",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  //TODO: take from profile info
                  provider.customerModel.customer?.email ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Gotham",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              pmenu.ProfileMenu(
                text: "Account",
                icon: Icons.person_outline,
                press: () => {
                  context.go('/profile/account')
                  // navigate(context, '/account',
                  //     isRootNavigator: true, arguments: {'id': '1'})

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

              pmenu.ProfileMenu(
                text: "My Orders",
                icon: Icons.shopping_basket,
                press: () {
                  context.go('/profile/myorders');

                  // Navigator.of(context, rootNavigator: true)
                  //     .pushNamed("/myorders");
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
                text: "Wishlist",
                icon: Icons.favorite,
                press: () {
                  context.go('/profile/wishlist');

                  /* Navigator.of(context, rootNavigator: true)
                      .pushNamed("/address");*/
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
                  context.go('/profile/address');

                  /* Navigator.of(context, rootNavigator: true)
                      .pushNamed("/address");*/
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
                  context.go('/profile/resetpassword');

                  /* Navigator.of(context, rootNavigator: true)
                      .pushNamed("/resetpassword");*/
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
                  context.go('/profile/news');

                  /* Navigator.of(context, rootNavigator: true)
                      .pushNamed("/newsletter");*/
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
                  context.go('/profile/settings');

                  /*Navigator.of(context, rootNavigator: true)
                      .pushNamed("/settings");*/
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
