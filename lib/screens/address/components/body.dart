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
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: const <Widget>[
          ListTile(
            title: Text(
              'Home',
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              '#123, Lorem Ipsum, Mumbai',
              style: TextStyle(fontSize: 13),
            ),
            trailing: SizedBox(
              width: 46,
              child: Expanded(
                // Place `Expanded` inside `Row`
                child: Row(
                  children: [
                    Text(
                      'Edit |',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      size: 14,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Home',
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              '#123, Lorem Ipsum, Mumbai',
              style: TextStyle(fontSize: 13),
            ),
            trailing: SizedBox(
              width: 46,
              child: Expanded(
                // Place `Expanded` inside `Row`
                child: Row(
                  children: [
                    Text(
                      'Edit |',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      size: 14,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Home',
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              '#123, Lorem Ipsum, Mumbai',
              style: TextStyle(fontSize: 13),
            ),
            trailing: SizedBox(
              width: 46,
              child: Expanded(
                // Place `Expanded` inside `Row`
                child: Row(
                  children: [
                    Text(
                      'Edit |',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      size: 14,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
