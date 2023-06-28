import 'package:flutter/material.dart';

import 'components/body.dart';

class WebView extends StatelessWidget {
  static String routeName = "/webview";

  const WebView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
