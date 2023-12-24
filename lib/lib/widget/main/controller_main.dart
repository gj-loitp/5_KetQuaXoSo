import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:ketquaxoso/lib/common/const/string_constants.dart';
import 'package:ketquaxoso/lib/core/base_controller.dart';
import 'package:ketquaxoso/lib/model/kqxs.dart';
import 'package:ketquaxoso/lib/util/duration_util.dart';
import 'package:ketquaxoso/lib/util/shared_preferences_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ControllerMain extends BaseController {
  final dio = Dio();
  var isNativeMode = true.obs;
  var isFullScreen = true.obs;
  var themeIndex = SharedPreferencesUtil.themeIndexNativeView.obs;
  var buildId = "".obs;

  void clearOnDispose() {
    Get.delete<ControllerMain>();
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

  String _getLastChars(String inputString, int count) {
    int endIndex = inputString.length;
    int startIndex = endIndex - count;
    startIndex = startIndex < 0 ? 0 : startIndex;
    return inputString.substring(startIndex, endIndex);
  }

  Map<String, HighlightedWord> getWordsHighlight(double fontSize) {
    var myCurrentLottery = xsmnCurrentSearchNumber.value;
    Map<String, HighlightedWord> words = {};
    for (int i = 0; i < myCurrentLottery.characters.length; i++) {
      var lastChar = _getLastChars(myCurrentLottery, i + 1);
      // debugPrint("lastChar $lastChar");
      words[lastChar] = HighlightedWord(
        onTap: () {},
        textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
        decoration: BoxDecoration(
          color: Colors.lightGreenAccent,
          borderRadius: BorderRadius.circular(45),
        ),
        padding: const EdgeInsets.all(2),
      );
    }
    return words;
  }

  //ZONE XSMN
  var xsmnSelectedDateTime = DateTime.now().obs;
  var xsmnWebViewController = WebViewController().obs;
  var xsmnIsLoading = true.obs;
  var xsmnKqxs = KQXS().obs;
  var xsmnCurrentSearchNumber = "".obs;
  var xsmnCurrentSearchDate = "".obs;

  Future<void> setSelectedDateTimeXSMN(DateTime dateTime, bool isFirstInit) async {
    if (xsmnSelectedDateTime.value.day == dateTime.day &&
        xsmnSelectedDateTime.value.month == dateTime.month &&
        xsmnSelectedDateTime.value.year == dateTime.year &&
        !isFirstInit) {
      return;
    }

    // debugPrint("setSelectedDateTime $dateTime");
    xsmnIsLoading.value = true;
    xsmnSelectedDateTime.value = dateTime;

    var date = getSelectedDayInStringXSMN();
    // debugPrint("date $date");

    var index = await SharedPreferencesUtil.getInt(SharedPreferencesUtil.themeIndex);

    //co 2 cach
    //1 load bang web view
    //2 call api va load custom view
    if (index == SharedPreferencesUtil.themeIndexNativeView) {
      Future<void> getDataXSMN(String dateTime) async {
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
        xsmnKqxs.value = KQXS.fromJson(response.data);
        // kqxs.value = KQXS.fromJson(response.data);
        // debugPrint("web ${web.toJson()}");
        // debugPrint("web data ${web.pageProps?.resp?.data?.content?.entries}");
        // kqxs.pageProps?.resp?.data?.content?.entries?.forEach((element) {
        //   debugPrint("${element.displayName} ~ ${element.award} ~ ${element.value}");
        // });
        xsmnIsLoading.value = false;
      }

      isNativeMode.value = true;
      getDataXSMN(date);
    } else {
      void loadWebXSMN(String date) {
        var link = "${StringConstants.kqMienNam}#n$date";
        // debugPrint("link $link");

        xsmnWebViewController.value = WebViewController()
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

                Future<void> addBottomSpace() async {
                  xsmnIsLoading.value = true;
                  const script = '''
      var spaceDiv = document.createElement("div");
      spaceDiv.style.height = "250px";
      document.body.appendChild(spaceDiv);
    ''';

                  await xsmnWebViewController.value.runJavaScript(script);
                }

                addBottomSpace();
                xsmnIsLoading.value = false;
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

      isNativeMode.value = false;
      loadWebXSMN(date);
    }
  }

  String getSelectedDayInStringXSMN() {
    var dateTime = xsmnSelectedDateTime.value;
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

  void setCurrentNumberXSMN(String s) {
    xsmnCurrentSearchNumber.value = s;
  }

  void setCurrentDateXSMN(String s) {
    xsmnCurrentSearchDate.value = s;
  }

  String msgInvalidCurrentSearchDateXSMN() {
    try {
      var currentYear = DateTime.now().year;
      if (xsmnCurrentSearchDate.value.length != 10) {
        return "Hãy nhập đúng định dạng dd/MM/$currentYear";
      }
      var arr = xsmnCurrentSearchDate.split("/");
      int d = int.parse(arr[0]);
      int m = int.parse(arr[1]);
      int y = int.parse(arr[2]);
      // debugPrint("isValidCurrentSearchDate $d/$m/$y");
      if (d <= 0 || d >= 32) {
        return "Ngày không hợp lệ (0<ngày<32)";
      }
      if (m <= 0 || m >= 13) {
        return "Tháng không hợp lệ (0<tháng<13)";
      }
      if (y != currentYear) {
        return "Năm không hợp lệ (Năm = $currentYear)";
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  void applySearchXSMN() {
    var sCurrentSearchNumber = xsmnCurrentSearchNumber.value;
    var sCurrentSearchDate = xsmnCurrentSearchDate.value;
    debugPrint("sCurrentSearchNumber $sCurrentSearchNumber");
    debugPrint("sCurrentSearchDate $sCurrentSearchDate");
    var dt = DurationUtils.stringToDateTime(sCurrentSearchDate, DurationUtils.FORMAT_3);
    // debugPrint("dt $dt");
    if (dt != null) {
      setSelectedDateTimeXSMN(dt, false);
    }
  }
//END ZONE XSMN

//ZONE XSMT
//END ZONE XSMT

//ZONE XSMB
//END ZONE XSMB

//ZONE VIETLOT
//END ZONE VIETLOT

//ZONE PROVINCE
//END ZONE PROVINCE
}
