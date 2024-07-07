import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:ketquaxoso/mckimquyen/common/v/pulse_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/const/color_constants.dart';
import '../../../common/const/hero_constants.dart';
import '../../../common/const/string_constants.dart';
import '../../../common/v/calendar_timeline_sbk/src/calendar_timeline.dart';
import '../../../core/base_stateful_state.dart';
import '../../../model/kqxs.dart';
import '../../search/search_screen.dart';
import '../../text_marquee.dart';
import '../controller_main.dart';
import '../province/province_list_screen.dart';

class XSMNScreen extends StatefulWidget {
  static const path = "XSMNScreen";

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
    _controllerMain.getIsShowKeyTooltipCalendar();
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
      color: Colors.white.withOpacity(0.9),
      width: double.infinity,
      height: 90,
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CalendarTimeline(
                    shrink: false,
                    showYears: false,
                    initialDate: _controllerMain.xsmnSelectedDateTime.value,
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
                  if (_controllerMain.isShowKeyTooltipCalendar.value != true)
                    PulseContainer(
                      color: Colors.black.withOpacity(0.9),
                      onTapRoot: () {
                        debugPrint("onTapRoot");
                        _controllerMain.setIsShowKeyTooltipCalendar();
                        _controllerMain.getIsShowKeyTooltipProvince();
                      },
                      alignment: Alignment.center,
                      child: const Text(
                        'Bạn có thể lựa chọn ngày tháng để tra cứu\nkết quả xổ số bằng cách nhấn vào đây',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _controllerMain.isShowKeyTooltipProvince.value ? 40 : 140,
                height: _controllerMain.isShowKeyTooltipProvince.value ? 40 : 140,
                child: Stack(
                  // fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: "${XSMNScreen.path}${HeroConstants.appBarLeftIcon}",
                      child: MaterialButton(
                        onPressed: () {
                          Get.to(() => const ProvinceListScreen(XSMNScreen.path));
                        },
                        color: Colors.blueAccent,
                        padding: const EdgeInsets.all(0),
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.location_city,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_controllerMain.isShowKeyTooltipProvince.value != true)
                      PulseContainer(
                        color: Colors.black.withOpacity(0.9),
                        onTapRoot: () {
                          debugPrint("roy93~ onTapRoot");
                          _controllerMain.setIsShowKeyTooltipProvince();
                        },
                        alignment: Alignment.center,
                        child: const Text(
                          'Dò kết qủa theo các tỉnh thành',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  // fit: StackFit.expand,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        _selectDay(DateTime.now(), false);
                        showSnackBarFull(
                          StringConstants.warning,
                          "Đang xem kết quả của ngày hôm nay\n${_controllerMain.getSelectedDayInStringXSMB()}",
                        );
                      },
                      color: Colors.pink,
                      padding: const EdgeInsets.all(0),
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.today,
                        color: Colors.white,
                      ),
                    ),
                    // Builder(builder: (context) {
                    //   return InkWell(
                    //     onTap: _controllerMain.isShowTooltipToday.value
                    //         ? () {
                    //             showRelativeDialog(
                    //                 context: context,
                    //                 alignment: Alignment.centerRight,
                    //                 builder: (context) {
                    //                   return WillPopScope(
                    //                     onWillPop: () {
                    //                       // debugPrint("WillPopScope isShowTooltipToday");
                    //                       SharedPreferencesUtil.setBool(
                    //                           SharedPreferencesUtil.keyTooltipTodayXSMN, true);
                    //                       _controllerMain.showTooltipToday(false);
                    //                       return Future(() => true);
                    //                     },
                    //                     child: Material(
                    //                       color: Colors.transparent,
                    //                       child: Container(
                    //                         decoration: const BoxDecoration(
                    //                           borderRadius: BorderRadius.all(Radius.circular(45.0)),
                    //                           color: Colors.white,
                    //                         ),
                    //                         padding: const EdgeInsets.all(16),
                    //                         child: const Text(
                    //                           'Dò kết qủa ngày hôm nay',
                    //                           style: TextStyle(
                    //                             fontWeight: FontWeight.w700,
                    //                             fontSize: 12,
                    //                             color: Colors.black,
                    //                           ),
                    //                           textAlign: TextAlign.center,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   );
                    //                 });
                    //           }
                    //         : null,
                    //     child: Container(
                    //       width: 1,
                    //       height: double.infinity,
                    //       color: Colors.transparent,
                    //     ),
                    //   );
                    // }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentView() {
    var isValid = _controllerMain.xsmnIsValidData.value;
    var isLoading = _controllerMain.xsmnIsLoading.value;
    var isNativeMode = _controllerMain.isNativeMode.value;
    var timeNow = DateTime.now().microsecondsSinceEpoch;
    var timeSelected = _controllerMain.xsmnSelectedDateTime.value.microsecondsSinceEpoch;
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
            height: 180,
            fit: BoxFit.cover,
          ),
          // const SizedBox(height: 16),
          const Text(
            "Đang tải dữ liệu...\nVui lòng chờ...",
            style: TextStyle(
              fontSize: 16,
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
            height: 180,
            fit: BoxFit.cover,
          ),
          // const SizedBox(height: 16),
          Text(
            "Chưa có kết quả xổ số vào ngày\n${_controllerMain.getSelectedDayInStringXSMN()}",
            style: const TextStyle(
              fontSize: 16,
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
                _selectDay(DateTime.now().subtract(const Duration(days: 1)), false);
              },
              child: const Text('Xem kết quả hôm qua'),
            ),
          ),
          const SizedBox(height: 8),
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
                _selectDay(DateTime.now(), true);
              },
              child: const Text('Làm mới'),
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
        child: WebViewWidget(controller: _controllerMain.xsmnWebViewController.value),
      );
    }
  }

  Widget _buildNativeView(bool isFuture) {
    if (isFuture) {
      return _buildFutureView();
    } else {
      var kqxs = _controllerMain.xsmnKqxs.value;
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
      var heightItem = 42.0;

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
    var selectedDateTime = _controllerMain.xsmnSelectedDateTime.value;
    var currentSearchNumber = _controllerMain.xsmnCurrentSearchNumber.value;
    var sCurrentSearchNumber = "";
    var isNativeMode = _controllerMain.isNativeMode.value;
    if (currentSearchNumber.isEmpty) {
      sCurrentSearchNumber = "Nhập vé số để tự động dò";
    } else {
      sCurrentSearchNumber = "Vé của tôi: $currentSearchNumber";
    }
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      color: Colors.white.withOpacity(0.9),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(45)),
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
                child: TextMarquee(
                  'Kết quả xổ số ngày ${selectedDateTime.day} tháng ${selectedDateTime.month} năm ${selectedDateTime.year}',
                ),
              ),
            ),
          ),
          if (isNativeMode) const SizedBox(width: 8),
          if (isNativeMode)
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                alignment: Alignment.centerRight,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(45)),
                  color: Colors.yellow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(45),
                          child: TextMarquee(
                            sCurrentSearchNumber,
                          ),
                          onTap: () {
                            Get.to(() => const SearchScreen(
                                  province: null,
                                  callFromScreen: XSMNScreen.path,
                                ));
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
            color: ColorConstants.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: const Text(
            "╲",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
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
    var wordsBlack = _controllerMain.getWordsHighlightXSMN(18);
    var wordsRed = _controllerMain.getWordsHighlightXSMN(16);
    return Column(
      children: [
        Container(
          width: widthItem,
          height: heightItem,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.25),
            color: ColorConstants.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextMarquee(
            "${dataWrapper.displayName}",
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

  void _selectDay(DateTime dateTime, bool isFirstInit) {
    _controllerMain.setSelectedDateTimeXSMN(dateTime, isFirstInit);
  }
}
