import 'package:flutter/material.dart';

import 'components/body.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  static String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
