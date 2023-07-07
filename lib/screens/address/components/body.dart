import 'package:flutter/material.dart';
import 'package:omaliving/constants.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pushNamed("/addaddress");
        },
        backgroundColor: headingColor,
        child: const Icon(Icons.add),
      ),
    );

  }
}
