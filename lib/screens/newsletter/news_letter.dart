import 'package:flutter/material.dart';

import 'components/body.dart';

class Newsletter extends StatelessWidget {
  static String routeName = "/newsletter";

  const Newsletter({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newsletter Subscription'),
      ),
      body: const Body(),
    );
  }
}
