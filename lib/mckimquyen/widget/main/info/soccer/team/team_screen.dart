import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/util/ui_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({
    super.key,
  });

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends BaseStatefulState<TeamScreen> {
  var webViewController = WebViewController();

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

    webViewController = WebViewController()
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
            if (request.url.contains(".html")) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      // ..loadRequest(Uri.parse("https://baomoi.com/tien-ich/lich-van-nien.epi"));
      // ..loadHtmlString("""<div id="fs-standings"></div> <script> (function (w,d,s,o,f,js,fjs) { w['fsStandingsEmbed']=o;w[o] = w[o] || function () { (w[o].q = w[o].q || []).push(arguments) }; js = d.createElement(s), fjs = d.getElementsByTagName(s)[0]; js.id = o; js.src = f; js.async = 1; fjs.parentNode.insertBefore(js, fjs); }(window, document, 'script', 'mw', 'https://cdn.footystats.org/embeds/standings-loc.js')); mw('params', { leagueID: 2012, lang: 'vn' }); </script>""");
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
      color: Colors.red,
      padding: const EdgeInsets.only(bottom: 16),
      child: Wrap(
        children: [
          UIUtils.getButton(
            "Tìm kiếm hàng ngàn giải đấu",
            Icons.navigate_next,
            () {},
          ),
          Container(
            height: 500,
            child: WebViewWidget(controller: webViewController),
          ),
          // Container(
          //   height: 500,
          //   color: Colors.red,
          //   child: HtmlWidget(
          //     '''
          // <iframe src="https://footystats.org/vn/api/club?id=5" height="100%" width="100%" style="height:420px; width:100%;" frameborder="0"></iframe>
          // ''',
          //     renderMode: RenderMode.listView,
          //     textStyle: const TextStyle(
          //       fontSize: 22,
          //       fontWeight: FontWeight.w400,
          //       color: Colors.black,
          //     ),
          //     enableCaching: true,
          //     onTapUrl: (url) {
          //       return true;
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
