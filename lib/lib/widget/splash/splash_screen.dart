import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/log_dog_utils.dart';
import 'package:ketquaxoso/lib/util/ui_utils.dart';
import 'package:ketquaxoso/lib/widget/demo_login/demo_login_screen.dart';

class SplashScreen extends StatefulWidget {
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
        child: Image.asset(
          "assets/images/bkg_1.png",
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _goToMainScreen() {
    Future.delayed(const Duration(milliseconds: 1500)).then((val) {
      Get.off(() => const DemoLoginScreen());
    });
  }
}
