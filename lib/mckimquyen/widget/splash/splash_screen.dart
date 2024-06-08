import 'dart:async';

import 'package:applovin_max/applovin_max.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunar/calendar/Lunar.dart';

import '../../common/const/color_constants.dart';
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
  final int durationCountdown = 10;

  void _initializeInterstitialAds() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
        debugPrint('roy93~ Interstitial ad loaded from ${ad.networkName}');
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        // Interstitial ad failed to load
        debugPrint('roy93~ Interstitial onAdLoadFailedCallback error $error');
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
      AppLovinMAX.showInterstitial(getInterstitialAdUnitId());
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
      }
    });
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
            Column(
              children: [
                const Spacer(),
                AvatarGlow(
                  glowColor: Colors.white,
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        minimumSize: const Size(180, 180),
                      ),
                      onPressed: () {
                        _goToMainScreen();
                      },
                      child: const Text(
                        'Nhấn Vào\nTrang Chủ',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Tự động vào trang chủ sau ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    CircularCountDownTimer(
                      duration: durationCountdown,
                      initialDuration: 0,
                      controller: CountDownController(),
                      width: 38,
                      height: 38,
                      ringColor: Colors.transparent,
                      ringGradient: null,
                      fillColor: Colors.white,
                      fillGradient: null,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      backgroundGradient: null,
                      strokeWidth: 2.0,
                      strokeCap: StrokeCap.round,
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textFormat: CountdownTextFormat.S,
                      isReverse: true,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: true,
                      onStart: () {
                        debugPrint('roy93~ Countdown Started');
                      },
                      onComplete: () {
                        debugPrint('roy93~ Countdown Ended');
                        _goToMainScreen();
                      },
                      onChange: (String timeStamp) {
                        debugPrint('roy93~ Countdown Changed $timeStamp');
                      },
                      timeFormatterFunction: (defaultFormatterFunction, duration) {
                        return Function.apply(defaultFormatterFunction, [duration]);
                        // if (duration.inSeconds == 0) {
                        //   return "0";
                        // } else {
                        //   return Function.apply(defaultFormatterFunction, [duration]);
                        // }
                      },
                    ),
                    const Text(
                      " giây.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildBannerAd(),
              ],
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

  Widget _buildBannerAd() {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: MaxAdView(
        adUnitId: getBannerAdUnitId(),
        adFormat: AdFormat.banner,
        listener: AdViewAdListener(onAdLoadedCallback: (ad) {
          debugPrint('Banner widget ad loaded from ${ad.networkName}');
        }, onAdLoadFailedCallback: (adUnitId, error) {
          debugPrint('Banner widget ad failed to load with error code ${error.code} and message: ${error.message}');
        }, onAdClickedCallback: (ad) {
          debugPrint('Banner widget ad clicked');
        }, onAdExpandedCallback: (ad) {
          debugPrint('Banner widget ad expanded');
        }, onAdCollapsedCallback: (ad) {
          debugPrint('Banner widget ad collapsed');
        }, onAdRevenuePaidCallback: (ad) {
          debugPrint('Banner widget ad revenue paid: ${ad.revenue}');
        }),
      ),
    );
  }

  Future<void> _goToMainScreen() async {
    _showInterAd();
    var keyIsShowedIntroduction = await SharedPreferencesUtil.getBool(SharedPreferencesUtil.keyIsShowedIntroduction);
    if (keyIsShowedIntroduction == true) {
      Get.off(() => const MainScreen());
    } else {
      Get.off(() => IntroductionScreen(SplashScreen.screenName));
    }
  }
}
