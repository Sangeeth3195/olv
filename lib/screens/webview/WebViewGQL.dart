import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../API Services/graphql_service.dart';

class CommonWebViewGraphql extends StatefulWidget {
  final String url;
  final String title;

  const CommonWebViewGraphql(
      {super.key, required this.url, required this.title});

  @override
  _CommonWebViewState createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebViewGraphql> {
  GraphQLService graphQLService = GraphQLService();

  dynamic getcustomwebview;

  @override
  void initState() {
    super.initState();
    getNavdata();
  }

  void getNavdata() async {
    EasyLoading.show(status: 'loading...');
    getcustomwebview = await graphQLService.getcustomwebview(widget.url);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
            size: 18,
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Colors.black),
          ),
        ),
        body: (getcustomwebview == null ||
                getcustomwebview?.data.length == null ||
                getcustomwebview?.data!['cmsPage']['content']! == null)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HtmlWidget(
                          getcustomwebview.data!['cmsPage']['content']!,
                          customStylesBuilder: (element) {
                            if (element.classes.contains('foo')) {
                              return {
                                'color': 'red',
                                'font-size': '20px',
                              };
                            }
                            return null;
                          },
                          onErrorBuilder: (context, element, error) =>
                              Text('$element error: $error'),
                          onLoadingBuilder:
                              (context, element, loadingProgress) =>
                                  const CircularProgressIndicator(),
                          renderMode: RenderMode.column,
                          // set the default styling for text
                          textStyle:
                              const TextStyle(fontSize: 14.0, height: 1.6),
                        )
                        // : Container()
                        ),
                  ],
                ),
              ));
  }
}
