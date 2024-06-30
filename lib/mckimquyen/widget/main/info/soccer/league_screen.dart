import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/util/ui_utils.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/controller_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LeagueWidget extends StatefulWidget {
  const LeagueWidget({
    super.key,
  });

  @override
  State<LeagueWidget> createState() => _LeagueWidgetState();
}

class _LeagueWidgetState extends BaseStatefulState<LeagueWidget> {
  final ControllerMain _controllerMain = Get.find();
  var _webViewController = WebViewController();

  void _loadData(String leagueID) {
    var htmlString = ''''
<div id="fs-standings"></div> <script> (function (w,d,s,o,f,js,fjs) { w['fsStandingsEmbed']=o;w[o] = w[o] || function () { (w[o].q = w[o].q || []).push(arguments) }; js = d.createElement(s), fjs = d.getElementsByTagName(s)[0]; js.id = o; js.src = f; js.async = 1; fjs.parentNode.insertBefore(js, fjs); }(window, document, 'script', 'mw', 'https://cdn.footystats.org/embeds/standings.js')); mw('params', { leagueID: $leagueID }); </script>
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
      ..setBackgroundColor(Colors.transparent)
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
  void initState() {
    super.initState();
    _loadData("12325");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: Colors.transparent,
      padding: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          Image.asset(
            "assets/images/bkg_3.jpg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ).blurred(
            colorOpacity: 0.0,
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(0)),
            blur: 5,
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: MaterialButton(
                          onPressed: () {
                            Get.back();
                          },
                          color: Colors.white,
                          padding: const EdgeInsets.all(0),
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          "Giải đấu",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 24,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
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
          ),
        ],
      ),
    );
  }
}
