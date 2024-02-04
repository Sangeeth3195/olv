import 'package:flutter/material.dart';
import 'package:omaliving/MainLayout.dart';
import 'package:omaliving/screens/account/Account.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme:
              Theme.of(context).colorScheme.copyWith(primary: colors[2])),
      child: Navigator(
          // key: profileKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const Body();
                break;
              case ProfileEdit.route:
                builder = (BuildContext _) => const ProfileEdit();
                break;
              case '/account':
                builder = (BuildContext _) => const Account();
                break;
              default:
                builder = (BuildContext _) => const UserProfile();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          }),
    );
  }
}
