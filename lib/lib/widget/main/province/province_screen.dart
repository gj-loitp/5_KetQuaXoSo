import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/model/kqxs.dart';
import 'package:ketquaxoso/lib/model/province.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';
import 'package:marquee/marquee.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProvinceScreen extends StatefulWidget {
  static const path = "ProvinceScreen";
  final Province province;

  const ProvinceScreen({
    super.key,
    required this.province,
  });

  @override
  State<ProvinceScreen> createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends BaseStatefulState<ProvinceScreen> {
  final ControllerMain _controllerMain = Get.find();

  @override
  void initState() {
    super.initState();
    // debugPrint("initState");
    _selectDay(
      DateTime.now(),
      true,
      false,
      false,
    );
  }

  @override
  void dispose() {
    // _controllerMain.clearOnDispose();
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
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).viewPadding.top, 16, 16),
                    width: double.infinity,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                          height: 40,
                        ),
                        Expanded(
                          child: Text(
                            "${widget.province.name}",
                            style: const TextStyle(
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
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: MaterialButton(
                            onPressed: () {
                              Get.back();
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
                      ],
                    ),
                  ),
                  _buildCalendar(),
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
      color: Colors.white.withOpacity(0.9),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: MaterialButton(
              onPressed: () {
                _subtractDay(true, false);
              },
              color: Colors.white,
              padding: const EdgeInsets.all(0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.keyboard_double_arrow_left,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: CalendarTimeline(
              shrink: true,
              showYears: false,
              initialDate: _controllerMain.provinceSelectedDateTime.value,
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateSelected: (date) {
                _selectDay(
                  date,
                  false,
                  false,
                  false,
                );
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
          const SizedBox(width: 2),
          SizedBox(
            width: 40,
            height: 40,
            child: MaterialButton(
              onPressed: () {
                _addDay(false, true);
              },
              color: Colors.white,
              padding: const EdgeInsets.all(0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.keyboard_double_arrow_right,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentView() {
    var isLoading = _controllerMain.provinceIsLoading.value;
    var isNativeMode = _controllerMain.isNativeMode.value;
    var timeNow = DateTime.now().microsecondsSinceEpoch;
    var timeSelected = _controllerMain.provinceSelectedDateTime.value.microsecondsSinceEpoch;
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
            "Chưa có kết quả xổ số vào ngày\n${_controllerMain.getSelectedDayInStringProvince()}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              _subtractDay(false, false);
            },
            child: const Text('👈 Xem kết quả xổ số kì trước'),
          ),
          const SizedBox(height: 8),
          if (_controllerMain.isShowNextResult())
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                _addDay(false, false);
              },
              child: const Text('Xem kết quả xổ số kì tới 👉'),
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
        child: WebViewWidget(controller: _controllerMain.provinceWebViewController.value),
      );
    }
  }

  Widget _buildNativeView(bool isFuture) {
    if (isFuture) {
      return _buildFutureView();
    } else {
      var kqxs = _controllerMain.provinceKqxs.value;
      //TODO roy93~
      // var listEntries = kqxs.pageProps?.resp?.data?.content?.entries ?? List.empty();
      // if (listEntries.isEmpty) {
      // return Container();
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
            "╲",
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
            "⓼",
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
            "⓻",
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
            "⓺",
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
            "⓹",
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
            "⓸",
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
            "⓷",
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
            "⓶",
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
            "⓵",
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
            "🇻🇳",
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
    var wordsBlack = _controllerMain.getWordsHighlightProvince(18);
    var wordsRed = _controllerMain.getWordsHighlightProvince(16);
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
            binding: HighlightBinding.last,
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
            binding: HighlightBinding.last,
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
            binding: HighlightBinding.last,
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
            binding: HighlightBinding.last,
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
            binding: HighlightBinding.last,
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
            binding: HighlightBinding.last,
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
            binding: HighlightBinding.last,
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
            binding: HighlightBinding.last,
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
            binding: HighlightBinding.last,
            text: dataWrapper.getValueByAward("ĐB"),
            words: wordsRed,
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void _subtractDay(
    bool isForceGetDataPast,
    bool isForceGetDataFuture,
  ) {
    _selectDay(
      _controllerMain.provinceSelectedDateTime.value.subtract(const Duration(days: 1)),
      false,
      isForceGetDataPast,
      isForceGetDataFuture,
    );
  }

  void _addDay(
    bool isForceGetDataPast,
    bool isForceGetDataFuture,
  ) {
    _selectDay(
      _controllerMain.provinceSelectedDateTime.value.add(const Duration(days: 1)),
      false,
      isForceGetDataPast,
      isForceGetDataFuture,
    );
  }

  void _selectDay(
    DateTime dateTime,
    bool isFirstInit,
    bool isForceGetDataPast,
    bool isForceGetDataFuture,
  ) {
    _controllerMain.setSelectedDateTimeProvince(
      widget.province,
      dateTime,
      isFirstInit,
      isForceGetDataPast,
      isForceGetDataFuture,
    );
  }
}
