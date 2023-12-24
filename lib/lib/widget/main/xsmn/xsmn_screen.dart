import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/model/kqxs.dart';
import 'package:ketquaxoso/lib/widget/dlg/dlg_input_veso.dart';
import 'package:ketquaxoso/lib/widget/history/history_screen.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';
import 'package:ketquaxoso/lib/widget/profile/profile_screen.dart';
import 'package:marquee/marquee.dart';
import 'package:webview_flutter/webview_flutter.dart';

class XSMNScreen extends StatefulWidget {
  const XSMNScreen({
    super.key,
  });

  @override
  State<XSMNScreen> createState() => _XSMNScreenState();
}

class _XSMNScreenState extends BaseStatefulState<XSMNScreen> {
  final ControllerMain _controllerMain = Get.find();

  @override
  void initState() {
    super.initState();
    // debugPrint("initState");
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
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/bkg_3.jpg",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Obx(() {
              return Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top),
                  _buildCalendar(),
                  _buildViewSearchMyLottery(),
                  Expanded(
                    child: _buildContentView(),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      // color: ColorConstants.bkgYellow,
      color: Colors.white70,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: Row(
        children: [
          Expanded(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: SizedBox(
                height: _controllerMain.isFullScreen.value ? 100 : 0,
                child: CalendarTimeline(
                  shrink: false,
                  showYears: false,
                  initialDate: _controllerMain.selectedDateTime.value,
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
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              const SizedBox(height: 8),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: 40,
                  height: _controllerMain.isFullScreen.value ? 40 : 0,
                  child: MaterialButton(
                    onPressed: () {
                      Get.to(() => const HistoryScreen());
                    },
                    color: Colors.blueAccent,
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    child: Icon(
                      Icons.history,
                      color: _controllerMain.isFullScreen.value ? Colors.white : Colors.transparent,
                    ),
                  ),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  height: _controllerMain.isFullScreen.value ? 4 : 0,
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: 40,
                  height: _controllerMain.isFullScreen.value ? 40 : 0,
                  child: MaterialButton(
                    onPressed: () {
                      _selectDay(DateTime.now(), false);
                    },
                    color: Colors.pink,
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    child: Icon(
                      Icons.today,
                      color: _controllerMain.isFullScreen.value ? Colors.white : Colors.transparent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              const SizedBox(height: 8),
              SizedBox(
                width: 40,
                height: 40,
                child: MaterialButton(
                  onPressed: () {
                    _controllerMain.toggleFullScreen();
                  },
                  color: Colors.green,
                  padding: const EdgeInsets.all(0),
                  shape: const CircleBorder(),
                  child: Icon(
                    _controllerMain.isFullScreen.value ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: Colors.white,
                  ),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  height: _controllerMain.isFullScreen.value ? 4 : 0,
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: 40,
                  height: _controllerMain.isFullScreen.value ? 40 : 0,
                  child: MaterialButton(
                    onPressed: () {
                      Get.to(() => const ProfileScreen());
                    },
                    color: Colors.deepPurple,
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    child: Icon(
                      Icons.settings,
                      color: _controllerMain.isFullScreen.value ? Colors.white : Colors.transparent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentView() {
    var isLoading = _controllerMain.isLoading.value;
    var isNativeMode = _controllerMain.isNativeMode.value;
    var timeNow = DateTime.now().microsecondsSinceEpoch;
    var timeSelected = _controllerMain.selectedDateTime.value.microsecondsSinceEpoch;
    var isFuture = false;
    // debugPrint("timeNow $timeNow");
    // debugPrint("timeSelected $timeSelected");
    if (timeNow > timeSelected) {
      // debugPrint("if");
      isFuture = false;
    } else {
      // debugPrint("else");
      isFuture = true;
    }
    if (isLoading) {
      return _buildLoadingView();
    } else {
      if (isNativeMode) {
        return _buildNativeView(isFuture);
      } else {
        return _buildWebView(isFuture);
      }
    }
  }

  Widget _buildLoadingView() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/anim_1.gif",
            // width: 100,
            height: 250,
            fit: BoxFit.cover,
          ),
          // const SizedBox(height: 16),
          const Text(
            "Đang tải dữ liệu...\nVui lòng chờ...",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFutureView() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/anim_1.gif",
            // width: 100,
            height: 250,
            fit: BoxFit.cover,
          ),
          // const SizedBox(height: 16),
          Text(
            "Chưa có kết quả xổ số vào ngày ${_controllerMain.getSelectedDayInString()}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildWebView(bool isFuture) {
    if (isFuture) {
      return _buildFutureView();
    } else {
      return Container(
        padding: EdgeInsets.zero,
        // color: Colors.white,
        child: WebViewWidget(controller: _controllerMain.webViewController.value),
      );
    }
  }

  Widget _buildNativeView(bool isFuture) {
    if (isFuture) {
      return _buildFutureView();
    } else {
      var kqxs = _controllerMain.kqxs.value;
      // var listEntries = kqxs.pageProps?.resp?.data?.content?.entries ?? List.empty();
      // if (listEntries.isEmpty) {
      //   return _buildFutureView();
      // }
      var listDataWrapper = kqxs.getDataWrapper();
      // debugPrint("listDataWrapper ${listDataWrapper.length}");
      // for (var element in listDataWrapper) {
      //   debugPrint("element ${element.toJson()}");
      // }

      if (listDataWrapper.isEmpty) {
        return _buildFutureView();
      }

      var widthItemTitleLabel = 30.0;
      var widthItemProvince = (Get.width - widthItemTitleLabel) / listDataWrapper.length;
      var heightItem = 50.0;

      var listWidget = <Widget>[];
      listWidget.add(_buildNativeTitleView(
        widthItemTitleLabel,
        heightItem,
      ));
      for (var element in listDataWrapper) {
        listWidget.add(_buildNativeProvinceView(
          element,
          widthItemProvince,
          heightItem,
        ));
      }

      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Row(children: listWidget),
        ),
      );
    }
  }

  Widget _buildViewSearchMyLottery() {
    var selectedDateTime = _controllerMain.selectedDateTime.value;
    var currentSearchNumber = _controllerMain.currentSearchNumber.value;
    var sCurrentSearchNumber = "";
    if (currentSearchNumber.isEmpty) {
      sCurrentSearchNumber = "Nhập vé số để tự động dò";
    } else {
      sCurrentSearchNumber = "Vé của tôi: $currentSearchNumber";
    }
    return Container(
      alignment: Alignment.center,
      height: 52,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      color: Colors.white70,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              height: 48,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(right: Radius.circular(45)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
                child: Marquee(
                  text:
                      'Kết quả xổ số ngày ${selectedDateTime.day} tháng ${selectedDateTime.month} năm ${selectedDateTime.year}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  blankSpace: 50.0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              alignment: Alignment.centerRight,
              height: 48,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(45)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(45),
                        child: Marquee(
                          text: sCurrentSearchNumber,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          blankSpace: 50.0,
                        ),
                        onTap: () {
                          Get.dialog(
                            const DlgInputVeSo(),
                            barrierColor: Colors.black87,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.document_scanner_outlined,
                    color: Colors.black,
                    size: 24.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNativeTitleView(double widthItem, double heightItem) {
    return Column(
      children: [
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.appColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text(
            "🇻🇳",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text(
            "8",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.red),
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.gray,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text(
            "7",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem * 2,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text(
            "6",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.gray,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text(
            "5",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem * 4.5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text(
            "4",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem * 1.5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.gray,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text(
            "3",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text(
            "2",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.gray,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text(
            "1",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text(
            "ĐB",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildNativeProvinceView(
    DataWrapper dataWrapper,
    double widthItem,
    double heightItem,
  ) {
    var wordsBlack = _controllerMain.getWordsHighlight(18);
    var wordsRed = _controllerMain.getWordsHighlight(16);
    return Column(
      children: [
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.appColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Marquee(
            text: "${dataWrapper.displayName}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            blankSpace: 50.0,
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextHighlight(
            text: dataWrapper.getValueByAward("8"),
            words: wordsRed,
            textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.gray,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextHighlight(
            text: dataWrapper.getValueByAward("7"),
            words: wordsBlack,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem * 2,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextHighlight(
            text: dataWrapper.getValueByAward("6"),
            words: wordsBlack,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.gray,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextHighlight(
            text: dataWrapper.getValueByAward("5"),
            words: wordsBlack,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem * 4.5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextHighlight(
            text: dataWrapper.getValueByAward("4"),
            words: wordsBlack,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem * 1.5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.gray,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextHighlight(
            text: dataWrapper.getValueByAward("3"),
            words: wordsBlack,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextHighlight(
            text: dataWrapper.getValueByAward("2"),
            words: wordsBlack,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.gray,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextHighlight(
            text: dataWrapper.getValueByAward("1"),
            words: wordsBlack,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextHighlight(
            text: dataWrapper.getValueByAward("ĐB"),
            words: wordsRed,
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void _selectDay(DateTime dateTime, bool isFirstInit) {
    _controllerMain.setSelectedDateTime(dateTime, isFirstInit);
  }
}
