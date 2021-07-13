import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailNews extends StatefulWidget {
  String author, title, description, url, urlToImage, publishedAt, content;

  DetailNews({required this.author, required this.title, required this.description, required this.url, required this.urlToImage, required this.publishedAt, required this.content});

  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {

  var _author, _title, _description, _url, _urlToImage, _publishedAt, _content;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _author = widget.author;
    _title = widget.title;
    _description = widget.description;
    _url = widget.url;
    _urlToImage = widget.urlToImage;
    _publishedAt = widget.publishedAt;
    _content = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(_urlToImage),
            Text(_title),
            Text(_publishedAt),
            Text(_description),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetWebView(url: _url)));
              },
              child: Text('Source: '+_url),
            )
          ],
        ),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

class DetWebView extends StatefulWidget {
  
  String url;
  
  DetWebView({required this.url});

  @override
  _DetWebViewState createState() => _DetWebViewState();
}

class _DetWebViewState extends State<DetWebView> {
  var _url;
  late WebViewController _webViewController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _url = widget.url;
  }
  
  @override
  Widget build(BuildContext context) {
    return WebView(
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      initialUrl: "$_url",
    );
  }
}
