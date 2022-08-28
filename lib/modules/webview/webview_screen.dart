import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {

  final String url;
  const WebViewScreen(this.url,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Web View',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
