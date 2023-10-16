import 'package:flutter/material.dart';

import '../../../constants.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 0),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: const EdgeInsets.all(2),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
         // backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            )),
            /*const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.black,
            ),*/
          ],
        ),
      ),
    );
  }
}
