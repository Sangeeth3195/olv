import 'package:flutter/material.dart';

import 'components/body.dart';

class Newsletter extends StatelessWidget {
  static String routeName = "/newsletter";

  const Newsletter({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Newsletter Subscription',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Body(),
    );
  }
}
