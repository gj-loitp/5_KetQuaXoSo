import 'package:animated_introduction/animated_introduction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({
    super.key,
  });

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends BaseStatefulState<IntroductionScreen> {
  final List<SingleIntroScreen> pages = [
    const SingleIntroScreen(
      title: 'Chào mừng đến với ứng dụng "KQXS, XSMN, XSMB, XSMT"',
      description: 'Ứng dụng tra cứu kết quả xổ số tiện lợi và đầy đủ tính năng dành cho cộng đồng yêu thích xổ số!',
      imageAsset: 'assets/images/anim_1.gif',
      // headerBgColor: Colors.white,
      sideDotsBgColor: Colors.yellow,
      mainCircleBgColor: Colors.yellow,
      imageWithBubble: true,
    ),
    const SingleIntroScreen(
      title: 'Tra cứu kết quả siêu tốc:',
      description: 'Cập nhật nhanh chóng kết quả xổ số 3 miền: miền nam, miền trung, miền bắc',
      imageAsset: 'assets/images/anim_2.gif',
      // headerBgColor: Colors.white,
      sideDotsBgColor: Colors.yellow,
      mainCircleBgColor: Colors.yellow,
      imageWithBubble: true,
    ),
    const SingleIntroScreen(
      title: 'Dễ dàng tìm kiếm thông tin xổ số Vietlot, Power, Mega',
      description: 'Nhập con số vé số để kiểm tra kết quả một cách nhanh chóng và thuận tiện.',
      imageAsset: 'assets/images/anim_3.gif',
      // headerBgColor: Colors.white,
      sideDotsBgColor: Colors.yellow,
      mainCircleBgColor: Colors.yellow,
      imageWithBubble: true,
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
          debugPrint("roy93~ onSkip");
          Get.back();
        },
        onDone: () {
          debugPrint("roy93~ onDone");
          Get.back();
        },
      ),
    );
  }
}
