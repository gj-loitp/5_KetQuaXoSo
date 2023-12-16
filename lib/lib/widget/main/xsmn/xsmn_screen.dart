import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/common/const/string_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/duration_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class XSMNScreen extends StatefulWidget {
  const XSMNScreen({
    super.key,
  });

  @override
  State<XSMNScreen> createState() => _XSMNScreenState();
}

class _XSMNScreenState extends BaseStatefulState<XSMNScreen> {
  var _wvController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white);

  // final ControllerXSMN _controllerXSMN = Get.put(ControllerXSMN());

  @override
  void initState() {
    super.initState();
    _wvController.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // debugPrint("roy93~ progress $progress");
        },
        onPageStarted: (String url) {
          debugPrint("roy93~ onPageStarted url $url");
        },
        onPageFinished: (String url) async {
          debugPrint("roy93~ onPageFinished url $url");
          addBottomSpace();
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
    );
    _selectDay(DateTime.now(), true);
  }

  @override
  void dispose() {
    // _controllerXSMN.clearOnDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).viewPadding.top, 0, 0),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        color: ColorConstants.appColor,
        child: Column(
          children: [
            _buildCalendar(),
            Expanded(
              child: _buildWebView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      color: ColorConstants.bkgYellow,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
      child: CalendarTimeline(
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        onDateSelected: (date) {
          _selectDay(date, false);
        },
        leftMargin: 0,
        monthColor: Colors.black,
        dayColor: Colors.black,
        activeDayColor: Colors.white,
        activeBackgroundDayColor: ColorConstants.appColor,
        dotsColor: Colors.white,
        // selectableDayPredicate: (date) => date.millisecond < DateTime.now().millisecond,
        locale: 'vi',
      ),
    );
  }

  Widget _buildWebView() {
    return WebViewWidget(controller: _wvController);
  }

  Future<void> addBottomSpace() async {
    const script = '''
      var spaceDiv = document.createElement("div");
      spaceDiv.style.height = "150px";
      document.body.appendChild(spaceDiv);
    ''';

    await _wvController.runJavaScript(script);
  }

  void _selectDay(DateTime dateTime, bool isFirstInit) {
    // debugPrint("dateTime $dateTime");
    var day = "";
    if (dateTime.day >= 10) {
      day = "${dateTime.day}";
    } else {
      day = "0${dateTime.day}";
    }
    var date = "#n$day-${dateTime.month}-${dateTime.year}";
    // debugPrint("date $date");
    var link = "${StringConstants.kqMienNam}$date";
    debugPrint("roy93~ link $link");

    if (isFirstInit) {
      _wvController.loadRequest(Uri.parse(link));
    } else {
      _wvController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white);
      _wvController.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // debugPrint("roy93~ progress $progress");
          },
          onPageStarted: (String url) {
            debugPrint("roy93~ onPageStarted url $url");
          },
          onPageFinished: (String url) async {
            debugPrint("roy93~ onPageFinished url $url");
            addBottomSpace();
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
      );
      _wvController.loadRequest(Uri.parse(link));
      setState(() {

      });
    }
  }
}
