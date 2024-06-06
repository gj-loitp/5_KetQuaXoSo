import 'dart:async';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunar/calendar/Lunar.dart';

import '../../common/const/color_constants.dart';
import '../../common/const/string_constants.dart';
import '../../core/base_stateful_state.dart';
import '../../util/shared_preferences_util.dart';
import '../applovin/applovin_screen.dart';
import '../introduction/introduction_screen.dart';
import '../main/controller_main.dart';
import '../main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static String screenName = "/SplashScreen";

  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseStatefulState<SplashScreen> {
  final ControllerMain _controllerMain = Get.find();
  Timer? _timer;

  void _initializeInterstitialAds() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
        debugPrint('roy93~ Interstitial ad loaded from ${ad.networkName}');
        _goToMainScreen();
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        // Interstitial ad failed to load
        debugPrint('roy93~ Interstitial onAdLoadFailedCallback error $error');
        _goToMainScreen();
      },
      onAdDisplayedCallback: (ad) {
        debugPrint("roy93~ Interstitial onAdDisplayedCallback");
      },
      onAdDisplayFailedCallback: (ad, error) {
        debugPrint("roy93~ Interstitial onAdDisplayFailedCallback");
      },
      onAdClickedCallback: (ad) {
        debugPrint("roy93~ Interstitial onAdClickedCallback");
      },
      onAdHiddenCallback: (ad) {
        debugPrint("roy93~ Interstitial onAdHiddenCallback");
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
    _controllerMain.isInitializePluginApplovinFinished.listen((isInitializePluginApplovinFinished) {
      debugPrint("roy93~ initState isInitializePluginApplovinFinished $isInitializePluginApplovinFinished");
      if (isInitializePluginApplovinFinished) {
        var timeStartApp = _controllerMain.timeStartApp.value;
        var timeNow = DateTime.now().millisecondsSinceEpoch;
        debugPrint("roy93~ initializePlugin timeStartApp $timeStartApp");
        debugPrint("roy93~ initializePlugin timeNow $timeNow");
        debugPrint("roy93~ initializePlugin duration ${timeNow - timeStartApp}");
        _initializeInterstitialAds();
        _timer = Timer(const Duration(seconds: 10), () {
          _goToMainScreen();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
    _timer?.cancel();
    var keyIsShowedIntroduction = await SharedPreferencesUtil.getBool(SharedPreferencesUtil.keyIsShowedIntroduction);
    if (keyIsShowedIntroduction == true) {
      Get.off(() => const MainScreen());
    } else {
      Get.off(() => IntroductionScreen(SplashScreen.screenName));
    }
    _showInterAd();
  }
}
