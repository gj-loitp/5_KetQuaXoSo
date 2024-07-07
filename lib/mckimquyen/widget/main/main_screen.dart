import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/info_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/profile/profile_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/vietlot/vietlot_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/xsmb/xsmb_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/xsmn/xsmn_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/xsmt/xsmt_screen.dart';

import '../../common/const/color_constants.dart';
import '../../common/const/string_constants.dart';
import '../../core/base_stateful_state.dart';
import '../../util/shared_preferences_util.dart';
import '../keep_alive_age.dart';
import 'controller_main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    this.title,
  });

  final String? title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends BaseStatefulState<MainScreen> with SingleTickerProviderStateMixin {
  final ControllerMain _controllerMain = Get.find();
  final _controllerPage = PageController(initialPage: 0);
  final List<Widget> bottomBarPages = [
    const KeepAlivePage(child: XSMNScreen()),
    const KeepAlivePage(child: XSMTScreen()),
    const KeepAlivePage(child: XSMBScreen()),
    const KeepAlivePage(child: VietlotScreen()),
    const KeepAlivePage(child: InfoScreen()),
    const KeepAlivePage(child: ProfileScreen()),
  ];

  @override
  void initState() {
    super.initState();
    _controllerMain.getPackageInfo();
    _controllerMain.getThemeIndex();
    _controllerMain.getIsOnTextOverflow();
    _controllerMain.getIsOnResultVietlotMax3d();
    _controllerMain.tabControllerMain = TabController(length: bottomBarPages.length, vsync: this);
  }

  @override
  void dispose() {
    _controllerMain.clearOnDispose();
    _controllerPage.dispose();
    _controllerMain.tabControllerMain?.dispose();
    super.dispose();
  }

  DateTime _backPressTime = DateTime.now();

  Future<bool> exitApp() {
    DateTime now = DateTime.now();
    if (now.difference(_backPressTime) < const Duration(seconds: 2)) {
      return Future(() => true);
    } else {
      _backPressTime = DateTime.now();
      showSnackBarFull(StringConstants.warning, "Vui lòng nhấn thêm lần nữa để tắt ứng ");
      return Future(() => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      connectionNotificationOptions: const ConnectionNotificationOptions(
        connectedText: "Đã có kết nối mạng",
        disconnectedText: "Không có kết nối, đang cố gắng thử lại",
        connectedBackgroundColor: Colors.blueAccent,
        disconnectedBackgroundColor: Colors.black,
        connectedTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        disconnectedTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      child: WillPopScope(
        onWillPop: exitApp,
        child: Scaffold(
          body: _buildPageView(),
          extendBody: true,
          bottomNavigationBar: _buildBottomBar(),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _controllerMain.tabControllerMain,
      children: bottomBarPages,
    );
  }

  Widget? _buildBottomBar() {
    return Container(
      color: Colors.grey,
      padding: const EdgeInsets.only(top: 1),
      child: Container(
        color: Colors.white,
        height: 48,
        child: TabBar(
          indicatorColor: ColorConstants.appColor,
          labelColor: ColorConstants.appColor,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
          labelPadding: EdgeInsets.zero,
          // dividerColor: ColorConstants.appColor,
          // dividerHeight: 0.0,
          // physics: const BouncingScrollPhysics(),
          splashBorderRadius: const BorderRadius.all(Radius.circular(0)),
          tabAlignment: TabAlignment.fill,
          tabs: const <Tab>[
            Tab(
              icon: Icon(Icons.looks_one_outlined),
              text: "XSMN",
              iconMargin: EdgeInsets.only(bottom: 2.0),
            ),
            Tab(
              icon: Icon(Icons.looks_two_outlined),
              text: "XSMT",
              iconMargin: EdgeInsets.only(bottom: 2.0),
            ),
            Tab(
              icon: Icon(Icons.looks_3_outlined),
              text: "XSMB",
              iconMargin: EdgeInsets.only(bottom: 2.0),
            ),
            Tab(
              icon: Icon(Icons.looks_4_outlined),
              text: "Vietlot",
              iconMargin: EdgeInsets.only(bottom: 2.0),
            ),
            Tab(
              icon: Icon(Icons.location_city),
              text: "Phụ lục",
              iconMargin: EdgeInsets.only(bottom: 2.0),
            ),
            Tab(
              icon: Icon(Icons.person),
              text: "Cá nhân",
              iconMargin: EdgeInsets.only(bottom: 2.0),
            ),
          ],
          // setup the controller
          controller: _controllerMain.tabControllerMain,
        ),
      ),
    );
  }
}
