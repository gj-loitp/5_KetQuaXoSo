import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/util/ui_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LeagueWidget extends StatefulWidget {
  const LeagueWidget({
    super.key,
  });

  @override
  State<LeagueWidget> createState() => _LeagueWidgetState();
}

class _LeagueWidgetState extends BaseStatefulState<LeagueWidget> {
  var _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    var htmlString = ''''
<div id="fs-standings"></div> <script> (function (w,d,s,o,f,js,fjs) { w['fsStandingsEmbed']=o;w[o] = w[o] || function () { (w[o].q = w[o].q || []).push(arguments) }; js = d.createElement(s), fjs = d.getElementsByTagName(s)[0]; js.id = o; js.src = f; js.async = 1; fjs.parentNode.insertBefore(js, fjs); }(window, document, 'script', 'mw', 'https://cdn.footystats.org/embeds/standings.js')); mw('params', { leagueID: 93 }); </script>
    ''';
    var htmlWithStyle = """<!DOCTYPE html>
    <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
      <body style='"margin: 0; padding: 0;'>
        <div>
          $htmlString
        </div>
      </body>
    </html>""";

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // debugPrint("progress $progress");
          },
          onPageStarted: (String url) {
            // debugPrint("onPageStarted url $url");
          },
          onPageFinished: (String url) async {
            // debugPrint("onPageFinished url $url");
          },
          onWebResourceError: (WebResourceError error) {
            // debugPrint("onPageFinished url $error");
          },
          onNavigationRequest: (NavigationRequest request) {
            // debugPrint("request ${request.url}");
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadHtmlString(htmlWithStyle);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          UIUtils.getButton(
            "Tìm kiếm giải đấu",
            description: "Hãy chọn giải đấu yêu thích của bạn",
            Icons.search,
            () {},
          ),
          const SizedBox(height: 8),
          Expanded(
            child: WebViewWidget(controller: _webViewController),
          ),
        ],
      ),
    );
  }
}
