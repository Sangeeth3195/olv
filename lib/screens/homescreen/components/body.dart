import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:omaliving/screens/homescreen/components/text_title.dart';
// import 'package:video_player/video_player.dart';

import '../../../constants.dart';
import '../../product_listing/components/search_form.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final List<String> imageList = [
    "https://www.omaliving.com/media/wysiwyg/image_18_.png",
    "https://www.omaliving.com/media/wysiwyg/image_24_.png",
    "https://www.omaliving.com/media/wysiwyg/image_22_.png",
    "https://www.omaliving.com/media/wysiwyg/image_21_.png",
    "https://www.omaliving.com/media/wysiwyg/image_23_.png",
    "https://www.omaliving.com/media/wysiwyg/image_19_.png"
  ];

  StreamSubscription? _playerEventSubs;

  @override
  void initState() {
    super.initState();
   /* WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });*/
  }

  @override
  void dispose() {
    /*_playerEventSubs?.cancel();
    _meeduPlayerController.dispose();*/
    super.dispose();
  }

  /*_init() async {
    await _meeduPlayerController.setDataSource(
        DataSource(
          type: DataSourceType.network,
          source:
              'https://www.omaliving.com/media/wysiwyg/Homevideo2.mp4#t=0.001',
        ),
        autoplay: false,
        looping: false);
  }*/

 /* final _meeduPlayerController = MeeduPlayerController(
    controlsStyle: ControlsStyle.primary,
    enabledButtons: const EnabledButtons(pip: true),
    pipEnabled: false,
  );*/

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        height: 70,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: searchBackgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: const SearchForm(),
      ),

      ImageSlideshow(
        indicatorColor: Colors.white,
        height: 230.0,
        onPageChanged: (value) {
          debugPrint('Page changed: $value');
        },
        autoPlayInterval: 2000,
        isLoop: true,
        children: [
          Image.asset(
            'assets/images/salebanner.png',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/Homepage1.jpg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/homepage2.jpg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/bannerdesktop3.jpeg',
            fit: BoxFit.cover,
          ),
        ],
      ),
      const SizedBox(
        height: 15,
      ),

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        child: TextTitle(
          title: "Shop Latest",
          pressSeeAll: () {},
        ),
      ),
      const SizedBox(
        height: 0,
      ),

      GFItemsCarousel(
        rowCount: 3,
        children: imageList.map(
          (url) {
            return Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
              ),
            );
          },
        ).toList(),
      ),

      ImageSlideshow(
        indicatorColor: Colors.transparent,
        height: 230.0,
        onPageChanged: (value) {
          debugPrint('Page changed: $value');
        },
        isLoop: false,
        children: [
          Image.network(
              'https://www.omaliving.com/media/oma/WEDGWOODLOCKUP.png',
              fit: BoxFit.cover,
              width: 1000.0),
        ],
      ),

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        child: TextTitle(
          title: "Explore Kitchenware",
          pressSeeAll: () {},
        ),
      ),
      const SizedBox(
        height: 0,
      ),

      ImageSlideshow(
        indicatorColor: Colors.transparent,
        height: 250.0,
        onPageChanged: (value) {
          debugPrint('Page changed: $value');
        },
        isLoop: false,
        children: [
          Image.network('https://www.omaliving.com/media/oma/kitchenware.png',
              fit: BoxFit.cover, width: 1000.0),
        ],
      ),

      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        child: TextTitle(
          title: "STYLE WITH OMA",
          pressSeeAll: () {},
        ),
      ),

      // product with add to cart

      const SizedBox(
        height: 0,
      ),

      ImageSlideshow(
        indicatorColor: Colors.transparent,
        height: 250.0,
        onPageChanged: (value) {
          debugPrint('Page changed: $value');
        },
        isLoop: false,
        children: [
          Image.network('https://www.omaliving.com/media/oma/luxuryofsleep.jpg',
              fit: BoxFit.cover, width: 1000.0),
        ],
      ),

      // product with add to cart

      const SizedBox(
        height: 10,
      ),

      /// Video player

      /*Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        child: SafeArea(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: MeeduVideoPlayer(
              controller: _meeduPlayerController,
              header: (context, controller, responsive) => header,
            ),
          ),
        ),
      ),*/

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        child: TextTitle(
          title: '# OMA LIVING',
          pressSeeAll: () {},
        ),
      ),

      // product with add to cart

      const SizedBox(
        height: 0,
      ),

      GFItemsCarousel(
        rowCount: 3,
        children: imageList.map(
          (url) {
            return Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
              ),
            );
          },
        ).toList(),
      ),
    ]));
  }

  Widget get header {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CupertinoButton(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // close the fullscreen
              Navigator.maybePop(context);
            },
          ),
        ],
      ),
    );
  }
}
