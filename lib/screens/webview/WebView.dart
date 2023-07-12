import 'package:flutter/material.dart';

import 'components/body.dart';

class Webview extends StatelessWidget {
  static String routeName = "/webview";

  const Webview({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
