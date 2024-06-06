import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/const/string_constants.dart';
import '../../core/base_controller.dart';
import '../../model/kqxs.dart';
import '../../model/province.dart';
import '../../util/duration_util.dart';
import '../../util/shared_preferences_util.dart';

class ControllerMain extends BaseController {
  var timeStartApp = 0.obs;
  var isInitializePluginApplovinFinished = false.obs;
  final dio = Dio();
  var isNativeMode = true.obs;
  var themeIndex = SharedPreferencesUtil.themeIndexNativeView.obs;
  var isSettingOnTextOverflow = false.obs;
  var isSettingOnResultVietlotMax3d = false.obs;
  var buildId = "".obs;
  var packageInfo = PackageInfo(appName: '', packageName: '', version: '', buildNumber: '').obs;

  void clearOnDispose() {
    Get.delete<ControllerMain>();
  }

  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    this.packageInfo.value = packageInfo;
  }

  String getAppVersion() {
    return packageInfo.value.version;
  }

  Future<void> getThemeIndex() async {
    var index = await SharedPreferencesUtil.getInt(SharedPreferencesUtil.keyThemeIndex);
    if (index != null) {
      themeIndex.value = index;
    }
  }

  void setThemeIndex(int? index) {
    if (index != null) {
      themeIndex.value = index;
      SharedPreferencesUtil.setInt(SharedPreferencesUtil.keyThemeIndex, index);
    }
  }

  Future<void> getIsOnTextOverflow() async {
    var index = await SharedPreferencesUtil.getBool(SharedPreferencesUtil.keyOnOffTextOverflow);
    if (index != null) {
      isSettingOnTextOverflow.value = index;
    }
  }

  void setIsOnTextOverflow(bool? isOn) {
    if (isOn != null) {
      isSettingOnTextOverflow.value = isOn;
      SharedPreferencesUtil.setBool(SharedPreferencesUtil.keyOnOffTextOverflow, isOn);
    }
  }

  Future<void> getIsOnResultVietlotMax3d() async {
    var index = await SharedPreferencesUtil.getBool(SharedPreferencesUtil.keyOnOffResultVietlotMax3d);
    if (index != null) {
      isSettingOnResultVietlotMax3d.value = index;
    }
  }

  void setIsOnResultVietlotMax3d(bool? isOn) {
    if (isOn != null) {
      isSettingOnResultVietlotMax3d.value = isOn;
      SharedPreferencesUtil.setBool(SharedPreferencesUtil.keyOnOffResultVietlotMax3d, isOn);
    }
  }

  String _getLastChars(String inputString, int count) {
    int endIndex = inputString.length;
    int startIndex = endIndex - count;
    startIndex = startIndex < 0 ? 0 : startIndex;
    return inputString.substring(startIndex, endIndex);
  }

  String _getFirstChars(String inputString, int count) {
    return inputString.substring(0, count);
  }

  ///ZONE XSMN
  var xsmnSelectedDateTime = DateTime.now().obs;
  var xsmnWebViewController = WebViewController().obs;
  var xsmnIsLoading = true.obs;
  var xsmnIsValidData = true.obs;
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

    var index = await SharedPreferencesUtil.getInt(SharedPreferencesUtil.keyThemeIndex) ??
        SharedPreferencesUtil.themeIndexNativeView;
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
                var html = await xsmnWebViewController.value
                    .runJavaScriptReturningResult("document.documentElement.outerHTML") as String?;
                // log("html $html");
                if (html?.contains('imgloadig\\">') == true) {
                  // debugPrint("contains");
                  xsmnIsLoading.value = false;
                  xsmnIsValidData.value = false;
                } else {
                  // debugPrint("!contains");
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
                  xsmnIsValidData.value = true;
                }
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
      if (y != currentYear && y != (currentYear - 1)) {
        return "Năm không hợp lệ (Năm = $currentYear hoặc Năm = ${currentYear - 1})";
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

  Map<String, HighlightedWord> getWordsHighlightXSMN(double fontSize) {
    var myCurrentLottery = xsmnCurrentSearchNumber.value;
    Map<String, HighlightedWord> words = {};
    for (int i = 0; i < myCurrentLottery.characters.length; i++) {
      var firstChar = _getFirstChars(myCurrentLottery, i + 1);
      debugPrint("firstChar $firstChar");
      if (firstChar.length > 1) {
        words[firstChar] = HighlightedWord(
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
      var lastChar = _getLastChars(myCurrentLottery, i + 1);
      if (lastChar.length > 1) {
        debugPrint("getWordsHighlightXSMN lastChar $lastChar");
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
    }
    return words;
  }

  ///END ZONE XSMN

  ///ZONE XSMT
  var xsmtSelectedDateTime = DateTime.now().obs;
  var xsmtWebViewController = WebViewController().obs;
  var xsmtIsLoading = true.obs;
  var xsmtIsValidData = true.obs;
  var xsmtKqxs = KQXS().obs;
  var xsmtCurrentSearchNumber = "".obs;
  var xsmtCurrentSearchDate = "".obs;

  Future<void> setSelectedDateTimeXSMT(DateTime dateTime, bool isFirstInit) async {
    if (xsmtSelectedDateTime.value.day == dateTime.day &&
        xsmtSelectedDateTime.value.month == dateTime.month &&
        xsmtSelectedDateTime.value.year == dateTime.year &&
        !isFirstInit) {
      return;
    }

    // debugPrint("setSelectedDateTime $dateTime");
    xsmtIsLoading.value = true;
    xsmtSelectedDateTime.value = dateTime;

    var date = getSelectedDayInStringXSMT();
    // debugPrint("date $date");

    var index = await SharedPreferencesUtil.getInt(SharedPreferencesUtil.keyThemeIndex) ??
        SharedPreferencesUtil.themeIndexNativeView;

    //co 2 cach
    //1 load bang web view
    //2 call api va load custom view
    if (index == SharedPreferencesUtil.themeIndexNativeView) {
      Future<void> getDataXSMT(String dateTime) async {
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
          '${StringConstants.getApiXsmt(buildId.value)}?date=$dateTime&slug=xsmt-mien-trung',
          // data: "ngay_quay=16-12-2023",
          // options: Options(
          //   headers: {
          //     "x-requested-with": "XMLHttpRequest",
          //   },
          // ),
        );
        // debugPrint("response.data.toString() ${response.data.toString()}");
        xsmtKqxs.value = KQXS.fromJson(response.data);
        // kqxs.value = KQXS.fromJson(response.data);
        // debugPrint("web ${web.toJson()}");
        // debugPrint("web data ${web.pageProps?.resp?.data?.content?.entries}");
        // kqxs.pageProps?.resp?.data?.content?.entries?.forEach((element) {
        //   debugPrint("${element.displayName} ~ ${element.award} ~ ${element.value}");
        // });
        xsmtIsLoading.value = false;
      }

      isNativeMode.value = true;
      getDataXSMT(date);
    } else {
      void loadWebXSMT(String date) {
        var link = "${StringConstants.kqMienTrung}#n$date";
        // debugPrint("link $link");

        xsmtWebViewController.value = WebViewController()
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

                // debugPrint("onPageFinished url $url");
                var html = await xsmtWebViewController.value
                    .runJavaScriptReturningResult("document.documentElement.outerHTML") as String?;
                // log("html $html");
                if (html?.contains('imgloadig\\">') == true) {
                  // debugPrint("contains");
                  xsmtIsLoading.value = false;
                  xsmtIsValidData.value = false;
                } else {
                  // debugPrint("!contains");
                  Future<void> addBottomSpace() async {
                    xsmtIsLoading.value = true;
                    const script = '''
      var spaceDiv = document.createElement("div");
      spaceDiv.style.height = "250px";
      document.body.appendChild(spaceDiv);
    ''';

                    await xsmtWebViewController.value.runJavaScript(script);
                  }

                  addBottomSpace();
                  xsmtIsLoading.value = false;
                  xsmtIsValidData.value = true;
                }
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
      loadWebXSMT(date);
    }
  }

  String getSelectedDayInStringXSMT() {
    var dateTime = xsmtSelectedDateTime.value;
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

  void setCurrentNumberXSMT(String s) {
    xsmtCurrentSearchNumber.value = s;
  }

  void setCurrentDateXSMT(String s) {
    xsmtCurrentSearchDate.value = s;
  }

  String msgInvalidCurrentSearchDateXSMT() {
    try {
      var currentYear = DateTime.now().year;
      if (xsmtCurrentSearchDate.value.length != 10) {
        return "Hãy nhập đúng định dạng dd/MM/$currentYear";
      }
      var arr = xsmtCurrentSearchDate.split("/");
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
      if (y != currentYear && y != (currentYear - 1)) {
        return "Năm không hợp lệ (Năm = $currentYear hoặc Năm = ${currentYear - 1})";
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  void applySearchXSMT() {
    var sCurrentSearchNumber = xsmtCurrentSearchNumber.value;
    var sCurrentSearchDate = xsmtCurrentSearchDate.value;
    debugPrint("sCurrentSearchNumber $sCurrentSearchNumber");
    debugPrint("sCurrentSearchDate $sCurrentSearchDate");
    var dt = DurationUtils.stringToDateTime(sCurrentSearchDate, DurationUtils.FORMAT_3);
    // debugPrint("dt $dt");
    if (dt != null) {
      setSelectedDateTimeXSMT(dt, false);
    }
  }

  Map<String, HighlightedWord> getWordsHighlightXSMT(double fontSize) {
    var myCurrentLottery = xsmtCurrentSearchNumber.value;
    Map<String, HighlightedWord> words = {};
    for (int i = 0; i < myCurrentLottery.characters.length; i++) {
      var firstChar = _getFirstChars(myCurrentLottery, i + 1);
      debugPrint("firstChar $firstChar");
      if (firstChar.length > 1) {
        words[firstChar] = HighlightedWord(
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
      var lastChar = _getLastChars(myCurrentLottery, i + 1);
      if (lastChar.length > 1) {
        debugPrint("getWordsHighlightXSMT lastChar $lastChar");
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
    }
    return words;
  }

  ///END ZONE XSMT

  ///ZONE XSMB
  var xsmbSelectedDateTime = DateTime.now().obs;
  var xsmbWebViewController = WebViewController().obs;
  var xsmbIsLoading = true.obs;
  var xsmbIsValidData = true.obs;
  var xsmbKqxs = KQXS().obs;
  var xsmbCurrentSearchNumber = "".obs;
  var xsmbCurrentSearchDate = "".obs;

  Future<void> setSelectedDateTimeXSMB(DateTime dateTime, bool isFirstInit) async {
    if (xsmbSelectedDateTime.value.day == dateTime.day &&
        xsmbSelectedDateTime.value.month == dateTime.month &&
        xsmbSelectedDateTime.value.year == dateTime.year &&
        !isFirstInit) {
      return;
    }

    // debugPrint("setSelectedDateTime $dateTime");
    xsmbIsLoading.value = true;
    xsmbSelectedDateTime.value = dateTime;

    var date = getSelectedDayInStringXSMB();
    // debugPrint("date $date");

    var index = await SharedPreferencesUtil.getInt(SharedPreferencesUtil.keyThemeIndex) ??
        SharedPreferencesUtil.themeIndexNativeView;
    //co 2 cach
    //1 load bang web view
    //2 call api va load custom view
    if (index == SharedPreferencesUtil.themeIndexNativeView) {
      Future<void> getDataXSMB(String dateTime) async {
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
          '${StringConstants.getApiXsmb(buildId.value)}?date=$dateTime&slug=xsmb-mien-bac',
          // data: "ngay_quay=16-12-2023",
          // options: Options(
          //   headers: {
          //     "x-requested-with": "XMLHttpRequest",
          //   },
          // ),
        );
        // debugPrint("response.data.toString() ${response.data.toString()}");
        xsmbKqxs.value = KQXS.fromJson(response.data);
        // kqxs.value = KQXS.fromJson(response.data);
        // debugPrint("web ${web.toJson()}");
        // debugPrint("web data ${web.pageProps?.resp?.data?.content?.entries}");
        // kqxs.pageProps?.resp?.data?.content?.entries?.forEach((element) {
        //   debugPrint("${element.displayName} ~ ${element.award} ~ ${element.value}");
        // });
        xsmbIsLoading.value = false;
      }

      isNativeMode.value = true;
      getDataXSMB(date);
    } else {
      void loadWebXSMB(String date) {
        var link = "${StringConstants.kqMienBac}#n$date";
        // debugPrint("loadWebXSMB link $link");

        xsmbWebViewController.value = WebViewController()
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
                var html = await xsmbWebViewController.value
                    .runJavaScriptReturningResult("document.documentElement.outerHTML") as String?;
                // log("html $html");
                if (html?.contains('imgloadig\\">') == true) {
                  // debugPrint("contains");
                  xsmbIsLoading.value = false;
                  xsmbIsValidData.value = false;
                } else {
                  // debugPrint("!contains");
                  Future<void> addBottomSpace() async {
                    xsmbIsLoading.value = true;
                    const script = '''
      var spaceDiv = document.createElement("div");
      spaceDiv.style.height = "250px";
      document.body.appendChild(spaceDiv);
    ''';

                    await xsmbWebViewController.value.runJavaScript(script);
                  }

                  addBottomSpace();
                  xsmbIsLoading.value = false;
                  xsmbIsValidData.value = true;
                }
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
      loadWebXSMB(date);
    }
  }

  String getSelectedDayInStringXSMB() {
    var dateTime = xsmbSelectedDateTime.value;
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

  void setCurrentNumberXSMB(String s) {
    xsmbCurrentSearchNumber.value = s;
  }

  void setCurrentDateXSMB(String s) {
    xsmbCurrentSearchDate.value = s;
  }

  String msgInvalidCurrentSearchDateXSMB() {
    try {
      var currentYear = DateTime.now().year;
      // debugPrint("msgInvalidCurrentSearchDateXSMB xsmbCurrentSearchDate ${xsmbCurrentSearchDate.value}");
      if (xsmbCurrentSearchDate.value.length != 10) {
        return "Hãy nhập đúng định dạng dd/MM/$currentYear";
      }
      var arr = xsmbCurrentSearchDate.split("/");
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
      if (y != currentYear && y != (currentYear - 1)) {
        return "Năm không hợp lệ (Năm = $currentYear hoặc Năm = ${currentYear - 1})";
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  void applySearchXSMB() {
    var sCurrentSearchNumber = xsmbCurrentSearchNumber.value;
    var sCurrentSearchDate = xsmbCurrentSearchDate.value;
    // debugPrint("sCurrentSearchNumber $sCurrentSearchNumber");
    // debugPrint("sCurrentSearchDate $sCurrentSearchDate");
    var dt = DurationUtils.stringToDateTime(sCurrentSearchDate, DurationUtils.FORMAT_3);
    // debugPrint("dt $dt");
    if (dt != null) {
      setSelectedDateTimeXSMB(dt, false);
    }
  }

  Map<String, HighlightedWord> getWordsHighlightXSMB(double fontSize) {
    var myCurrentLottery = xsmbCurrentSearchNumber.value;
    Map<String, HighlightedWord> words = {};
    for (int i = 0; i < myCurrentLottery.characters.length; i++) {
      var firstChar = _getFirstChars(myCurrentLottery, i + 1);
      debugPrint("firstChar $firstChar");
      if (firstChar.length > 1) {
        words[firstChar] = HighlightedWord(
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
      var lastChar = _getLastChars(myCurrentLottery, i + 1);
      if (lastChar.length > 1) {
        debugPrint("getWordsHighlightXSMB lastChar $lastChar");
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
    }
    return words;
  }

  ///END ZONE XSMB

  ///ZONE PROVINCE
  var listProvince = <Province>[].obs;

  void genListProvince() {
    listProvince.clear();
    listProvince.value = Province.genList();
    listProvince.refresh();
  }

  var provinceSelectedDateTime = DateTime.now().obs;
  var provinceWebViewController = WebViewController().obs;
  var provinceIsLoading = true.obs;
  var provinceIsValidData = true.obs;
  var provinceKqxs = KQXS().obs;
  var provinceCurrentSearchNumber = "".obs;
  var provinceCurrentSearchDate = "".obs;

  Future<void> setSelectedDateTimeProvince(
    Province province,
    DateTime dateTime,
    bool isFirstInit,
    bool isForceGetDataPast,
    bool isForceGetDataFuture,
  ) async {
    if (provinceSelectedDateTime.value.day == dateTime.day &&
        provinceSelectedDateTime.value.month == dateTime.month &&
        provinceSelectedDateTime.value.year == dateTime.year &&
        !isFirstInit) {
      return;
    }

    // debugPrint("setSelectedDateTime $dateTime, isForceGetDataPast $isForceGetDataPast, isForceGetDataFuture $isForceGetDataFuture");
    provinceIsLoading.value = true;
    provinceSelectedDateTime.value = dateTime;

    var date = getSelectedDayInStringProvince();
    // debugPrint("date $date");

    var index = await SharedPreferencesUtil.getInt(SharedPreferencesUtil.keyThemeIndex) ??
        SharedPreferencesUtil.themeIndexNativeView;
    //co 2 cach
    //1 load bang web view
    //2 call api va load custom view
    if (index == SharedPreferencesUtil.themeIndexNativeView) {
      Future<void> getDataProvince(String dateTime) async {
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
          '${StringConstants.getApiProvince(buildId.value, dateTime, province.slug)}',
          // data: "ngay_quay=16-12-2023",
          // options: Options(
          //   headers: {
          //     "x-requested-with": "XMLHttpRequest",
          //   },
          // ),
        );
        // debugPrint("response.data.toString() ${response.data.toString()}");
        var tempKQXS = KQXS.fromJson(response.data);
        // debugPrint("tempKQXS $tempKQXS");
        // debugPrint("tempKQXS.getDataWrapper() ${tempKQXS.getDataWrapper().length}");
        if (tempKQXS.getDataWrapper().isEmpty) {
          // debugPrint("empty data $isForceGetDataPast ~ $isForceGetDataFuture");
          var dt = provinceSelectedDateTime.value;
          // debugPrint("dt $dt");
          if (isForceGetDataPast == true) {
            dt = provinceSelectedDateTime.value.subtract(const Duration(days: 1));
            setSelectedDateTimeProvince(province, dt, false, isForceGetDataPast, isForceGetDataFuture);
            return;
          }
          if (isForceGetDataFuture == true) {
            var isPast = isPastDateTime(provinceSelectedDateTime.value);
            // debugPrint("isPast $isPast -> ${provinceSelectedDateTime.value}");
            if (isPast) {
              dt = provinceSelectedDateTime.value.add(const Duration(days: 1));
              setSelectedDateTimeProvince(province, dt, false, isForceGetDataPast, isForceGetDataFuture);
              return;
            }
          }
        }
        provinceKqxs.value = tempKQXS;
        // debugPrint("provinceKqxs ${provinceKqxs.value.pageProps?.resp?.data?.content?.entries}");
        // kqxs.value = KQXS.fromJson(response.data);
        // debugPrint("web ${web.toJson()}");
        // debugPrint("web data ${web.pageProps?.resp?.data?.content?.entries}");
        // kqxs.pageProps?.resp?.data?.content?.entries?.forEach((element) {
        //   debugPrint("${element.displayName} ~ ${element.award} ~ ${element.value}");
        // });
        provinceIsLoading.value = false;
      }

      isNativeMode.value = true;
      getDataProvince(date);
    } else {
      void loadWebProvince(String date) {
        var link = "${province.url}#n$date";
        // debugPrint("link $link");

        provinceWebViewController.value = WebViewController()
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
                var html = await provinceWebViewController.value
                    .runJavaScriptReturningResult("document.documentElement.outerHTML") as String?;
                // log("html $html");
                if (html?.contains('imgloadig\\">') == true) {
                  // debugPrint("contains");
                  provinceIsLoading.value = false;
                  provinceIsValidData.value = false;
                } else {
                  // debugPrint("!contains");
                  Future<void> addBottomSpace() async {
                    provinceIsLoading.value = true;
                    const script = '''
      var spaceDiv = document.createElement("div");
      spaceDiv.style.height = "250px";
      document.body.appendChild(spaceDiv);
    ''';

                    await provinceWebViewController.value.runJavaScript(script);
                  }

                  addBottomSpace();
                  provinceIsLoading.value = false;
                  provinceIsValidData.value = true;
                }
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
      loadWebProvince(date);
    }
  }

  String getSelectedDayInStringProvince() {
    var dateTime = provinceSelectedDateTime.value;
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

  void setCurrentNumberProvince(String s) {
    provinceCurrentSearchNumber.value = s;
  }

  void setCurrentDateProvince(String s) {
    provinceCurrentSearchDate.value = s;
  }

  String msgInvalidCurrentSearchDateProvince() {
    try {
      var currentYear = DateTime.now().year;
      if (provinceCurrentSearchDate.value.length != 10) {
        return "Hãy nhập đúng định dạng dd/MM/$currentYear";
      }
      var arr = provinceCurrentSearchDate.split("/");
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
      if (y != currentYear && y != (currentYear - 1)) {
        return "Năm không hợp lệ (Năm = $currentYear hoặc Năm = ${currentYear - 1})";
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  void applySearchProvince(Province province, bool isForceGetDataPast, bool isForceGetDataFuture) {
    var sCurrentSearchNumber = provinceCurrentSearchNumber.value;
    var sCurrentSearchDate = provinceCurrentSearchDate.value;
    // debugPrint("sCurrentSearchNumber $sCurrentSearchNumber");
    // debugPrint("sCurrentSearchDate $sCurrentSearchDate");
    var dt = DurationUtils.stringToDateTime(sCurrentSearchDate, DurationUtils.FORMAT_3);
    // debugPrint("dt $dt");
    if (dt != null) {
      setSelectedDateTimeProvince(province, dt, false, isForceGetDataPast, isForceGetDataFuture);
    }
  }

  Map<String, HighlightedWord> getWordsHighlightProvince(double fontSize) {
    // debugPrint("getWordsHighlightProvince fontSize $fontSize");
    var myCurrentLottery = provinceCurrentSearchNumber.value;
    Map<String, HighlightedWord> words = {};
    for (int i = 0; i < myCurrentLottery.characters.length; i++) {
      // debugPrint("i $i");
      var firstChar = _getFirstChars(myCurrentLottery, i + 1);
      debugPrint("firstChar $firstChar");
      if (firstChar.length > 1) {
        words[firstChar] = HighlightedWord(
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
      var lastChar = _getLastChars(myCurrentLottery, i + 1);
      debugPrint("lastChar $lastChar");
      if (lastChar.length > 1) {
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
    }
    // debugPrint("getWordsHighlightProvince fontSize $fontSize -> words ${words.length}");
    return words;
  }

  bool isPastDateTime(DateTime selectedDay) {
    var today = DateTime.now();
    // debugPrint("${selectedDay.year}~${today.year}");
    // debugPrint("${selectedDay.month}~${today.month}");
    // debugPrint("${selectedDay.day}~${today.day}");
    if (selectedDay.year < today.year) {
      return true;
    }
    if (selectedDay.month < today.month) {
      return true;
    }
    if (selectedDay.day < today.day) {
      return true;
    }
    return false;
  }

  ///END ZONE PROVINCE

  var isShowTooltipCalendar = true.obs;
  var isShowTooltipCity = true.obs;
  var isShowTooltipToday = true.obs;

  void showTooltipCalendar(bool isShowTooltipCalendar) {
    this.isShowTooltipCalendar.value = isShowTooltipCalendar;
  }

  void showTooltipCity(bool isShowTooltipCity) {
    this.isShowTooltipCity.value = isShowTooltipCity;
  }

  void showTooltipToday(bool isShowTooltipToday) {
    this.isShowTooltipToday.value = isShowTooltipToday;
  }

  ///ZONE MEGA
  var megaSelectedDateTime = DateTime.now().obs;
  var megaWebViewController = WebViewController().obs;
  var megaIsLoading = true.obs;
  var megaIsValidData = true.obs;

  // var megaKqxs = KQXS().obs;

  Future<void> setSelectedDateTimeMega(DateTime dateTime, bool isFirstInit) async {
    if (megaSelectedDateTime.value.day == dateTime.day &&
        megaSelectedDateTime.value.month == dateTime.month &&
        megaSelectedDateTime.value.year == dateTime.year &&
        !isFirstInit) {
      return;
    }

    // debugPrint("setSelectedDateTime $dateTime");
    megaIsLoading.value = true;
    megaSelectedDateTime.value = dateTime;

    var date = getSelectedDayInStringMega();
    // debugPrint("date $date");

    Future<void> loadWebMega(String date) async {
      var link = "${StringConstants.kqMega}#n$date";
      // debugPrint("link $link");

      megaWebViewController.value = WebViewController()
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

              var html = await megaWebViewController.value
                  .runJavaScriptReturningResult("document.documentElement.outerHTML") as String?;
              if (html?.contains('class=\\"imgloadig\\">') == true) {
                megaIsLoading.value = false;
                megaIsValidData.value = false;
              } else {
                Future<void> addBottomSpace() async {
                  megaIsLoading.value = true;
                  const script = '''
      var spaceDiv = document.createElement("div");
      spaceDiv.style.height = "250px";
      document.body.appendChild(spaceDiv);
    ''';

                  await megaWebViewController.value.runJavaScript(script);
                }

                addBottomSpace();
                megaIsLoading.value = false;
                megaIsValidData.value = true;
              }
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

    loadWebMega(date);
  }

  String getSelectedDayInStringMega() {
    var dateTime = megaSelectedDateTime.value;
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

  ///END ZONE MEGA

  ///ZONE POWER
  var powerSelectedDateTime = DateTime.now().obs;
  var powerWebViewController = WebViewController().obs;
  var powerIsLoading = true.obs;
  var powerIsValidData = true.obs;

  // var powerKqxs = KQXS().obs;

  Future<void> setSelectedDateTimePower(DateTime dateTime, bool isFirstInit) async {
    if (powerSelectedDateTime.value.day == dateTime.day &&
        powerSelectedDateTime.value.month == dateTime.month &&
        powerSelectedDateTime.value.year == dateTime.year &&
        !isFirstInit) {
      return;
    }

    // debugPrint("setSelectedDateTime $dateTime");
    powerIsLoading.value = true;
    powerSelectedDateTime.value = dateTime;

    var date = getSelectedDayInStringPower();
    // debugPrint("date $date");

    Future<void> loadWebPower(String date) async {
      var link = "${StringConstants.kqPower}#n$date";
      // debugPrint("link $link");

      powerWebViewController.value = WebViewController()
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

              var html = await powerWebViewController.value
                  .runJavaScriptReturningResult("document.documentElement.outerHTML") as String?;
              if (html?.contains('class=\\"imgloadig\\">') == true) {
                powerIsLoading.value = false;
                powerIsValidData.value = false;
              } else {
                Future<void> addBottomSpace() async {
                  powerIsLoading.value = true;
                  const script = '''
      var spaceDiv = document.createElement("div");
      spaceDiv.style.height = "250px";
      document.body.appendChild(spaceDiv);
    ''';

                  await powerWebViewController.value.runJavaScript(script);
                }

                addBottomSpace();
                powerIsLoading.value = false;
                powerIsValidData.value = true;
              }
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

    loadWebPower(date);
  }

  String getSelectedDayInStringPower() {
    var dateTime = powerSelectedDateTime.value;
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

  ///END ZONE POWER

  ///ZONE MAX3D
  var max3dSelectedDateTime = DateTime.now().obs;
  var max3dWebViewController = WebViewController().obs;
  var max3dIsLoading = true.obs;
  var max3dIsValidData = true.obs;

  // var max3dKqxs = KQXS().obs;

  Future<void> setSelectedDateTimeMax3d(DateTime dateTime, bool isFirstInit) async {
    if (max3dSelectedDateTime.value.day == dateTime.day &&
        max3dSelectedDateTime.value.month == dateTime.month &&
        max3dSelectedDateTime.value.year == dateTime.year &&
        !isFirstInit) {
      return;
    }

    // debugPrint("setSelectedDateTime $dateTime");
    max3dIsLoading.value = true;
    max3dSelectedDateTime.value = dateTime;

    var date = getSelectedDayInStringMax3d();
    // debugPrint("date $date");

    Future<void> loadWebMax3d(String date) async {
      var link = "${StringConstants.kqMax3d}#n$date";
      // debugPrint("link $link");

      max3dWebViewController.value = WebViewController()
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

              var html = await max3dWebViewController.value
                  .runJavaScriptReturningResult("document.documentElement.outerHTML") as String?;
              if (html?.contains('class=\\"imgloadig\\">') == true) {
                max3dIsLoading.value = false;
                max3dIsValidData.value = false;
              } else {
                Future<void> addBottomSpace() async {
                  max3dIsLoading.value = true;
                  const script = '''
      var spaceDiv = document.createElement("div");
      spaceDiv.style.height = "250px";
      document.body.appendChild(spaceDiv);
    ''';

                  await max3dWebViewController.value.runJavaScript(script);
                }

                addBottomSpace();
                max3dIsLoading.value = false;
                max3dIsValidData.value = true;
              }
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

    loadWebMax3d(date);
  }

  String getSelectedDayInStringMax3d() {
    var dateTime = max3dSelectedDateTime.value;
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

  ///END ZONE MAX3D
}
