import 'package:flutter/material.dart';

import 'components/body.dart';

class Information extends StatelessWidget {
  static String routeName = "/information";

  const Information({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
