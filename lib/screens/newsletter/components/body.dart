import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Checkbox(
                    value: value,
                    onChanged: (value) {
                      setState(() {
                        value = value;
                      });
                    },
                  ),
                  const Text(
                    'Subscribe to Promotional Emails',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(width: 10), //SizedBox
                ],
              ), //Row
            ],
          ), //Column
          //SizedBox
        ), //Padding
      ), //Card
    );
  }
}
