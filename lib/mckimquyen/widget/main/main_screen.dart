import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/vietlot/vietlot_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/xsmb/xsmb_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/xsmn/xsmn_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/xsmt/xsmt_screen.dart';
import '../../common/const/color_constants.dart';
import '../../common/const/string_constants.dart';
import '../../core/base_stateful_state.dart';
import '../../util/shared_preferences_util.dart';
import '../keep_alive_age.dart';
import '../profile/profile_screen.dart';
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

class _MainScreenState extends BaseStatefulState<MainScreen> {
  final ControllerMain _controllerMain = Get.find();
  final _controllerPage = PageController(initialPage: 0);

  final _controllerBottomBar = NotchBottomBarController(index: 0);

  var _isTouchBottomBarItem = false;

  @override
  void dispose() {
    _controllerMain.clearOnDispose();
    _controllerPage.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const KeepAlivePage(child: XSMNScreen()),
    const KeepAlivePage(child: XSMTScreen()),
    const KeepAlivePage(child: XSMBScreen()),
    const KeepAlivePage(child: VietlotScreen()),
    const KeepAlivePage(child: ProfileScreen()),
  ];

  @override
  void initState() {
    super.initState();
    _controllerMain.getPackageInfo();
    _controllerMain.getThemeIndex();
    _controllerMain.getIsOnTextOverflow();
    _controllerMain.getIsOnResultVietlotMax3d();
    _checkToShowDialogHello();
  }

  Future<void> _checkToShowDialogHello() async {
    void showPopup() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialogSuccess(
          const Material(
            child: Text(
              "Xin chào\nCảm ơn bạn đã ủng hộ ứng dụng tra cứu KQXS 3 miền\nChúng tôi cam kết hỗ trợ ứng dụng lâu dài và luôn lắng nghe ý kiến đóng góp của các bạn để ứng dụng có thể mang lại trải nghiệm tốt nhất\nNếu bạn thấy ứng dụng bổ ích, hãy đánh giá ứng dụng 5✩ và chia sẻ cho người thân của bạn nhé!\nYêu các bạn!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          "Không hiển thị lại",
          true,
          () {
            SharedPreferencesUtil.setBool(SharedPreferencesUtil.keyIsShowedDialogHello, true);
          },
        );
      });
    }

    var keyTooltipTheme = await SharedPreferencesUtil.getBool(SharedPreferencesUtil.keyTooltipTheme);
    if (keyTooltipTheme != true) {
      return;
    }
    var keyTooltipCalendarXSMN = await SharedPreferencesUtil.getBool(SharedPreferencesUtil.keyTooltipCalendarXSMN);
    if (keyTooltipCalendarXSMN != true) {
      return;
    }
    var keyTooltipCityXSMN = await SharedPreferencesUtil.getBool(SharedPreferencesUtil.keyTooltipCityXSMN);
    if (keyTooltipCityXSMN != true) {
      return;
    }

    SharedPreferencesUtil.getBool(SharedPreferencesUtil.keyIsShowedDialogHello).then((value) {
      if (value == true) {
        //do not show dialog hello again
      } else {
        showPopup();
      }
    });
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
    return PageView(
      controller: _controllerPage,
      physics: const NeverScrollableScrollPhysics(), //disable horizontal swipe
      children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
      onPageChanged: (int page) {
        // debugPrint("onPageChanged page $page");
        if (_isTouchBottomBarItem) {
          _isTouchBottomBarItem = false;
        } else {
          _controllerBottomBar.jumpTo(page);
        }
      },
    );
  }

  Widget? _buildBottomBar() {
    return AnimatedNotchBottomBar(
      showShadow: true,
      notchBottomBarController: _controllerBottomBar,
      color: Colors.white,
      showLabel: true,
      itemLabelStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w700,
        fontSize: 8,
      ),
      notchColor: Colors.white,
      showBlurBottomBar: false,
      removeMargins: true,
      // bottomBarWidth: 500,
      durationInMilliSeconds: 300,
      bottomBarItems: const [
        BottomBarItem(
          inActiveItem: Icon(
            Icons.looks_one_rounded,
            color: Colors.grey,
          ),
          activeItem: Icon(
            Icons.looks_one_rounded,
            color: ColorConstants.appColor,
          ),
          itemLabel: 'XSMN',
        ),
        BottomBarItem(
          inActiveItem: Icon(
            Icons.looks_two_rounded,
            color: Colors.grey,
          ),
          activeItem: Icon(
            Icons.looks_two_rounded,
            color: ColorConstants.appColor,
          ),
          itemLabel: 'XSMT',
        ),
        BottomBarItem(
          inActiveItem: Icon(
            Icons.looks_3_rounded,
            color: Colors.grey,
          ),
          activeItem: Icon(
            Icons.looks_3_rounded,
            color: ColorConstants.appColor,
          ),
          itemLabel: 'XSMB',
        ),
        BottomBarItem(
          inActiveItem: Icon(
            Icons.looks_4_rounded,
            color: Colors.grey,
          ),
          activeItem: Icon(
            Icons.looks_4_rounded,
            color: ColorConstants.appColor,
          ),
          itemLabel: 'Vietlott',
        ),
        BottomBarItem(
          inActiveItem: Icon(
            Icons.person,
            color: Colors.grey,
          ),
          activeItem: Icon(
            Icons.person,
            color: ColorConstants.appColor,
          ),
          itemLabel: 'Cá nhân',
        ),
      ],
      onTap: (index) {
        _isTouchBottomBarItem = true;
        _controllerPage.jumpToPage(index);
        // debugPrint('current selected index $index');
      },
      kIconSize: 20,
      kBottomRadius: 0,
      showTopRadius: true,
      showBottomRadius: true,
      // bottomBarHeight: 62,
      // topMargin: 10,
      shadowElevation: 15.0,
    );
  }
}
