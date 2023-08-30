import 'package:flutter/material.dart';
import 'package:omaliving/components/default_button.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                  const SizedBox(width: 5),

                ],
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.all(15),
                child: DefaultButton(
                  text: 'Save',
                  press: () {


                  },
                ),
              ),  //Row
            ],
          ), //Column
          //SizedBox
        ), //Padding
      ), //Card
    );
  }
}
