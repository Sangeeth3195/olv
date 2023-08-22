import 'package:flutter/material.dart';
import 'package:omaliving/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Card(
                color: Colors.grey[200],
                // Define the shape of the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                // Define how the card's content should be clipped
                clipBehavior: Clip.antiAliasWithSaveLayer,
                // Define the child widget of the card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Add padding around the row widget
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Add an image widget to display an image

                          // Add an expanded widget to take up the remaining horizontal space
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Add some spacing between the top of the card and the title
                                Container(height: 5),
                                // Add a title widget
                                const Text("Cards Title 1",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87,
                                        fontSize: 16)),
                                // Add some spacing between the title and the subtitle
                                Container(height: 15),
                                const Text('5 New Collections',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: headingColor,
                                        fontSize: 10)),
                              ],
                            ),
                          ),

                          const Image(
                            image: NetworkImage(
                                'https://www.omaliving.com/media/catalog/product/cache/0141941aeb4901c5334e6ba10ea3844d/I/T/ITEM-007993_3_1.png'),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          // Add some spacing between the image and the text
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Card(
                color: Colors.grey[200],
                // Define the shape of the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                // Define how the card's content should be clipped
                clipBehavior: Clip.antiAliasWithSaveLayer,
                // Define the child widget of the card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Add padding around the row widget
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Add some spacing between the top of the card and the title
                                Container(height: 5),
                                // Add a title widget
                                const Text("Cards Title 1",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87,
                                        fontSize: 16)),
                                // Add some spacing between the title and the subtitle
                                Container(height: 15),
                                const Text('5 New Collections',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: headingColor,
                                        fontSize: 10)),
                              ],
                            ),
                          ),

                          const Image(
                            image: NetworkImage(
                                'https://www.omaliving.com/media/catalog/product/cache/0141941aeb4901c5334e6ba10ea3844d/I/T/ITEM-007993_3_1.png'),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          // Add some spacing between the image and the text
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Card(
                color: Colors.grey[200],

                // Define the shape of the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                // Define how the card's content should be clipped
                clipBehavior: Clip.antiAliasWithSaveLayer,
                // Define the child widget of the card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Add padding around the row widget
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Add some spacing between the top of the card and the title
                                Container(height: 5),
                                // Add a title widget
                                const Text("Cards Title 1",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87,
                                        fontSize: 16)),
                                // Add some spacing between the title and the subtitle
                                Container(height: 15),
                                const Text('5 New Collections',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: headingColor,
                                        fontSize: 10)),
                              ],
                            ),
                          ),

                          const Image(
                            image: NetworkImage(
                                'https://www.omaliving.com/media/catalog/product/cache/0141941aeb4901c5334e6ba10ea3844d/I/T/ITEM-007993_3_1.png'),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          // Add some spacing between the image and the text
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
