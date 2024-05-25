import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/common/const/string_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/shared_preferences_util.dart';
import 'package:ketquaxoso/lib/widget/applovin/applovin_screen.dart';
import 'package:ketquaxoso/lib/widget/introduction/introduction_screen.dart';
import 'package:ketquaxoso/lib/widget/main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static String screenName = "/SplashScreen";

  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseStatefulState<SplashScreen> {

  var _interstitialRetryAttempt = 0;

  void _initializeInterstitialAds() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
        debugPrint('roy93~ onAdLoadedCallback ad loaded from ${ad.networkName}');
        // Reset retry attempt
        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;
        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();
        debugPrint('roy93~ onAdLoadFailedCallback ad failed to load with code ${error.code} - retrying in ${retryDelay}s');
        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(getInterstitialAdUnitId());
        });
      },
      onAdDisplayedCallback: (ad) {
        debugPrint("roy93~ onAdDisplayedCallback");
      },
      onAdDisplayFailedCallback: (ad, error) {
        debugPrint("roy93~ onAdDisplayFailedCallback");
      },
      onAdClickedCallback: (ad) {
        debugPrint("roy93~ onAdClickedCallback");
      },
      onAdHiddenCallback: (ad) {
        debugPrint("roy93~ onAdHiddenCallback");
      },
    ));

    // Load the first interstitial
    AppLovinMAX.loadInterstitial(getInterstitialAdUnitId());
  }

  Future<void> _showInterAd() async {
    bool isReady = (await AppLovinMAX.isInterstitialReady(getInterstitialAdUnitId())) ?? false;
    debugPrint('roy93~ _showInterAd isReady $isReady');
    if (isReady) {
      if (isApplovinDeviceTest()) {
        showSnackBarFull(StringConstants.warning, "showInterstitial successfully in test device");
      } else {
        AppLovinMAX.showInterstitial(getInterstitialAdUnitId());
      }
    } else {
      debugPrint('roy93~ Loading interstitial ad...');
      AppLovinMAX.loadInterstitial(getInterstitialAdUnitId());
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeInterstitialAds();
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

  Future<void> _goToMainScreen() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    var keyIsShowedIntroduction = await SharedPreferencesUtil.getBool(SharedPreferencesUtil.keyIsShowedIntroduction);
    if (keyIsShowedIntroduction == true) {
      Get.off(() => const MainScreen());
    } else {
      Get.off(() => IntroductionScreen(SplashScreen.screenName));
    }
    _showInterAd();
  }
}
