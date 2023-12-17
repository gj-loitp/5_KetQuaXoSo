import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/widget/main/profile/profile_screen.dart';
import 'package:ketquaxoso/lib/widget/main/scan/scan_screen.dart';
import 'package:ketquaxoso/lib/widget/main/xsmb/xsmb_screen.dart';
import 'package:ketquaxoso/lib/widget/main/xsmn/controller_xsmb.dart';
import 'package:ketquaxoso/lib/widget/main/xsmn/xsmn_screen.dart';
import 'package:ketquaxoso/lib/widget/main/xsmt/xsmt_screen.dart';

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
  final ControllerXSMN _controllerXSMN = Get.put(ControllerXSMN());
  final _controllerPage = PageController(initialPage: 0);

  final _controllerBottomBar = NotchBottomBarController(index: 0);

  var _isTouchBottomBarItem = false;

  @override
  void dispose() {
    _controllerXSMN.clearOnDispose();
    _controllerPage.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const XSMNScreen(),
    const XSMTScreen(),
    const XSMBScreen(),
    const ScanScreen(),
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
      ),
      extendBody: true,
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget? _buildBottomBar() {
    return Obx(() {
      if (bottomBarPages.length <= bottomBarPages.length && _controllerXSMN.isFullScreen.value) {
        return AnimatedNotchBottomBar(
          notchBottomBarController: _controllerBottomBar,
          color: Colors.white,
          showLabel: true,
          notchColor: Colors.white,
          showBlurBottomBar: false,
          removeMargins: false,
          bottomBarWidth: 500,
          durationInMilliSeconds: 300,
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: Icon(
                Icons.looks_one,
                color: Colors.grey,
              ),
              activeItem: Icon(
                Icons.looks_one,
                color: ColorConstants.appColor,
              ),
              itemLabel: 'XSMN',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.looks_two,
                color: Colors.grey,
              ),
              activeItem: Icon(
                Icons.looks_two,
                color: ColorConstants.appColor,
              ),
              itemLabel: 'XSMT',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.looks_3,
                color: Colors.grey,
              ),
              activeItem: Icon(
                Icons.looks_3,
                color: ColorConstants.appColor,
              ),
              itemLabel: 'XSMB',
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
        );
      } else {
        return Container();
      }
    });
  }
}
