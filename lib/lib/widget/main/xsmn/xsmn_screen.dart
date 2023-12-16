import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
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
    // _controllerXSMN.clearOnDispose();
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
              child: _buildWebView(),
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
      padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
      child: CalendarTimeline(
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

  Widget _buildWebView() {
    return Obx(() {
      return WebViewWidget(controller: _controllerXSMN.webViewController.value);
    });
  }

  void _selectDay(DateTime dateTime) {
    _controllerXSMN.setSelectedDateTime(dateTime);
  }
}
