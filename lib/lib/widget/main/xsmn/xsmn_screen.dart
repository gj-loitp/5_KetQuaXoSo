import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/model/kqxs.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';
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
    _selectDay(DateTime.now());
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
                    _selectDay(date);
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
              SizedBox(
                width: 40,
                height: 40,
                child: MaterialButton(
                  onPressed: () {
                    _controllerMain.toggleFullScreen();
                  },
                  color: ColorConstants.appColor,
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
                      _controllerMain.setSelectedDateTime(DateTime.now());
                    },
                    color: ColorConstants.appColor,
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
      if (isFuture) {
        return _buildFutureView();
      } else {
        if (isNativeMode) {
          return _buildNativeView();
        } else {
          return _buildWebView();
        }
      }
    }
  }

  Widget _buildLoadingView() {
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

  Widget _buildWebView() {
    return Container(
      padding: EdgeInsets.zero,
      // color: Colors.white,
      child: WebViewWidget(controller: _controllerMain.webViewController.value),
    );
  }

  Widget _buildNativeView() {
    var kqxs = _controllerMain.kqxs.value;
    var selectedDateTime = _controllerMain.selectedDateTime.value;
    // var listEntries = kqxs.pageProps?.resp?.data?.content?.entries ?? List.empty();
    // if (listEntries.isEmpty) {
    //   return _buildFutureView();
    // }
    var listDataWrapper = kqxs.getDataWrapper();
    debugPrint("roy93~ listDataWrapper ${listDataWrapper.length}");
    for (var element in listDataWrapper) {
      debugPrint("roy93~ element ${element.toJson()}");
    }

    if (listDataWrapper.isEmpty) {
      return _buildFutureView();
    }

    var widthItemTitle = 50.0;
    var widthItemProvince = (Get.width - widthItemTitle) / listDataWrapper.length;
    var heightItem = 40.0;

    var listWidget = <Widget>[];
    listWidget.add(_buildNativeTitleView(
      widthItemTitle,
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
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            // color: ColorConstants.bkgYellow,
            color: Colors.white70,
            child: Text(
              "Kết quả xổ số ngày ${selectedDateTime.day}-${selectedDateTime.month}-${selectedDateTime.year}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Row(children: listWidget),
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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: const Text(
            "Giải",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: const Text(
            "G.8",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.red),
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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: const Text(
            "G.7",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey),
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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: const Text(
            "G.6",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey),
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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: const Text(
            "G.5",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem * 4,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: const Text(
            "G.4",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey),
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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: const Text(
            "G.3",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey),
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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: const Text(
            "G.2",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey),
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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: const Text(
            "G.1",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey),
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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: const Text(
            "Đ.B",
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
          padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
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
          padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: Text(
            dataWrapper.getValueByAward("8"),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.red),
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
          padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: Text(
            dataWrapper.getValueByAward("7"),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
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
          padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: Text(
            dataWrapper.getValueByAward("6"),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
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
          padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: Text(
            dataWrapper.getValueByAward("5"),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        Container(
          width: widthItem,
          height: heightItem * 4,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: Text(
            dataWrapper.getValueByAward("4"),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
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
          padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: Text(
            dataWrapper.getValueByAward("3"),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
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
          padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: Text(
            dataWrapper.getValueByAward("2"),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
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
          padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: Text(
            dataWrapper.getValueByAward("1"),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
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
          padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: Text(
            dataWrapper.getValueByAward("ĐB"),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void _selectDay(DateTime dateTime) {
    _controllerMain.setSelectedDateTime(dateTime);
  }
}
