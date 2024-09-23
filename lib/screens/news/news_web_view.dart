import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  const NewsWebView({super.key, required this.title, required this.url});
  final String title;
  final String url;

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  late final WebViewController controller;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loading = true;
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          controller.runJavaScript('''
          var container = document.createElement('div');
          container.innerHTML = '';
          var targetElement = document.querySelector('div.news-details');
          container.appendChild(targetElement);
          document.body.innerHTML = container.innerHTML;
      ''');
          setState(() {
            loading = false;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(widget.url),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
        context: context,
        title: widget.title,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.public,
              color: Colors.white,
            ),
            onPressed: () async {
              await launchUrl(Uri.parse(widget.url));
            },
          ),
        ],
        body: loading
            ? Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(marginLayoutBase),
                child: const SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()))
            : Container(
                decoration: BoxStyle.fromBoxDecoration(radius: 10),
                margin: const EdgeInsets.all(marginLayoutBase),
                child: WebViewWidget(controller: controller)));
  }
}
