import 'package:flutter/material.dart';
import 'package:omaliving/constants.dart';

import '../../../API Services/graphql_service.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  GraphQLService graphQLService = GraphQLService();

  @override
  void initState() {
    super.initState();
    graphQLService.get_customer_details();
  }

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
