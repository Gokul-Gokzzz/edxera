import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewStore extends StatefulWidget {
  const WebviewStore({super.key});

  @override
  State<WebviewStore> createState() => _WebviewStoreState();
}

class _WebviewStoreState extends State<WebviewStore> {
  late final WebViewController controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              // Hide the loading indicator when page finishes loading
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            // Show loading indicator when page starts loading
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(
                'https://rosybrown-spider-410743.hostingersite.com/store/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://rosybrown-spider-410743.hostingersite.com/store/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
