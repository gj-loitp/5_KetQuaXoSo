import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/widget/main/minhngoc/minhngoc_screen.dart';
import 'package:ketquaxoso/lib/widget/main/profile/profile_screen.dart';
import 'package:ketquaxoso/lib/widget/main/scan/scan_screen.dart';
import 'package:ketquaxoso/lib/widget/main/tracking/tracking_screen.dart';

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
  final ControllerMain _controllerMain = Get.put(ControllerMain());

  final _controllerPage = PageController(initialPage: 0);

  final _controllerBottomBar = NotchBottomBarController(index: 0);

  final int _maxCount = 5;
  var _isTouchBottomBarItem = false;

  @override
  void dispose() {
    _controllerMain.clearOnDispose();
    _controllerPage.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const MinhNgocScreen(),
    const ScanScreen(),
    const TrackingScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: UIUtils.getAppBar(
      //   "Kết quả xổ số",
      //   () {
      //     SystemNavigator.pop();
      //   },
      //   () {},
      //   iconData: Icons.policy,
      // ),
      body: PageView(
        controller: _controllerPage,
        physics: const BouncingScrollPhysics(),
        children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
        onPageChanged: (int page) {
          debugPrint("roy93~ onPageChanged page $page");
          if (_isTouchBottomBarItem) {
            _isTouchBottomBarItem = false;
          } else {
            _controllerBottomBar.jumpTo(page);
          }
        },
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= _maxCount)
          ? AnimatedNotchBottomBar(
        notchBottomBarController: _controllerBottomBar,
              color: Colors.white,
              showLabel: false,
              notchColor: Colors.white,
              removeMargins: false,
              bottomBarWidth: 500,
              durationInMilliSeconds: 300,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  activeItem: Icon(
                    Icons.home,
                    color: ColorConstants.appColor,
                  ),
                  itemLabel: 'Trang chủ',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.document_scanner,
                    color: Colors.grey,
                  ),
                  activeItem: Icon(
                    Icons.document_scanner,
                    color: ColorConstants.appColor,
                  ),
                  itemLabel: 'Dò vé số',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.history,
                    color: Colors.grey,
                  ),
                  activeItem: Icon(
                    Icons.history,
                    color: ColorConstants.appColor,
                  ),
                  itemLabel: 'Thống kê',
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
                // debugPrint('roy93~ current selected index $index');
              },
            )
          : null,
    );
  }
}
