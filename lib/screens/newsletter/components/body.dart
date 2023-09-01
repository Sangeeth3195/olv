import 'package:flutter/material.dart';
import 'package:omaliving/components/default_button.dart';

import '../../../API Services/graphql_service.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  GraphQLService graphQLService = GraphQLService();

  bool isChecked = false;

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
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                        print(isChecked);
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

                    print(isChecked);

                    graphQLService.subscribenewsletter('');

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

  void checkBoxCallBack(bool? checkBoxState) {
    if (checkBoxState != null) {
      setState(() {
        isChecked = checkBoxState ?? true;
      });
    }
  }

}
