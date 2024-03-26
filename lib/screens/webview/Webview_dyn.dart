import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Webview_Dyn extends StatefulWidget {
  final String url;
  final String title;

  const Webview_Dyn(
      {super.key, required this.url, required this.title});

  @override
  _CommonWebViewState createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<Webview_Dyn> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Colors.black),
          ),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest:
              URLRequest(url: WebUri(widget.url)),
              initialUserScripts: UnmodifiableListView([
                UserScript(source: """
                
                window.addEventListener('DOMContentLoaded', function(event) {
                
                var breadcrumbs = document.querySelector('.breadcrumbs'); // use here the correct CSS selector for your use case
                  if (breadcrumbs != null) {
                    breadcrumbs.style.display = 'none';
                    breadcrumbs.remove(); // remove the HTML element. Instead, to simply hide the HTML element, use header.style.display = 'none';
                  }
                  
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