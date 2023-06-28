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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Text(
              text,
              style: const TextStyle(
                  color: headingColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            )),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: headingColor,
            ),
          ],
        ),
      ),
    );
  }
}
