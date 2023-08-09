import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(0)),
  borderSide: BorderSide(
    color: tileColor,
    width: 2.0,
  ),
);

class SearchForm extends StatelessWidget {
  const SearchForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Form(
        child: TextFormField(
          onSaved: (value) {},
          style: const TextStyle(fontSize: 16),
          autofocus: false,

          focusNode: FocusNode(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(color: Colors.black),
            hintText: "what are you looking for",
            border: outlineInputBorder,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            focusedBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            suffixIcon: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      print('mic button pressed');
                    },
                    icon: const Icon(Icons.mic,color: Colors.black,),
                  ),
                  IconButton(
                    onPressed: () {
                      print('search button pressed');
                    },
                    /*icon: SvgPicture.asset(
                      "assets/icons/Search.svg",
                      color: Colors.black,
                      height: 20,
                      width: 20,
                    ),*/
                    icon: const Icon(Icons.search,color: Colors.black,),
                  ),
                ],
              ),
            ),

            /*Padding(
              padding: const EdgeInsets.all(15),
              child: SvgPicture.asset("assets/icons/Search.svg",
                  color: Colors.black),
            ),*/
          ),
        ),
      ),
    );
  }
}
