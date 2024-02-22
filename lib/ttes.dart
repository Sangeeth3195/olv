import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class TESTBody extends StatefulWidget {
  const TESTBody({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<TESTBody> {

  var FruitList = ['Coconut','Grapes','Apple','Banana','Cherry'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CarouselSlider(
            options: CarouselOptions(
              height:  350,
              autoPlay: true,
              enlargeCenterPage: false,
              viewportFraction: 0.5,
              aspectRatio: 0.5,
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {

                });
              },
            ),
            items: ['assets/images/product_1.png','assets/images/product_2.png',
              'assets/images/product_1.png','assets/images/product_1.png','assets/images/product_1.png'].map((i) {
              return Builder(
                  builder : (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin : const EdgeInsets.symmetric(horizontal: 5.0),

                      child: Column(
                        children: [
                          Image.asset(i),
                          const SizedBox( height:  10,),
                          if(i == 'assets/images/product_1.png')
                            Text(FruitList[0], style:  const TextStyle( fontSize: 15, fontWeight: FontWeight.w800),),
                          if(i == 'assets/images/product_2.png')
                            Text(FruitList[1], style:  const TextStyle( fontSize: 15, fontWeight: FontWeight.w800),),
                          if(i == 'assets/images/product_1.png')
                            Text(FruitList[2], style:  const TextStyle( fontSize: 15, fontWeight: FontWeight.w800),),
                          if(i == 'assets/images/product_1.png')
                            Text(FruitList[3], style:  const TextStyle( fontSize: 15, fontWeight: FontWeight.w800),),
                          if(i == 'assets/images/product_1.png')
                            Text(FruitList[4], style:  const TextStyle( fontSize: 15, fontWeight: FontWeight.w800),),
                        ],
                      ),

                    );
                  }
              );
            }).toList(),

          ),
        ),
      ),
    );
  }
}