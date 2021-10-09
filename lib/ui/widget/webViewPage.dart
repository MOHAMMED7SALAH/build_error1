import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'customSearchAppBar.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key key, this.url}) : super(key: key);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  num _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
          context,
          withDrawer: false,
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: _handleLoad,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
    // WebviewScaffold(
    //   appBar: customAppBar(context),
    //   url: ,

    //   appCacheEnabled: true,
    //   withLocalStorage: true,
    //   withZoom: true,
    //   withJavascript: true,
    //   withOverviewMode: true,
    //   initialChild: Center(
    //     child: CircularProgressIndicator(
    //       valueColor: AlwaysStoppedAnimation(
    //         Theme.of(context).accentColor,
    //       ),
    //     ),
    //   ),

    //   //  WillPopScope(
    //   //   onWillPop: () async {
    //   //     webviewPlugin.hide();
    //   //     bool ret = await closeAccount(context);
    //   //     if (ret != true) {
    //   //       webviewPlugin.show();
    //   //     }
    //   //     return ret == true;
    //   //   },
    //   //   child: ),
    // );
    //
  }
}
