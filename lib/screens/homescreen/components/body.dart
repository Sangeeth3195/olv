import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/HomePageModel.dart';
import 'package:omaliving/models/InstaFeed.dart';
import 'package:omaliving/screens/product_listing/components/search_form.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:video_player/video_player.dart';

import '../../../API Services/InstaFeedServicde.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  AudioPlayer player = AudioPlayer();

  GraphQLService graphQLService = GraphQLService();

  HomePageModel homePageModel = HomePageModel();
  List<dynamic> navHeaderList = [];
  late VideoPlayerController? videoPlayerController;
  final bool looping = true;
  final bool autoplay = true;
  InstafeedModel? instafeed;

  ChewieController? _chewieController;
  CarouselController buttonCarouselController = CarouselController();

  int _current = 0;
  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  void initState() {
    super.initState();
    getDate();
  }

  Future<void> getInstaData() async {
    instafeed = await InstaFeed.getInstaPost();

    setState(() {});
  }

  getDate() async {
    navHeaderList = await graphQLService.getCategory(limit: 100);
    homePageModel = await graphQLService.gethomepagedata();
    getInstaData();
    setState(() {});

    if (homePageModel.typename != null) {
      videoPlayerController = VideoPlayerController.network(
          'https://omaliving.com/media/wysiwyg/homevideodesk4.MOV');

      await videoPlayerController!.initialize();
      _chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        autoPlay: autoplay,
        looping: looping,
        allowMuting: true,
        showOptions: false,
        allowFullScreen: false,
        fullScreenByDefault: false,
        allowPlaybackSpeedChanging: false,
        showControls: false,
        showControlsOnInitialize: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(builder: (context, provider, _) {
      return SingleChildScrollView(
          child: homePageModel.typename != null
              ? Column(children: [
                  provider.isSearch
                      ? Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: GestureDetector(
                              onTap: () {
                                // navigate(context, ProductList.route,
                                //     isRootNavigator: false, arguments: {'id': '1'});
                              },
                              child: const SearchForm()),
                        )
                      : Container(),

                  // Autocomplete<String>(
                  //   optionsBuilder: (TextEditingValue textEditingValue) {
                  //     if (textEditingValue.text == '') {
                  //       return const Iterable<String>.empty();
                  //     }
                  //     return _kOptions.where((String option) {
                  //       return option.contains(textEditingValue.text.toLowerCase());
                  //     });
                  //   },
                  //   onSelected: (String selection) {
                  //     debugPrint('You just selected $selection');
                  //   },
                  // ),
                  GestureDetector(
                    onTap: () {
                      // navigate(context, ProductListing.routeName,
                      //     isRootNavigator: false,
                      //     arguments: {'id': '1'});
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0.0)),
                            child: Column(children: <Widget>[
                              CarouselSlider(
                                items: [
                                  for (Sectiondatum item in homePageModel
                                      .getHomePageData![0].sectiondata!)
                                    GestureDetector(
                                      onTap: () {
                                        /* print('item.link');
                                        print(item.link);

                                        final myProvider =
                                            Provider.of<MyProvider>(context,
                                                listen: false);
                                        myProvider
                                            .updateData(int.parse(item.link!));
                                        context.go('/home/pdp');*/
                                        final Map<String, String> someMap = {
                                          "id": item.link!,
                                          "name": item.title!,
                                          "product_count": "20",
                                        };
                                        context.go('/home/pdp', extra: someMap);
                                      },
                                      child: Image.network(
                                        "https://staging2.omaliving.com${item.attachmentmob!}",
                                        fit: BoxFit.fitWidth,
                                      ),
                                    )
                                ],
                                carouselController: buttonCarouselController,
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: false,
                                  viewportFraction: 1,
                                  aspectRatio: 1,
                                  initialPage: 0,
                                  autoPlayInterval: const Duration(seconds: 4),
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: homePageModel
                                    .getHomePageData![0].sectiondata!
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  return GestureDetector(
                                    onTap: () => buttonCarouselController
                                        .animateToPage(entry.key),
                                    child: Container(
                                      width: 10.0,
                                      height: 10.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? headingColor
                                                  : headingColor)
                                              .withOpacity(_current == entry.key
                                                  ? 0.9
                                                  : 0.2)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text(
                          homePageModel.getHomePageData![1].title!
                              .toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: headingTextColor,
                                  fontFamily: 'Gotham',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),
                  Center(
                    child: Center(
                      child: Text(
                          '130+',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: headingTextColor,
                                  fontFamily: 'Gotham',
                                  fontSize: 45,
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.w500),
                        ),
                      ),
                  ),

                  Center(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Text(
                          homePageModel.getHomePageData![1].description!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 13,
                                  color: describtionTextColor,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  /*  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                      child: GFItemsCarousel(
                        rowCount: 3,
                        itemHeight: 250.0,
                        children:
                            homePageModel.getHomePageData![1].sectiondata!.map(
                          (url) {
                            return GestureDetector(
                              onTap: () {
                                final Map<String, dynamic> someMap = {
                                  "id": int.parse(url.link.toString()),
                                  "name": url.title!,
                                  "product_count": 20,
                                };
                                print(someMap);
                                context.go('/home/pdp', extra: someMap);

                                */ /* print('item.link');

                                print(url.link);

                                final myProvider = Provider.of<MyProvider>(
                                    context,
                                    listen: false);
                                myProvider.updateData(int.parse(url.link!));

                                context.go('/home/pdp');*/ /*
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0.0, 5, 5, 0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(0.0)),
                                      child: Image.network(
                                        "https://staging2.omaliving.com${url.attachment!}",
                                        fit: BoxFit.cover,
                                        height: 175,
                                        width: 1000.0,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/omalogo.png',
                                            height: 175,
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      url.title ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: 13,
                                              color: describtionTextColor,
                                              fontFamily: 'Gotham',
                                              fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),*/

                  /// Section 1
                  GestureDetector(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 250,
                        autoPlay: true,
                        enlargeCenterPage: false,
                        viewportFraction: 0.4,
                        aspectRatio: 1,
                        initialPage: 0,
                        onPageChanged: (index, reason) {
                          setState(() {});
                        },
                      ),
                      items: List.generate(
                        homePageModel.getHomePageData![1].sectiondata!.length,
                        ((i) {
                          return GestureDetector(
                            onTap: () {
                              print(homePageModel
                                  .getHomePageData![1].sectiondata![i].link);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0),
                              child: Column(
                                children: [
                                  Image.network(
                                    "https://staging2.omaliving.com${homePageModel.getHomePageData![1].sectiondata![i].attachmentmob}",
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    homePageModel.getHomePageData![1]
                                            .sectiondata![i].title! ??
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontSize: 13,
                                            color: describtionTextColor,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),

                      /*items: [
                            for (Sectiondatum item in homePageModel
                                .getHomePageData![1].sectiondata!)
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      3.0, 0.0, 3.0, 0),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Image.network(
                                      "https://staging2.omaliving.com${item.attachmentmob!}",
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                          ]*/
                    ),
                  ),

                  SizedBox(
                    width: 240, // <-- Your width
                    height: 35, // <-- Your height
                    child: ElevatedButton(
                      onPressed: () {
                        final Map<String, dynamic> someMap = {
                          "id": int.parse(homePageModel
                              .getHomePageData![1].sectiondata![0].link
                              .toString()),
                          "product_count": 20,
                        };
                        print(someMap);
                        context.go('/home/pdp', extra: someMap);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 40),
                        backgroundColor: describtionTextColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                0.0)), // Set the background color
                      ),
                      child: const Text(
                        'SHOP NOW',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gotham',
                        ),
                      ),
                    ),
                  ),

                  _chewieController == null
                      ? Center(child: Container())
                      : GestureDetector(
                          onTap: () {
                            print(homePageModel.getHomePageData![2].sectiondata![0].link!);
                          },
                          child: SizedBox(
                            height: 260,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: AspectRatio(
                                aspectRatio: 16 / 2,
                                child: Chewie(
                                  controller: _chewieController!,
                                ),
                              ),
                            ),
                          ),
                        ),

                  Center(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                        child: Text(
                          homePageModel.getHomePageData![3].title!,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: describtionTextColor,
                                    height: 1.5,
                                    fontFamily: 'Gotham',
                                    fontSize: 18,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                 /* Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                    child: GFItemsCarousel(
                      rowCount: 3,
                      itemHeight: 280.0,
                      children:
                          homePageModel.getHomePageData![3].sectiondata!.map(
                        (url) {
                          return GestureDetector(
                            onTap: () {
                              *//*  final myProvider =
                                  Provider.of<MyProvider>(context, listen: false);
                              myProvider.updateData(int.parse(url.link!));
                              context.go('/home/pdp');*//*
                              final Map<String, dynamic> someMap = {
                                "id": int.parse(url.link!.toString()),
                                "product_count": 20,
                              };
                              print(someMap);
                              context.go('/home/pdp', extra: someMap);
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0.0, 5, 5, 0),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(0.0)),
                                    child: Image.network(
                                      "https://staging2.omaliving.com${url.attachment!}",
                                      fit: BoxFit.cover,
                                      width: 1000.0,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/omalogo.png',
                                          height: 175,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  url.title!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: describtionTextColor,
                                        fontFamily: 'Gotham',
                                        height: 1.5,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),*/

                  GestureDetector(
                    child: CarouselSlider(
                    options: CarouselOptions(
                      height: 400,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      viewportFraction: 0.69,
                      aspectRatio: 1,
                      initialPage: 0,
                      onPageChanged: (index, reason) {
                        setState(() {});
                      },
                    ),
                items: List.generate(
                  homePageModel.getHomePageData![3].sectiondata!.length,
                  ((i) {
                    return GestureDetector(
                      onTap: () {
                        print(homePageModel
                            .getHomePageData![3].sectiondata![i].link);
                      },
                      child: Padding(
                        padding:
                        const EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              "https://staging2.omaliving.com${homePageModel.getHomePageData![3].sectiondata![i].attachmentmob}",
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              homePageModel.getHomePageData![3]
                                  .sectiondata![i].title! ??
                                  '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                  fontSize: 15,
                                  color: describtionTextColor,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Starts ${homePageModel.getHomePageData![3]
                                  .sectiondata![i].buttontext!} →" ??
                                  '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                  fontSize: 12,
                                  color: describtionTextColor,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

                  // Center(
                  //   child: Center(
                  //     child: Padding(
                  //       padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                  //       child: Text(
                  //         homePageModel.getHomePageData![4].title!,
                  //         style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w500,
                  //               color: describtionTextColor,
                  //               fontFamily: 'Gotham',
                  //               height: 1.5,
                  //             ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(0.0)),
                      child: ImageSlideshow(
                        indicatorColor: Colors.transparent,
                        height: 350.0,
                        onPageChanged: (value) {},
                        isLoop: false,
                        children: [
                          for (Sectiondatum item
                              in homePageModel.getHomePageData![4].sectiondata!)
                            GestureDetector(
                              onTap: () {
                                /* final myProvider = Provider.of<MyProvider>(
                                    context,
                                    listen: false);
                                myProvider.updateData(int.parse(item.link!));
                                context.go('/home/pdp');*/
                                final Map<String, dynamic> someMap = {
                                  "id": int.parse(item.link!.toString()),
                                  "product_count": 20,
                                };
                                print(someMap);
                                context.go('/home/pdp', extra: someMap);
                              },
                              child: Image.network(
                                "https://staging2.omaliving.com${item.attachment!}",
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(children: <Widget>[
                    const Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      homePageModel.getHomePageData![5].title!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: describtionTextColor,
                            fontFamily: 'Gotham',
                          ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    )),
                  ]),

                  /*Center(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child:



                        Text(
                          homePageModel.getHomePageData![5].title!,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: describtionTextColor,
                                    fontFamily: 'Gotham',
                                  ),
                        ),
                      ),
                    ),
                  ),*/

                  // product with add to cart

                  const SizedBox(
                    height: 0,
                  ),

                  /*Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                    child: GFItemsCarousel(
                      rowCount: 3,
                      itemHeight: 260.0,
                      children:
                          homePageModel.getHomePageData![5].sectiondata!.map(
                        (url) {
                          return GestureDetector(
                            onTap: () {
                              */ /*final myProvider =
                                  Provider.of<MyProvider>(context, listen: false);
                              myProvider.updateData(int.parse(url.link!));
                              context.go('/home/pdp');*/ /*
                              final Map<String, dynamic> someMap = {
                                "id": int.parse(url.link!.toString()),
                                "product_count": 20,
                              };
                              print(someMap);
                              context.go('/home/pdp', extra: someMap);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0.0, 5, 5, 0),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(0.0)),
                                    child: Image.network(
                                      "https://staging2.omaliving.com${url.attachment!}",
                                      fit: BoxFit.cover,
                                      width: 1000.0,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/omalogo.png',
                                          height: 175,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  url.title!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: describtionTextColor,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Gotham',
                                        fontSize: 14,
                                      ),
                                )
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),*/

                  /// Section 6

                  const SizedBox(
                    height: 10,
                  ),

                  GestureDetector(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 360,
                        autoPlay: true,
                        enlargeCenterPage: false,
                        viewportFraction: 0.69,
                        aspectRatio: 1,
                        initialPage: 0,
                        onPageChanged: (index, reason) {
                          setState(() {});
                        },
                      ),
                      items: List.generate(
                        homePageModel.getHomePageData![5].sectiondata!.length,
                        ((i) {
                          return GestureDetector(
                            onTap: () {
                              print(homePageModel
                                  .getHomePageData![5].sectiondata![i].link);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0),
                              child: Column(
                                children: [
                                  Image.network(
                                    "https://staging2.omaliving.com${homePageModel.getHomePageData![5].sectiondata![i].attachmentmob}",
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    homePageModel.getHomePageData![5]
                                            .sectiondata![i].title! ??
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontSize: 13,
                                            color: describtionTextColor,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      // navigate(context, ProductListing.routeName,
                      //     isRootNavigator: false,
                      //     arguments: {'id': '1'});
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0.0)),
                            child: Column(children: <Widget>[
                              CarouselSlider(
                                items: [
                                  for (Sectiondatum item in homePageModel
                                      .getHomePageData![6].sectiondata!)
                                    GestureDetector(
                                      onTap: () {
                                        /* print('item.link');
                                        print(item.link);

                                        final myProvider =
                                            Provider.of<MyProvider>(context,
                                                listen: false);
                                        myProvider
                                            .updateData(int.parse(item.link!));
                                        context.go('/home/pdp');*/
                                        final Map<String, String> someMap = {
                                          "id": item.link!,
                                          "name": item.title!,
                                          "product_count": "20",
                                        };
                                        context.go('/home/pdp', extra: someMap);
                                      },
                                      child: Image.network(
                                        "https://staging2.omaliving.com${item.attachment!}",
                                        fit: BoxFit.fitWidth,
                                      ),
                                    )
                                ],
                                carouselController: buttonCarouselController,
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: false,
                                  viewportFraction: 1,
                                  aspectRatio: 1,
                                  initialPage: 0,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: homePageModel
                                    .getHomePageData![6].sectiondata!
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  return GestureDetector(
                                    onTap: () => buttonCarouselController
                                        .animateToPage(entry.key),
                                    child: Container(
                                      width: 10.0,
                                      height: 10.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? headingColor
                                                  : headingColor)
                                              .withOpacity(_current == entry.key
                                                  ? 0.9
                                                  : 0.2)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /*     Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                    child: GFItemsCarousel(
                      rowCount: 1,
                      itemHeight: 180.0,
                      children:
                          homePageModel.getHomePageData![6].sectiondata!.map(
                        (url) {
                          return GestureDetector(
                            onTap: () {
                              final myProvider =
                                  Provider.of<MyProvider>(context, listen: false);
                              myProvider.updateData(int.parse(url.link!));
                              context.go('/home/pdp');
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0.0, 5, 5, 0),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(0.0)),
                                child: Image.network(
                                    "https://staging2.omaliving.com${url.attachment!}",
                                    fit: BoxFit.cover,
                                    width: 1000.0),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),*/

                  // product with add to cart

                  const SizedBox(
                    height: 10,
                  ),

                  Center(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text(
                          homePageModel.getHomePageData![7].title!,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.black,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                        child: Text(
                          homePageModel.getHomePageData![7].description!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 14,
                                  color: describtionTextColor,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 0,
                  ),

                  /* Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                    child: GFItemsCarousel(
                      rowCount: 2,
                      itemHeight: 280.0,
                      children:
                          homePageModel.getHomePageData![7].sectiondata!.map(
                        (url) {
                          return GestureDetector(
                            onTap: () {
                              */ /* final myProvider =
                                  Provider.of<MyProvider>(context, listen: false);
                              myProvider.updateData(int.parse(url.link!));
                              context.go('/home/pdp');*/ /*
                              final Map<String, dynamic> someMap = {
                                "id": int.parse(url.link!.toString()),
                                "product_count": 20,
                              };
                              print(someMap);
                              context.go('/home/pdp', extra: someMap);
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0.0, 0, 8, 0),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(0.0)),
                                    child: Image.network(
                                        "https://staging2.omaliving.com${url.attachment!}",
                                        fit: BoxFit.cover, errorBuilder:
                                            (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/omalogo.png',
                                        height: 175,
                                      );
                                    }, width: 1000.0),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  url.title!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: describtionTextColor,
                                        fontFamily: 'Gotham',
                                        fontSize: 12,
                                      ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),*/

                  /// Section 7

                  GestureDetector(
                    child: CarouselSlider(
                        options: CarouselOptions(
                          height: 320,
                          autoPlay: true,
                          enlargeCenterPage: false,
                          viewportFraction: 0.5,
                          aspectRatio: 1,
                          initialPage: 0,
                          onPageChanged: (index, reason) {
                            setState(() {});
                          },
                        ),
                        items: List.generate(
                          homePageModel.getHomePageData![7].sectiondata!.length,
                          ((i) {
                            return GestureDetector(
                              onTap: () {
                                print(homePageModel
                                    .getHomePageData![7].sectiondata![i].link);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      "https://staging2.omaliving.com${homePageModel.getHomePageData![7].sectiondata![i].attachmentmob}",
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      homePageModel.getHomePageData![7]
                                              .sectiondata![i].title! ??
                                          '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: 13,
                                              color: describtionTextColor,
                                              fontFamily: 'Gotham',
                                              fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                  ),

                  SizedBox(
                    width: 240, // <-- Your width
                    height: 35, // <-- Your height
                    child: ElevatedButton(
                      onPressed: () {
                        /*  final Map<String, String> someMap = {
                        "id": homePageModel
                            .getHomePageData![1].sectiondata![0].link!!,
                        "product_count": "20",
                      };
                      context.go('/home/pdp', extra: someMap);*/
                        final Map<String, dynamic> someMap = {
                          "id": int.parse(homePageModel
                              .getHomePageData![1].sectiondata![0].link!
                              .toString()),
                          "product_count": 20,
                        };
                        print(someMap);
                        context.go('/home/pdp', extra: someMap);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 40),
                        backgroundColor: describtionTextColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0)),
                        // Set the background color
                      ),
                      child: const Text(
                        'SHOP NOW',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gotham',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 35,
                  ),

                  Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: ButtonBar(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        'https://www.facebook.com/OmaLiving/');
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/square-facebook.svg',
                                    height: 22.0,
                                    width: 22.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        'https://www.instagram.com/OmaLiving/');
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/instagram.svg',
                                    height: 22.0,
                                    width: 22.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        'https://www.linkedin.com/company/oma-living/');
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/linkedin.svg',
                                    height: 22.0,
                                    width: 22.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),

                  Center(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Text(
                          homePageModel.getHomePageData![8].title!,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.black,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 25, 15),
                        child: Text(
                          homePageModel.getHomePageData![8].description!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 12,
                                  color: describtionTextColor,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),

                  instafeed == null
                      ? Container()
                      : GestureDetector(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                            child: GFItemsCarousel(
                              rowCount: 3,
                              itemHeight: 200.0,
                              children: instafeed!.data!
                                  .map((e) => GestureDetector(
                                        onTap: () {
                                          print(e.permalink);
                                          // _launchURLBrowser(e.permalink.toString());
                                          _launchURL(e.permalink.toString());
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0.0, 5, 5, 0),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(0.0)),
                                                child: Image.network(
                                                  e.mediaUrl ?? '',
                                                  fit: BoxFit.cover,
                                                  height: 150,
                                                  width: 1000.0,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                      'assets/omalogo.png',
                                                      height: 175,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),

                  const SizedBox(
                    height: 10,
                  ),
                ])
              : const Center(child: CircularProgressIndicator()));
    });
  }

  _launchURLBrowser(String _url) async {
    final url = Uri.parse(_url);
    if (await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  _launchURL(String _url) async {
    final Uri url = Uri.parse(_url);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $_url');
    }
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
