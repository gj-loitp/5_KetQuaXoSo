import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/common/const/hero_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/util/ui_utils.dart';
import 'package:ketquaxoso/mckimquyen/util/url_launcher_utils.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/controller_main.dart';
import 'package:slider_button/slider_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

// https://sharpweather.com/widgets/b/#sl=slmw=360&sl=slbr=8&sl=slfs=26&c=cbkg=rgb(194,24,91)

class WeatherScreen extends StatefulWidget {
  const WeatherScreen(
    this.from, {
    super.key,
  });

  final String from;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends BaseStatefulState<WeatherScreen> {
  final ControllerMain _controllerMain = Get.find();
  final WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    // _controllerMain.isGoToGroupTester.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackPress();
        return true;
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: ColorConstants.bkg,
          child: Stack(
            alignment: Alignment.center,
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
                          Hero(
                            tag: "${widget.from}${HeroConstants.appBarLeftIcon}",
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: MaterialButton(
                                onPressed: () {
                                  _onBackPress();
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
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Hero(
                              tag: "${widget.from}${HeroConstants.appBarTitle}",
                              child: const Material(
                                color: Colors.transparent,
                                child: Text(
                                  "Dự báo thời tiết",
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/ic_beta.png",
                            width: 25,
                            height: 25,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 4),
                          const Expanded(
                            child: Text(
                              "Lưu ý: Tính đăng đang thử nghiệm, có thể gây lỗi",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.redAccent,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _buildBody(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.all(2),
      alignment: Alignment.topCenter,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Obx(() {
        var visible = _controllerMain.isShowWebViewWeather.value;
        if (visible) {
          return WebViewWidget(controller: _webViewController);
        } else {
          return _buildLoadingView();
        }
      }),
    );
  }

  Widget _buildLoadingView() {
    var quote = _controllerMain.quoteWeather.value;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/anim_1.gif",
            // width: 100,
            height: 180,
            fit: BoxFit.cover,
          ),
          // const SizedBox(height: 16),
          Text(
            quote,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            padding: const EdgeInsets.all(32),
            width: 124,
            height: 124,
            child: const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 6.0,
              strokeCap: StrokeCap.round,
            ),
          ),
        ],
      ),
    );
  }

  void _loadData() {
    _controllerMain.setIsShowWebViewWeather(false);
    var htmlString = ''''
    
<div id="idc948673ba211a" a='{"t":"b","v":"1.2","lang":"en","locs":[203,202,826,198,3072,196,194,3060,193,3066,3077,3062,201,1117,1878],"ssot":"c","sics":"ds","cbkg":"#455A64","cfnt":"#FFFFFF","ceb":"#FFFFFF","cef":"#000000","slmw":400,"slbr":15,"slfs":18,"sfnt":"a"}'><a href="https://sharpweather.com/widgets/">Weather widget html for website by sharpweather.com</a></div><script async src="https://static1.sharpweather.com/widgetjs/?id=idc948673ba211a"></script>

 ''';
    var htmlWithStyle = """<!DOCTYPE html>
    <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
      <style>
          body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            display: flex;
            justify-content: start;
            align-items: center;
            width: 100%;
          }
          body {
            box-sizing: border-box;
          }
          div {
            width: 100%;
            justify-content: center;
            text-align: center;
          }
        </style>
      <body style='"margin: 0; padding: 0;'>
        <div>
          $htmlString
        </div>
      </body>
    </html>""";

    _webViewController
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
            debugPrint("roy93~ onPageFinished url $url");
            await Future.delayed(const Duration(milliseconds: 1000));
            _controllerMain.setIsShowWebViewWeather(true);
          },
          onWebResourceError: (WebResourceError error) {
            // debugPrint("onPageFinished url $error");
          },
          onNavigationRequest: (NavigationRequest request) {
            // debugPrint("request ${request.url}");
            return NavigationDecision.prevent;
          },
        ),
      );
    // debugPrint(">>>>>>>> loadHtmlString htmlWithStyle $htmlWithStyle");
    _webViewController.loadHtmlString(htmlWithStyle);
  }

  void _onBackPress() {
    // debugPrint("_onBackPress");
    _controllerMain.setIsShowWebViewWeather(false);
    Get.back();
  }
}
