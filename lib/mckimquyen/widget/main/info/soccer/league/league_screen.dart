import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/hero_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/util/shared_preferences_util.dart';
import 'package:ketquaxoso/mckimquyen/util/ui_utils.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/controller_main.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/soccer/league/choose_league_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../list_league.dart';

//TODO roy93~ them xoa sua league yeu thich -> them nhanh vao list listLeagueQuick
class LeagueWidget extends StatefulWidget {
  static String path = "LeagueWidget";

  const LeagueWidget({
    super.key,
  });

  @override
  State<LeagueWidget> createState() => _LeagueWidgetState();
}

class _LeagueWidgetState extends BaseStatefulState<LeagueWidget> {
  final ControllerMain _controllerMain = Get.find();
  final WebViewController _webViewController = WebViewController();
  String? _leagueId;

  void _loadData(String? leagueID, bool needInitWebViewController) {
    _controllerMain.setIsShowWebViewSoccer(false);
    var mLeagueId = leagueID;
    if (mLeagueId == null || mLeagueId.isEmpty) {
      mLeagueId = League.leagueIdDefault;
    }
    debugPrint(
        "_loadData leagueID $leagueID => _mLeagueId $mLeagueId, needInitWebViewController $needInitWebViewController");
    var htmlString = ''''
<div id="fs-standings"></div> <script> (function (w,d,s,o,f,js,fjs) { w['fsStandingsEmbed']=o;w[o] = w[o] || function () { (w[o].q = w[o].q || []).push(arguments) }; js = d.createElement(s), fjs = d.getElementsByTagName(s)[0]; js.id = o; js.src = f; js.async = 1; fjs.parentNode.insertBefore(js, fjs); }(window, document, 'script', 'mw', 'https://cdn.footystats.org/embeds/standings.js')); mw('params', { leagueID: $mLeagueId }); </script>
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

    if (needInitWebViewController) {
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
              // debugPrint("onPageFinished url $url");
              _webViewController.runJavaScript('''
          (function() {
            var elements = document.querySelectorAll('*[style*="max-height"]');
            for (var i = 0; i < elements.length; i++) {
              elements[i].style.maxHeight = null;
            }
            for (var j = 0; j < document.styleSheets.length; j++) {
              var styleSheet = document.styleSheets[j];
              try {
                if (styleSheet.cssRules) {
                  for (var k = 0; k < styleSheet.cssRules.length; k++) {
                    var rule = styleSheet.cssRules[k];
                    if (rule.style && rule.style.maxHeight) {
                      rule.style.maxHeight = null;
                    }
                  }
                }
              } catch (e) {
                console.log('Could not access stylesheet: ', e);
              }
            }
          })();
        ''');
              await Future.delayed(const Duration(milliseconds: 1000));
              _controllerMain.setIsShowWebViewSoccer(true);
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
    }
    // debugPrint(">>>>>>>> loadHtmlString htmlWithStyle $htmlWithStyle");
    _webViewController.loadHtmlString(htmlWithStyle);
  }

  Future<void> _getLeagueId() async {
    //default id 12325 -> ngoai hang anh
    _leagueId = await SharedPreferencesUtil.getString(SharedPreferencesUtil.keyLeagueId);
    // debugPrint("_getLeagueId _leagueId $_leagueId");
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _getLeagueId();
    _loadData(_leagueId, true);
    _controllerMain.getListLeagueQuick();
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
      child: Column(
        children: [
          Hero(
            tag: "${LeagueWidget.path}${HeroConstants.searchView}",
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: UIUtils.getButton(
                "Tìm kiếm giải đấu",
                description: "Hãy chọn giải đấu yêu thích của bạn",
                Icons.search,
                () {
                  Get.to(
                    () => ChooseLeagueWidget(
                      LeagueWidget.path,
                      (League league) {
                        _handleChooseLeague(league);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          _buildQuickLeagueView(),
          Expanded(
            child: Obx(() {
              var visible = _controllerMain.isShowWebViewSoccer.value;
              if (visible) {
                return WebViewWidget(controller: _webViewController);
              } else {
                return _buildLoadingView();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingView() {
    var quote = _controllerMain.quoteSoccer.value;
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

  Widget _buildQuickLeagueView() {
    return Obx(() {
      var list = _controllerMain.listLeagueQuick;
      return Container(
        color: Colors.transparent,
        height: 30,
        margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
        alignment: Alignment.center,
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, i) {
            var league = list[i];
            return InkWell(
              child: Container(
                margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(45.0),
                      bottomRight: Radius.circular(45.0),
                      topLeft: Radius.circular(45.0),
                      bottomLeft: Radius.circular(45.0)),
                  color: (league.isSelected == true) ? Colors.yellow : Colors.white.withOpacity(0.8),
                ),
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Text(
                  league.name ?? "",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () {
                _controllerMain.setSelectedLeagueQuick(i);
                _loadData(league.id, false);
              },
            );
          },
        ),
      );
    });
  }

  Future<void> _handleChooseLeague(League league) async {
    // debugPrint("onTap league ${league.toJson()}");
    _controllerMain.setSelectedLeagueQuick(null);
    var leagueId = league.id ?? League.leagueIdDefault;
    await SharedPreferencesUtil.setString(SharedPreferencesUtil.keyLeagueId, leagueId);
    if (leagueId.isEmpty) {
      //do nothing
    } else {
      _loadData(leagueId, false);
    }
  }
}
