import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

class Imageviewth extends StatefulWidget {
  Imageviewth({Key? key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<Imageviewth> {
  List<ImageProvider> imageList = <ImageProvider>[];
  bool autoRotate = false;
  int rotationCount = 2;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = const Duration(milliseconds: 50);
  bool imagePrecached = false;

  @override
  void initState() {
    //* To load images from assets after first frame build up.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateImageList(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (imagePrecached == true)
                    ? ImageView360(
                        key: UniqueKey(),
                        imageList: imageList,
                        autoRotate: autoRotate,
                        rotationCount: rotationCount,
                        rotationDirection: RotationDirection.anticlockwise,
                        frameChangeDuration: const Duration(milliseconds: 30),
                        swipeSensitivity: swipeSensitivity,
                        allowSwipeToRotate: allowSwipeToRotate,
                        onImageIndexChanged: (currentImageIndex) {
                          print("currentImageIndex: $currentImageIndex");
                        },
                      )
                    : const Text("Pre-Caching images..."),
                /*const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Optional features:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("Auto rotate: $autoRotate"),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("Rotation count: $rotationCount"),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("Rotation direction: $rotationDirection"),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                      "Frame change duration: ${frameChangeDuration.inMilliseconds} milliseconds"),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child:
                  Text("Allow swipe to rotate image: $allowSwipeToRotate"),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("Swipe sensitivity: $swipeSensitivity"),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateImageList(BuildContext context) async {
    for (int i = 1; i <= 19; i++) {
      imageList.add(AssetImage('assets/imageview/$i.png'));
      //* To precache images so that when required they are loaded faster.
      await precacheImage(AssetImage('assets/imageview/$i.png'), context);
    }
    setState(() {
      imagePrecached = true;
    });
  }
}
