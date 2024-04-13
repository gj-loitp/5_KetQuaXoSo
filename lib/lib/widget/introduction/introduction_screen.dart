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
      title: 'Welcome to the Event Management App !',
      description: 'You plans your Events, We\'ll do the rest and will be the best! Guaranteed!  ',
      imageAsset: 'assets/onboard_one.png',
    ),
    const SingleIntroScreen(
      title: 'Book tickets to cricket matches and events',
      description: 'Tickets to the latest movies, crickets matches, concerts, comedy shows, plus lots more !',
      imageAsset: 'assets/onboard_two.png',
    ),
    const SingleIntroScreen(
      title: 'Grabs all events now only in your hands',
      description: 'All events are now in your hands, just a click away ! ',
      imageAsset: 'assets/onboard_three.png',
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
