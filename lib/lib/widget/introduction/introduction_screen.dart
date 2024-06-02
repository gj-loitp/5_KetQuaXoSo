import 'package:animated_introduction/animated_introduction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/shared_preferences_util.dart';
import 'package:ketquaxoso/lib/widget/main/main_screen.dart';
import 'package:ketquaxoso/lib/widget/profile/profile_screen.dart';
import 'package:ketquaxoso/lib/widget/splash/splash_screen.dart';

class IntroductionScreen extends StatefulWidget {
  final String fromScreenName;

  const IntroductionScreen(
    this.fromScreenName, {
    super.key,
  });

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends BaseStatefulState<IntroductionScreen> {
  final List<SingleIntroScreen> pages = [
    const SingleIntroScreen(
      title: 'Chào mừng',
      description: 'Ứng dụng tra cứu kết quả xổ số tiện lợi và đầy đủ tính năng',
      imageAsset: 'assets/images/anim_1.gif',
      // headerBgColor: Colors.white,
      sideDotsBgColor: Colors.yellow,
      mainCircleBgColor: Colors.yellow,
      imageWithBubble: true,
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      slidePagePadding: EdgeInsets.all(4),
    ),
    const SingleIntroScreen(
      title: 'Tra cứu kết quả siêu tốc',
      description: 'Cập nhật nhanh chóng kết quả xổ số 3 miền',
      imageAsset: 'assets/images/anim_2.gif',
      // headerBgColor: Colors.white,
      sideDotsBgColor: Colors.yellow,
      mainCircleBgColor: Colors.yellow,
      imageWithBubble: true,
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    const SingleIntroScreen(
      title: 'Dễ dàng tìm kiếm',
      description: 'Nhập vé số để kiểm tra kết quả nhanh chóng',
      imageAsset: 'assets/images/anim_3.gif',
      // headerBgColor: Colors.white,
      sideDotsBgColor: Colors.yellow,
      mainCircleBgColor: Colors.yellow,
      imageWithBubble: true,
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedIntroduction(
        slides: pages,
        footerRadius: 45.0,
        containerBg: ColorConstants.white,
        // activeDotColor: Colors.white,
        // inactiveDotColor: Colors.grey,
        // footerBgColor: Colors.white,
        isFullScreen: false,
        textColor: Colors.white,
        footerGradients: const [
          ColorConstants.appColor,
          Colors.pink,
        ],
        indicatorType: IndicatorType.diamond,
        skipText: "Bỏ qua",
        nextText: "Tiếp theo",
        doneText: "Hoàn thành",
        onSkip: () {
          // debugPrint("onSkip widget.fromScreenName ${widget.fromScreenName}");
          if (widget.fromScreenName == ProfileScreen.screenName) {
            Get.back();
          } else if (widget.fromScreenName == SplashScreen.screenName) {
            SharedPreferencesUtil.setBool(SharedPreferencesUtil.keyIsShowedIntroduction, true);
            Get.off(() => const MainScreen());
          }
        },
        onDone: () {
          // debugPrint("onDone widget.fromScreenName ${widget.fromScreenName}");
          if (widget.fromScreenName == ProfileScreen.screenName) {
            Get.back();
          } else if (widget.fromScreenName == SplashScreen.screenName) {
            SharedPreferencesUtil.setBool(SharedPreferencesUtil.keyIsShowedIntroduction, true);
            Get.off(() => const MainScreen());
          }
        },
      ),
    );
  }
}
