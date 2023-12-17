import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/model/kqxs.dart';
import 'package:ketquaxoso/lib/widget/main/xsmn/controller_xsmb.dart';
import 'package:webview_flutter/webview_flutter.dart';

class XSMNScreen extends StatefulWidget {
  const XSMNScreen({
    super.key,
  });

  @override
  State<XSMNScreen> createState() => _XSMNScreenState();
}

class _XSMNScreenState extends BaseStatefulState<XSMNScreen> {
  final ControllerXSMN _controllerXSMN = Get.put(ControllerXSMN());

  @override
  void initState() {
    super.initState();
    _selectDay(DateTime.now());
  }

  @override
  void dispose() {
    _controllerXSMN.clearOnDispose();
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
              child: _buildContentView(),
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
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: CalendarTimeline(
        shrink: false,
        showYears: false,
        initialDate: _controllerXSMN.selectedDateTime.value,
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
    );
  }

  Widget _buildContentView() {
    return Obx(() {
      var isLoading = _controllerXSMN.isLoading.value;
      var isNativeMode = _controllerXSMN.isNativeMode.value;
      var timeNow = DateTime.now().microsecondsSinceEpoch;
      var timeSelected = _controllerXSMN.selectedDateTime.value.microsecondsSinceEpoch;
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
        return Container(
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/anim_1.gif",
            height: 250,
          ),
        );
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
    });
  }

  Widget _buildFutureView() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/bkg_2.jpg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.white70,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            height: 50,
            child: const Text(
              "Chưa có kết quả xổ số vào ngày này.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return Container(
      color: Colors.white,
      child: WebViewWidget(controller: _controllerXSMN.webViewController.value),
    );
  }

  Widget _buildNativeView() {
    var kqxs = _controllerXSMN.kqxs.value;
    var selectedDateTime = _controllerXSMN.selectedDateTime.value;
    // var listEntries = kqxs.pageProps?.resp?.data?.content?.entries ?? List.empty();
    // if (listEntries.isEmpty) {
    //   return _buildFutureView();
    // }
    var listDataWrapper = kqxs.getDataWrapper();
    // debugPrint("roy93~ listDataWrapper ${listDataWrapper.length}");
    // for (var element in listDataWrapper) {
    //   debugPrint("roy93~ element ${element.toJson()}");
    // }

    if (listDataWrapper.isEmpty) {
      return _buildFutureView();
    }

    var widthItem = Get.width / listDataWrapper.length;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            color: ColorConstants.bkgYellow,
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
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: listDataWrapper.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildColumnNative(listDataWrapper[index], widthItem);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnNative(DataWrapper dataWrapper, double widthItem) {
    var list = dataWrapper.recordKQXS ?? List.empty();
    return Container(
      width: widthItem,
      padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
      child: Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 0.5,
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16.0),
                topLeft: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              color: ColorConstants.appColor.withOpacity(0.3),
            ),
            child: Text(
              dataWrapper.displayName ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: index % 2 == 0 ? Colors.red : Colors.grey,
                  child: Text(
                    list[index].value ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _selectDay(DateTime dateTime) {
    _controllerXSMN.setSelectedDateTime(dateTime);
  }
}
