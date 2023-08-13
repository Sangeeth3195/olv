import 'package:flutter/material.dart';
import 'package:omaliving/constants.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    Key? key,
    required this.title,
    required this.pressSeeAll,
  }) : super(key: key);
  final String title;
  final VoidCallback pressSeeAll;

  @override
  Widget build(BuildContext context) {
    return
      Center(
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 10.0, 10),
        child: Text(
          title,
          style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
        ),
        ),
        /*TextButton(
          onPressed: pressSeeAll,
          child: const Text(
            "See All",
            style: TextStyle(color: headingColor),
          ),
        )*/
      ],
    ),
    );
  }
}
