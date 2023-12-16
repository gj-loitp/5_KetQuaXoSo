import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/string_constants.dart';
import 'package:ketquaxoso/lib/core/base_controller.dart';
import 'package:ketquaxoso/lib/util/log_dog_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ControllerXSMN extends BaseController {
  var selectedDateTime = DateTime.now().obs;
  var webViewController = WebViewController().obs;

  void clearOnDispose() {
    Get.delete<ControllerXSMN>();
  }

  void setSelectedDateTime(DateTime dateTime) {
    debugPrint("roy93~ setSelectedDateTime $dateTime");
    selectedDateTime.value = dateTime;

    var day = "";
    if (dateTime.day >= 10) {
      day = "${dateTime.day}";
    } else {
      day = "0${dateTime.day}";
    }
    var month = "";
    if (dateTime.month >= 10) {
      month = "${dateTime.month}";
    } else {
      month = "0${dateTime.month}";
    }
    var date = "#n$day-$month-${dateTime.year}";
    // debugPrint("date $date");
    var link = "${StringConstants.kqMienNam}$date";
    debugPrint("roy93~ link $link");

    webViewController.value = WebViewController()
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
            addBottomSpace();
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
      ..loadRequest(Uri.parse(link));
  }

  Future<void> addBottomSpace() async {
    const script = '''
      var spaceDiv = document.createElement("div");
      spaceDiv.style.height = "150px";
      document.body.appendChild(spaceDiv);
    ''';

    await webViewController.value.runJavaScript(script);
  }
}
