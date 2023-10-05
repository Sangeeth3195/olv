import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:go_router/go_router.dart';
import 'package:omaliving/API%20Services/graphql_service.dart';
import 'package:omaliving/MainLayout.dart';
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
  final bool looping = false;
  final bool autoplay = false;

  final List<String> imageList = [
    "https://www.omaliving.com/media/wysiwyg/image_18_.png",
    "https://www.omaliving.com/media/wysiwyg/image_24_.png",
    "https://www.omaliving.com/media/wysiwyg/image_22_.png",
    "https://www.omaliving.com/media/wysiwyg/image_21_.png",
    "https://www.omaliving.com/media/wysiwyg/image_23_.png",
    "https://www.omaliving.com/media/wysiwyg/image_19_.png"
  ];

  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    getDate();
  }

  getDate() async {
    homePageModel = await graphQLService.gethomepagedata();
    if (homePageModel.typename != null) {
      videoPlayerController = VideoPlayerController.network(
          homePageModel.getHomePageData![8].link!);

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
    setState(() {});
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
                Container(
                  height: 75,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: GestureDetector(
                      onTap: () {
                        navigate(context, ProductList.route,
                            isRootNavigator: false, arguments: {'id': '1'});
                      },
                      child: SearchForm()),
                ),

                GestureDetector(
                  onTap: () {
                    // navigate(context, ProductListing.routeName,
                    //     isRootNavigator: false,
                    //     arguments: {'id': '1'});
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                      child: Container(
                        height: 175.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0.0)),
                          child: ImageSlideshow(
                            indicatorColor: Colors.white,
                            onPageChanged: (value) {
                              debugPrint('Page changed: $value');
                            },
                            autoPlayInterval: 3000,
                            isLoop: true,
                            children: [
                              for (Sectiondatum item in homePageModel
                                  .getHomePageData![0].sectiondata!)
                                GestureDetector(
                                  onTap: () {
                                    final myProvider = Provider.of<MyProvider>(
                                        context,
                                        listen: false);
                                    myProvider
                                        .updateData(int.parse(item.link!));
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
                    ),
                  ),
                ),

                Center(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(
                        homePageModel.getHomePageData![1].title!,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                    child: GFItemsCarousel(
                      rowCount: 3,
                      itemHeight: 175.0,
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
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(0.0)),
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
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                    child: ImageSlideshow(
                      indicatorColor: Colors.transparent,
                      height: 200.0,
                      onPageChanged: (value) {
                        debugPrint('Page changed: $value');
                      },
                      isLoop: false,
                      children: [
                        for (Sectiondatum item
                            in homePageModel.getHomePageData![2].sectiondata!)
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

                Center(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(
                        homePageModel.getHomePageData![3].title!,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                  child: GFItemsCarousel(
                    rowCount: 3,
                    itemHeight: 175.0,
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

                Center(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(
                        homePageModel.getHomePageData![4].title!,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
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
                      onPageChanged: (value) {
                        debugPrint('Page changed: $value');
                      },
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
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ),

                // product with add to cart

                const SizedBox(
                  height: 0,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                    child: ImageSlideshow(
                      indicatorColor: Colors.transparent,
                      height: 200.0,
                      onPageChanged: (value) {
                        debugPrint('Page changed: $value');
                      },
                      isLoop: false,
                      children: [
                        for (Sectiondatum item
                            in homePageModel.getHomePageData![5].sectiondata!)
                          GestureDetector(
                            onTap: () {
                              final myProvider = Provider.of<MyProvider>(
                                  context,
                                  listen: false);
                              myProvider.updateData(int.parse(item.link!));
                              context.go('/home/pdp');
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
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
                    itemHeight: 175.0,
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
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0.0, 0, 8, 0),
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

                _chewieController == null
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 250,
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
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                      child: Center(
                        child: Text(
                          homePageModel.getHomePageData![9].title!,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),

                Center(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                      child: Center(
                        child: Text(
                          homePageModel.getHomePageData![9].description!,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
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
