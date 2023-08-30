import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: kPrimaryColor,
                padding: const EdgeInsets.all(10),
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                // backgroundColor: const Color(0xFFF5F6F9),
              ),

              onPressed: () {  },
              child: const Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    color: Colors.black,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        'text',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      )),
                  /*const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: headingColor,
            ),*/
                ],
              ),
            ),
          )
         /* const CircleAvatar(
            backgroundImage: AssetImage("assets/images/Profile_Image.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )*/
        ],
      ),
    );
  }
}
