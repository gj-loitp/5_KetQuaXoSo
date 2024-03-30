import 'package:blur/blur.dart';
import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Max3dScreen extends StatefulWidget {
  static const path = "Max3dScreen";

  const Max3dScreen({
    super.key,
  });

  @override
  State<Max3dScreen> createState() => _Max3dScreenState();
}

class _Max3dScreenState extends BaseStatefulState<Max3dScreen> {
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
            ).blurred(
              colorOpacity: 0.0,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(0)),
              blur: 5,
            ),
            Obx(() {
              return SafeArea(
                child: Column(
                  children: [
                    _buildCalendar(),
                    Expanded(
                      child: _buildContentView(),
                    ),
                  ],
                ),
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
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
      child: Row(
        children: [
          Column(
            children: [
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
              const SizedBox(height: 8),
              SizedBox(
                width: 40,
                height: 40,
                child: MaterialButton(
                  onPressed: () {
                    _subtractDay();
                  },
                  color: Colors.green,
                  padding: const EdgeInsets.all(0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.keyboard_double_arrow_left,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
          Expanded(
            child: CalendarTimeline(
              shrink: true,
              showYears: false,
              initialDate: _controllerMain.max3dSelectedDateTime.value,
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
          const SizedBox(width: 4),
          Column(
            children: [
              const SizedBox(
                width: 40,
                height: 40,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 40,
                height: 40,
                child: MaterialButton(
                  onPressed: () {
                    _addDay();
                  },
                  color: Colors.green,
                  padding: const EdgeInsets.all(0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.keyboard_double_arrow_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentView() {
    var isValid = _controllerMain.max3dIsValidData.value;
    var isLoading = _controllerMain.max3dIsLoading.value;
    var timeNow = DateTime.now().microsecondsSinceEpoch;
    var timeSelected = _controllerMain.max3dSelectedDateTime.value.microsecondsSinceEpoch;
    var isFuture = false;
    // debugPrint("timeNow $timeNow");
    // debugPrint("timeSelected $timeSelected");
    if (timeNow > timeSelected) {
      // debugPrint("if");
      if (isValid) {
        isFuture = false;
      } else {
        isFuture = true;
      }
    } else {
      // debugPrint("else");
      isFuture = true;
    }
    if (isLoading) {
      return _buildLoadingView();
    } else {
      return _buildWebView(isFuture);
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
          Container(
            padding: const EdgeInsets.all(32),
            width: 124,
            height: 124,
            child: const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 6.0,
              strokeCap: StrokeCap.round,
            ),
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
            "Chưa có kết quả xổ số vào ngày\n${_controllerMain.getSelectedDayInStringMax3d()}",
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
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                _subtractDay();
              },
              child: const Text('👈 Xem kết quả xổ số kì trước'),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 50,
            child: Visibility(
              visible: _controllerMain.isPastDateTime(_controllerMain.max3dSelectedDateTime.value),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  _addDay();
                },
                child: const Text('Xem kết quả xổ số kì tới 👉'),
              ),
            ),
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
        child: WebViewWidget(controller: _controllerMain.max3dWebViewController.value),
      );
    }
  }

  void _subtractDay() {
    _selectDay(
      _controllerMain.max3dSelectedDateTime.value.subtract(const Duration(days: 1)),
      false,
      true,
      false,
    );
  }

  void _addDay() {
    _selectDay(
      _controllerMain.max3dSelectedDateTime.value.add(const Duration(days: 1)),
      false,
      false,
      true,
    );
  }

  void _selectDay(
    DateTime dateTime,
    bool isFirstInit,
    bool isForceGetDataPast,
    bool isForceGetDataFuture,
  ) {
    _controllerMain.setSelectedDateTimeMax3d(
      dateTime,
      isFirstInit,
    );
  }
}
