import 'package:flutter/material.dart';

class RangeSliderTutorial extends StatefulWidget {
  const RangeSliderTutorial({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _RangeSliderTutorialState createState() => _RangeSliderTutorialState();
}

class _RangeSliderTutorialState extends State<RangeSliderTutorial> {
  double start = 0.0;
  double end = 200000.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RangeSlider(
            values: RangeValues(start, end),
            labels: RangeLabels(start.toString(), end.toString()),
            onChanged: (value) {
              setState(() {
                start = value.start;
                end = value.end;
              });
            },
            min: 10.0,
            max: 80.0,
          ),
          Text(
            "Start: " +
                start.toStringAsFixed(2) +
                "\nEnd: " +
                end.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 32.0,
            ),
          ),
        ],
      ),
    );
  }
} 
