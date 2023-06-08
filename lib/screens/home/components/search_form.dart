import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';


const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(0)),
  borderSide: BorderSide(
    color: tileColor,
    width: 2.0,
  ),);

class SearchForm extends StatelessWidget {
  const SearchForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        color: tileColor,
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(

          onSaved: (value) {},
          decoration: InputDecoration(
            filled: true,

            fillColor: Colors.white,
            hintStyle: TextStyle(color: headingColor),
            hintText: "what are you looking for",
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset("assets/icons/Search.svg",color: headingColor),
            ),
            // suffixIcon: Padding(
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: defaultPadding, vertical: defaultPadding / 2),
            //   child: SizedBox(
            //     width: 48,
            //     height: 48,
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         primary: primaryColor,
            //         shape: const RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(12)),
            //         ),
            //       ),
            //       onPressed: () {},
            //       child: SvgPicture.asset("assets/icons/Filter.svg"),
            //     ),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
