import 'package:flutter/material.dart';

class TST extends StatefulWidget {
  const TST({Key? key}) : super(key: key);

  @override
  State<TST> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TST> {

  @override
  void initState() {
    super.initState();
  }

  Future splitInput() async {

    const tagName = 'category_id=1234&oma_collection=7794&brands=456&show_collection=0';

    final split = tagName.split('&');
    final Map<int, String> values = {
      for (int i = 0; i < split.length; i++)
        i: split[i]
    };

    print(values);

    final value1 = values[0];
    final value2 = values[1];
    final value3 = values[2];
    final value4 = values[3];

    print(value1.toString());
    print(value2);
    print(value3);
    print(value4);

     final split1 = value1.toString().split('=');
     print(split1[1]);

     final split2 = value2.toString().split('=');
     print(split2[1]);

     final split3 = value3.toString().split('=');
     print(split3[1]);

     final split4 = value4.toString().split('=');
     print(split4[1]);

    /*
    String input = "category_id=1234&oma_collection=7794&brands=456";
    String firstPart = input.substring(0, 15);
    String secondPart = input.substring(0, 36);
    String thirdPart = input.substring(0, 45);

    var str = firstPart;
    var parts = str.split('=');
    var prefix = parts[1].trim();
    var date = parts.sublist(1).join(':').trim();

    String skip_1 = prefix;
    
    print("First part: $firstPart");
    print("First part 1: $skip_1");
    print("Second part: $secondPart");
    print("Third part: $thirdPart");*/

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child:
      TextButton(
        onPressed: () {
          splitInput();
        },
        child: Container(
          color: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: const Text(
            'Flat Button',
            style: TextStyle(color: Colors.white, fontSize: 13.0),
          ),
        ),
      ),
    );
  }
}
