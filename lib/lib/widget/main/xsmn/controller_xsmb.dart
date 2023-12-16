import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/string_constants.dart';
import 'package:ketquaxoso/lib/core/base_controller.dart';
import 'package:ketquaxoso/lib/model/web.dart';
import 'package:ketquaxoso/lib/util/log_dog_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dio/dio.dart';

class ControllerXSMN extends BaseController {
  var selectedDateTime = DateTime.now().obs;
  var webViewController = WebViewController().obs;
  var isLoading = true.obs;

  void clearOnDispose() {
    Get.delete<ControllerXSMN>();
  }

  void setSelectedDateTime(DateTime dateTime) {
    // debugPrint("setSelectedDateTime $dateTime");
    isLoading.value = true;
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
    // debugPrint("link $link");

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
            isLoading.value = false;
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

    //test
    test();
  }

  Future<void> addBottomSpace() async {
    const script = '''
      var spaceDiv = document.createElement("div");
      spaceDiv.style.height = "150px";
      document.body.appendChild(spaceDiv);
    ''';

    await webViewController.value.runJavaScript(script);
  }

  final dio = Dio();

  Future<void> test() async {
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          queryParameters: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          showProcessingTime: true,
          showCUrl: true,
          canShowLog: kDebugMode,
          convertFormData: true,
        ),
      );
    }
    var response = await dio.post(
      'https://xoso.mobi/embedded/kq-miennam',
      data: "ngay_quay=16-12-2023",
      options: Options(
        headers: {
          "x-requested-with": "XMLHttpRequest",
        },
      ),
    );
    debugPrint("roy93~ response.data.toString() ${response.data.toString()}");
    var web = Web.fromJson(response.data);
    debugPrint("roy93~ web stt ${web.stt}");
    debugPrint("roy93~ web data ${web.data}");
  }
}
