import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/shared_preferences_util.dart';
import 'package:ketquaxoso/lib/widget/introduction/introduction_screen.dart';
import 'package:ketquaxoso/lib/widget/main/main_screen.dart';
import 'package:lunar/calendar/Lunar.dart';

class SplashScreen extends StatefulWidget {
  static String screenName = "/SplashScreen";

  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseStatefulState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToMainScreen();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: ColorConstants.appColor,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              "assets/images/bkg_1.png",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            _buildClock(),
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
      ),
    );
  }

  Widget _buildClock() {
    final day = DateTime.now().day;
    final month = DateTime.now().month;
    final year = DateTime.now().year;
    Lunar date = Lunar.fromDate(DateTime.now());

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Text(
              "Hôm nay ngày $day/$month/$year",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            Text(
              "(ngày âm lịch ${date.getDay()}/${date.getMonth()}/${date.getYear()})",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToMainScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    var keyIsShowedIntroduction = await SharedPreferencesUtil.getBool(SharedPreferencesUtil.keyIsShowedIntroduction);
    if (keyIsShowedIntroduction == true) {
      Get.off(() => const MainScreen());
    } else {
      Get.off(() => IntroductionScreen(SplashScreen.screenName));
    }
  }
}
