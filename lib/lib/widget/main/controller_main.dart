import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/string_constants.dart';
import 'package:ketquaxoso/lib/core/base_controller.dart';
import 'package:ketquaxoso/lib/model/kqxs.dart';
import 'package:ketquaxoso/lib/util/shared_preferences_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ControllerMain extends BaseController {
  final dio = Dio();
  var selectedDateTime = DateTime.now().obs;
  var webViewController = WebViewController().obs;
  var isLoading = true.obs;
  var isNativeMode = true.obs;
  var isFullScreen = true.obs;
  var kqxs = KQXS().obs;
  var themeIndex = SharedPreferencesUtil.themeIndexNativeView.obs;
  var buildId = "".obs;

  var currentSearchNumber = "".obs;
  var currentSearchDate = "".obs;

  void clearOnDispose() {
    Get.delete<ControllerMain>();
  }

  Future<void> setSelectedDateTime(DateTime dateTime, bool isFirstInit) async {
    if (selectedDateTime.value.day == dateTime.day &&
        selectedDateTime.value.month == dateTime.month &&
        selectedDateTime.value.year == dateTime.year &&
        !isFirstInit) {
      return;
    }

    // debugPrint("setSelectedDateTime $dateTime");
    isLoading.value = true;
    selectedDateTime.value = dateTime;

    var date = getSelectedDayInString();
    // debugPrint("date $date");

    var index = await SharedPreferencesUtil.getInt(SharedPreferencesUtil.themeIndex);

    //co 2 cach
    //1 load bang web view
    //2 call api va load custom view
    if (index == SharedPreferencesUtil.themeIndexNativeView) {
      isNativeMode.value = true;
      _getData(date);
    } else {
      isNativeMode.value = false;
      _loadWeb(date);
    }
  }

  void _loadWeb(String date) {
    var link = "${StringConstants.kqMienNam}#n$date";
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
  }

  Future<void> addBottomSpace() async {
    isLoading.value = true;
    const script = '''
      var spaceDiv = document.createElement("div");
      spaceDiv.style.height = "250px";
      document.body.appendChild(spaceDiv);
    ''';

    await webViewController.value.runJavaScript(script);
  }

  Future<void> _getData(String dateTime) async {
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

    if (buildId.value.isEmpty) {
      var responseGetBuildId = await dio.get('https://baomoi.com/');
      if (responseGetBuildId.statusCode == 200) {
        String htmlToParse = responseGetBuildId.data;
        // debugPrint("responseGetBuildId $htmlToParse");
        var arrParent = htmlToParse.split('''buildId''');
        // debugPrint("arrParent ${arrParent.length}");
        if (arrParent.isNotEmpty && arrParent.length >= 2) {
          // debugPrint("0 ${arrParent[0]}");
          // debugPrint("1 ${arrParent[1]}");

          var sChild1 = arrParent[1];
          var arrChild = sChild1.split('''","''');
          // debugPrint("arrChild ${arrChild.length}");
          if (arrChild.isNotEmpty) {
            // debugPrint("arrChild 0 ${arrChild[0]}");
            var sBuildId = arrChild[0].replaceAll('''":"''', '');
            // debugPrint("~~~~~~~~~> sBuildId $sBuildId");
            buildId.value = sBuildId;
          }
        }
      }
    }

    // debugPrint(">>>dateTime $dateTime");
    var response = await dio.get(
      '${StringConstants.getApiXsmn(buildId.value)}?date=$dateTime&slug=xsmn-mien-nam',
      // data: "ngay_quay=16-12-2023",
      // options: Options(
      //   headers: {
      //     "x-requested-with": "XMLHttpRequest",
      //   },
      // ),
    );
    // debugPrint("response.data.toString() ${response.data.toString()}");
    kqxs.value = KQXS.fromJson(response.data);
    // kqxs.value = KQXS.fromJson(response.data);
    // debugPrint("web ${web.toJson()}");
    // debugPrint("web data ${web.pageProps?.resp?.data?.content?.entries}");
    // kqxs.pageProps?.resp?.data?.content?.entries?.forEach((element) {
    //   debugPrint("${element.displayName} ~ ${element.award} ~ ${element.value}");
    // });
    isLoading.value = false;
  }

  String getSelectedDayInString() {
    var dateTime = selectedDateTime.value;
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
    var date = "$day-$month-${dateTime.year}";
    return date;
  }

  void toggleFullScreen() {
    isFullScreen.value = !isFullScreen.value;
  }

  Future<void> getThemeIndex() async {
    var index = await SharedPreferencesUtil.getInt(SharedPreferencesUtil.themeIndex);
    if (index != null) {
      themeIndex.value = index;
    }
  }

  void setThemeIndex(int? index) {
    if (index != null) {
      themeIndex.value = index;
      SharedPreferencesUtil.setInt(SharedPreferencesUtil.themeIndex, index);
    }
  }

  void setCurrentNumber(String s) {
    currentSearchNumber.value = s;
  }

  void setCurrentDate(String s) {
    currentSearchDate.value = s;
  }

  bool isValidCurrentSearchDate() {
    try {
      var arr = currentSearchDate.split("/");
      int d = int.parse(arr[0]);
      int m = int.parse(arr[1]);
      int y = int.parse(arr[2]);
      // debugPrint("isValidCurrentSearchDate $d/$m/$y");
      if (d > 31) {
        return false;
      }
      if (m > 12) {
        return false;
      }
      if (y < 2020) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  void applySearch() {
    var sCurrentSearchNumber = currentSearchNumber.value;
    var sCurrentSearchDate = currentSearchDate.value;
    debugPrint("roy93~ sCurrentSearchNumber $sCurrentSearchNumber");
    debugPrint("roy93~ sCurrentSearchDate $sCurrentSearchDate");
  }
}
