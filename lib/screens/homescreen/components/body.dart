import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/MainLayout.dart';
import 'package:omaliving/constants.dart';
import 'package:omaliving/models/HomePageModel.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../product_listing/components/search_form.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AudioPlayer player = AudioPlayer();

  GraphQLService graphQLService = GraphQLService();

  HomePageModel homePageModel = HomePageModel();
  late VideoPlayerController? videoPlayerController;
  final bool looping = true;
  final bool autoplay = true;

  final List<String> imageList = [
    "https://www.omaliving.com/media/wysiwyg/image_18_.png",
    "https://www.omaliving.com/media/wysiwyg/image_24_.png",
    "https://www.omaliving.com/media/wysiwyg/image_22_.png",
    "https://www.omaliving.com/media/wysiwyg/image_21_.png",
    "https://www.omaliving.com/media/wysiwyg/image_23_.png",
    "https://www.omaliving.com/media/wysiwyg/image_19_.png"
  ];

  ChewieController? _chewieController;
  CarouselController buttonCarouselController = CarouselController();

  int _current = 0;

  @override
  void initState() {
    super.initState();
    getDate();
  }

  getDate() async {
    homePageModel = await graphQLService.gethomepagedata();
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
    return SingleChildScrollView(
        child: homePageModel.typename != null
            ? Column(children: [
                // Container(
                //   padding: const EdgeInsets.all(5),
                //   decoration: const BoxDecoration(
                //     shape: BoxShape.rectangle,
                //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
                //   ),
                //   child: GestureDetector(
                //       onTap: () {
                //         navigate(context, ProductList.route,
                //             isRootNavigator: false, arguments: {'id': '1'});
                //       },
                //       child: const SearchForm()),
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
                                      final myProvider =
                                          Provider.of<MyProvider>(context,
                                              listen: false);
                                      myProvider
                                          .updateData(int.parse(item.link!));
                                      context.go('/home/pdp');
                                    },
                                    child: Image.network(
                                      "https://staging2.omaliving.com${item.attachmentmob!}",
                                      fit: BoxFit.cover,
                                    ),
                                  )
                              ],
                              carouselController: buttonCarouselController,
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                viewportFraction: 0.9,
                                aspectRatio: 2.0,
                                initialPage: 0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
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
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness ==
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
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(
                        homePageModel.getHomePageData![1].title!.toUpperCase(),
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
                Center(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(
                        homePageModel.getHomePageData![1].description!,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: 11,
                                color: describtionTextColor,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
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
                              final myProvider = Provider.of<MyProvider>(
                                  context,
                                  listen: false);
                              myProvider.updateData(int.parse(url.link!));
                              context.go('/home/pdp');
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
                                  SizedBox(
                                    height: 20,
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
                                            fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    backgroundColor:
                        describtionTextColor, // Set the background color
                  ),
                  child: const Text(
                    'SHOP NOW',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gotham',
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                //   child: ClipRRect(
                //     borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                //     child: ImageSlideshow(
                //       indicatorColor: Colors.transparent,
                //       height: 200.0,
                //       onPageChanged: (value) {},
                //       isLoop: false,
                //       children: [
                //         for (Sectiondatum item
                //             in homePageModel.getHomePageData![2].sectiondata!)
                //           GestureDetector(
                //             onTap: () {
                //               final myProvider = Provider.of<MyProvider>(
                //                   context,
                //                   listen: false);
                //               myProvider.updateData(int.parse(item.link!));
                //               context.go('/home/pdp');
                //             },
                //             child: Image.network(
                //               "https://staging2.omaliving.com${item.attachmentmob!}",
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //       ],
                //     ),
                //   ),
                // ),

                _chewieController == null
                    ? Center(child: Container())
                    : SizedBox(
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AspectRatio(
                            aspectRatio: 16 / 2,
                            child: Chewie(
                              controller: _chewieController!,
                            ),
                          ),
                        ),
                      ),
                Center(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: Text(
                        homePageModel.getHomePageData![3].title!,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: describtionTextColor,
                          height: 1.5,

                              fontFamily: 'Gotham',
                              fontSize: 20,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                  child: GFItemsCarousel(
                    rowCount: 3,
                    itemHeight: 250.0,
                    children:
                        homePageModel.getHomePageData![3].sectiondata!.map(
                      (url) {
                        return GestureDetector(
                          onTap: () {
                            final myProvider =
                                Provider.of<MyProvider>(context, listen: false);
                            myProvider.updateData(int.parse(url.link!));
                            context.go('/home/pdp');
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0.0, 5, 5, 0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(0.0)),
                                  child: Image.network(
                                    "https://staging2.omaliving.com${url.attachment!}",
                                    fit: BoxFit.cover,
                                    width: 1000.0,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/omalogo.png',
                                        height: 175,
                                      );
                                    },
                                  ),
                                ),
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
                                    ),
                              )
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),

                Center(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(
                        homePageModel.getHomePageData![4].title!,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: describtionTextColor,
                              fontFamily: 'Gotham',
                          height: 1.5,

                            ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                    child: ImageSlideshow(
                      indicatorColor: Colors.transparent,
                      height: 200.0,
                      onPageChanged: (value) {},
                      isLoop: false,
                      children: [
                        for (Sectiondatum item
                            in homePageModel.getHomePageData![4].sectiondata!)
                          GestureDetector(
                            onTap: () {
                              final myProvider = Provider.of<MyProvider>(
                                  context,
                                  listen: false);
                              myProvider.updateData(int.parse(item.link!));
                              context.go('/home/pdp');
                            },
                            child: Image.network(
                              "https://staging2.omaliving.com${item.attachmentmob!}",
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

                Center(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(
                        homePageModel.getHomePageData![5].title!,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: describtionTextColor,
                              fontFamily: 'Gotham',
                            ),
                      ),
                    ),
                  ),
                ),

                // product with add to cart

                const SizedBox(
                  height: 0,
                ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                //   child: ClipRRect(
                //     borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                //     child: ImageSlideshow(
                //       indicatorColor: Colors.transparent,
                //       height: 200.0,
                //       onPageChanged: (value) {},
                //       isLoop: false,
                //       children: [
                //         for (Sectiondatum item
                //             in homePageModel.getHomePageData![5].sectiondata!)
                //           GestureDetector(
                //             onTap: () {
                //               final myProvider = Provider.of<MyProvider>(
                //                   context,
                //                   listen: false);
                //               myProvider.updateData(int.parse(item.link!));
                //               context.go('/home/pdp');
                //             },
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Image.network(
                //                   "https://staging2.omaliving.com${item.attachment!}",
                //                   fit: BoxFit.cover,
                //                   errorBuilder: (context, error, stackTrace) {
                //                     return Image.asset(
                //                       'assets/omalogo.png',
                //                       height: 175,
                //                     );
                //                   },
                //                 ),
                //                 Text(
                //                   item.title!,
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .subtitle1!
                //                       .copyWith(
                //                         fontWeight: FontWeight.w500,
                //                         color: describtionTextColor,
                //                         fontFamily: 'Gotham',
                //                         fontSize: 15,
                //                       ),
                //                   textAlign: TextAlign.left,
                //                 )
                //               ],
                //             ),
                //           ),
                //       ],
                //     ),
                //   ),
                // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
            child: GFItemsCarousel(
              rowCount: 3,
              itemHeight: 250.0,
              children:
              homePageModel.getHomePageData![5].sectiondata!.map(
                    (url) {
                  return GestureDetector(
                    onTap: () {
                      final myProvider =
                      Provider.of<MyProvider>(context, listen: false);
                      myProvider.updateData(int.parse(url.link!));
                      context.go('/home/pdp');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.0, 5, 5, 0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(0.0)),
                            child: Image.network(
                              "https://staging2.omaliving.com${url.attachment!}",
                              fit: BoxFit.cover,
                              width: 1000.0,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/omalogo.png',
                                  height: 175,
                                );
                              },
                            ),
                          ),
                        ),
                        Text(
                          url.title!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                            color: describtionTextColor,
                            fontFamily: 'Gotham',
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),

                const SizedBox(
                  height: 5,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                  child: GFItemsCarousel(
                    rowCount: 1,
                    itemHeight: 175.0,
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
                ),

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
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 0,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                  child: GFItemsCarousel(
                    rowCount: 2,
                    itemHeight: 200.0,
                    children:
                        homePageModel.getHomePageData![7].sectiondata!.map(
                      (url) {
                        return GestureDetector(
                          onTap: () {
                            final myProvider =
                                Provider.of<MyProvider>(context, listen: false);
                            myProvider.updateData(int.parse(url.link!));
                            context.go('/home/pdp');
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0.0, 0, 8, 0),
                                child: ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(0.0)),
                                  child: Image.network(
                                      "https://staging2.omaliving.com${url.attachment!}",
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/omalogo.png',height: 175,);
                                },
                                      width: 1000.0),
                                ),
                              ),
                              Text(
                                url.title!,
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
                ),
                // Column(
                //   children: [
                //     _chewieController == null
                //         ? const Center(child: CircularProgressIndicator())
                //         : SizedBox(
                //             height: 250,
                //             child: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: AspectRatio(
                //                 aspectRatio: 16 / 2,
                //                 child: Chewie(
                //                   controller: _chewieController!,
                //                 ),
                //               ),
                //             ),
                //           ),
                //     homePageModel.getHomePageData!.length != 10
                //         ? Container()
                //         : Center(
                //             child: Center(
                //               child: Padding(
                //                 padding:
                //                     const EdgeInsets.fromLTRB(10, 15, 10, 5),
                //                 child: Center(
                //                   child: Text(
                //                     homePageModel.getHomePageData![9].title!,
                //                     textAlign: TextAlign.center,
                //                     style: Theme.of(context)
                //                         .textTheme
                //                         .titleMedium!
                //                         .copyWith(
                //                           color: Colors.black,
                //                           fontWeight: FontWeight.w600,
                //                         ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //     homePageModel.getHomePageData!.length != 10
                //         ? Container()
                //         : Center(
                //             child: Center(
                //               child: Padding(
                //                 padding:
                //                     const EdgeInsets.fromLTRB(15, 10, 15, 15),
                //                 child: Center(
                //                   child: Text(
                //                     homePageModel
                //                         .getHomePageData![9].description!,
                //                     textAlign: TextAlign.center,
                //                     style: Theme.of(context)
                //                         .textTheme
                //                         .titleMedium!
                //                         .copyWith(
                //                           color: Colors.black,
                //                           fontWeight: FontWeight.w500,
                //                         ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //   ],
                // ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
              backgroundColor:
              describtionTextColor, // Set the background color
            ),
            child: const Text(
              'SHOP NOW',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontFamily: 'Gotham',
              ),
            ),
          ),
          SizedBox(height: 20,),

              ])
            : const Center(child: CircularProgressIndicator()));
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
