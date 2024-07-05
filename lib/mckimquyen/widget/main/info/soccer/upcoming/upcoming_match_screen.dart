import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/hero_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/util/shared_preferences_util.dart';
import 'package:ketquaxoso/mckimquyen/util/ui_utils.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/controller_main.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/soccer/list_league.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/soccer/upcoming/choose_team_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UpcomingMatchWidget extends StatefulWidget {
  static String path = "UpcomingMatchWidget";

  const UpcomingMatchWidget({
    super.key,
  });

  @override
  State<UpcomingMatchWidget> createState() => _UpcomingMatchWidgetState();
}

class _UpcomingMatchWidgetState extends BaseStatefulState<UpcomingMatchWidget> {
  final ControllerMain _controllerMain = Get.find();
  final WebViewController _webViewController = WebViewController();
  String? _teamId;

  void _loadData(String? teamID, bool needInitWebViewController) {
    var mTeamId = teamID;
    if (mTeamId == null || mTeamId.isEmpty) {
      mTeamId = Team.teamIdDefault;
    }
    debugPrint(
        "roy93~ _loadData teamID $teamID => mTeamId $mTeamId, needInitWebViewController $needInitWebViewController");
    var htmlString = '''
<div id="fs-upcoming"></div> <script> (function (w,d,s,o,f,js,fjs) { w['fsUpcomingEmbed']=o;w[o] = w[o] || function () { (w[o].q = w[o].q || []).push(arguments) }; js = d.createElement(s), fjs = d.getElementsByTagName(s)[0]; js.id = o; js.src = f; js.async = 1; fjs.parentNode.insertBefore(js, fjs); }(window, document, 'script', 'fsUpcoming', 'https://cdn.footystats.org/embeds/upcoming-loc.js')); fsUpcoming('params', { teamID: $mTeamId, lang: 'vn' }); </script>
    ''';
    debugPrint("roy93~ htmlString $htmlString");
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

  Future<void> _getTeamId() async {
    _teamId = await SharedPreferencesUtil.getString(SharedPreferencesUtil.keyTeamId);
    debugPrint("roy93~ _getTeamId _teamId $_teamId");
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _getTeamId();
    _loadData(_teamId, true);
    _controllerMain.getListTeamQuick();
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
            tag: "${UpcomingMatchWidget.path}${HeroConstants.searchView}",
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: UIUtils.getButton(
                "Tìm kiếm tên đội bóng",
                description: "Hãy chọn đội bóng yêu thích của bạn",
                Icons.search,
                () {
                  Get.to(
                    () => ChooseTeamWidget(
                      UpcomingMatchWidget.path,
                      (Team team) {
                        _handleChooseTeam(team);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          _buildQuickTeamView(),
          Expanded(
            child: WebViewWidget(controller: _webViewController),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickTeamView() {
    return Obx(() {
      var list = _controllerMain.listTeamQuick;
      return Container(
        color: Colors.transparent,
        height: 30,
        margin: const EdgeInsets.only(top: 4),
        alignment: Alignment.center,
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, i) {
            var team = list[i];
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
                  color: (team.isSelected == true) ? Colors.yellow : Colors.white.withOpacity(0.8),
                ),
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Text(
                  team.name ?? "",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () {
                _controllerMain.setSelectedTeamQuick(i);
                _loadData(team.id, false);
              },
            );
          },
        ),
      );
    });
  }

  Future<void> _handleChooseTeam(Team team) async {
    debugPrint("roy93~ _handleChooseTeam ${team.toJson()}");
    _controllerMain.setSelectedTeamQuick(null);
    var teamId = team.id ?? Team.teamIdDefault;
    await SharedPreferencesUtil.setString(SharedPreferencesUtil.keyTeamId, teamId);
    if (teamId.isEmpty) {
      //do nothing
    } else {
      _loadData(teamId, false);
    }
  }
}
