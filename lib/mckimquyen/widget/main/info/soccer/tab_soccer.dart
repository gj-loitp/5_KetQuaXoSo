import 'package:flutter/material.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TabSoccer extends StatefulWidget {
  const TabSoccer({super.key});

  @override
  State<TabSoccer> createState() => _TabSoccerState();
}

class _TabSoccerState extends BaseStatefulState<TabSoccer> {
  var xsmbWebViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    xsmbWebViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("roy93~ progress $progress");
          },
          onPageStarted: (String url) {
            debugPrint("roy93~ onPageStarted url $url");
          },
          onPageFinished: (String url) async {
            debugPrint("roy93~ onPageFinished url $url");
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("roy93~ onPageFinished url $error");
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint("roy93~ request ${request.url}");
            if (request.url.contains(".html")) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://bongdalu.moi/iframe/ket-qua"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WebViewWidget(
        controller: xsmbWebViewController,
      ),
    );
  }
}
