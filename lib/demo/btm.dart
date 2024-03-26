import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class MyAppWebview extends StatefulWidget {
  const MyAppWebview({Key? key}) : super(key: key);

  @override
  State<MyAppWebview> createState() => _MyAppState();
}

class _MyAppState extends State<MyAppWebview> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("InAppWebView test"),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest:
              URLRequest(url: WebUri("https://www.omaliving.com/about-us")),

              initialUserScripts: UnmodifiableListView([
                UserScript(source: """
                window.addEventListener('DOMContentLoaded', function(event) {
                  var header = document.querySelector('.page-header'); // use here the correct CSS selector for your use case
                  if (header != null) {
                    header.style.display = 'none';
                    header.remove(); // remove the HTML element. Instead, to simply hide the HTML element, use header.style.display = 'none';
                  }
                  
                  var footer = document.querySelector('.footer-custom-outer'); // use here the correct CSS selector for your use case
                  if (footer != null) {
                  footer.style.display = 'none';
                    footer.remove(); // remove the HTML element. Instead, to simply hide the HTML element, use footer.style.display = 'none';
                  }
                });
                """, injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START)
              ]),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
            ),
          ),
        ]));
  }
}