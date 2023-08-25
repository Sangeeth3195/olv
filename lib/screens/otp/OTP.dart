import 'package:flutter/material.dart';

import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {

  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: const Body(),
    );
  }
}
