import 'package:applovin_max/applovin_max.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:blur/blur.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/common/const/hero_constants.dart';
import 'package:ketquaxoso/mckimquyen/common/const/string_constants.dart';
import 'package:ketquaxoso/mckimquyen/common/v/pulse_container.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/util/shared_preferences_util.dart';
import 'package:ketquaxoso/mckimquyen/util/ui_utils.dart';
import 'package:ketquaxoso/mckimquyen/util/url_launcher_utils.dart';
import 'package:ketquaxoso/mckimquyen/widget/applovin/applovin_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/introduction/introduction_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/controller_main.dart';
import 'package:ketquaxoso/mckimquyen/widget/setting/setting_screen.dart';
import 'package:lunar/calendar/Lunar.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:restart_app/restart_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfileScreen extends StatefulWidget {
  static String path = "ProfileScreen";

  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseStatefulState<ProfileScreen> {
  final ControllerMain _controllerMain = Get.find();

  void _initializeInterstitialAds() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
        // debugPrint('Interstitial ad loaded from ${ad.networkName}');
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        // Interstitial ad failed to load
        // debugPrint('Interstitial onAdLoadFailedCallback error $error');
      },
      onAdDisplayedCallback: (ad) {
        // debugPrint("onAdDisplayedCallback");
      },
      onAdDisplayFailedCallback: (ad, error) {
        // debugPrint("onAdDisplayFailedCallback");
      },
      onAdClickedCallback: (ad) {
        // debugPrint("onAdClickedCallback");
      },
      onAdHiddenCallback: (ad) {
        // debugPrint("onAdHiddenCallback");
      },
    ));

    // Load the first interstitial
    AppLovinMAX.loadInterstitial(getInterstitialAdUnitId());
  }

  Future<void> _showInterAd() async {
    bool isReady = (await AppLovinMAX.isInterstitialReady(getInterstitialAdUnitId())) ?? false;
    if (isReady) {
      AppLovinMAX.showInterstitial(getInterstitialAdUnitId());
    } else {
      // debugPrint('Loading interstitial ad...');
      AppLovinMAX.loadInterstitial(getInterstitialAdUnitId());
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeInterstitialAds();
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
        color: ColorConstants.bkg,
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/bkg_3.jpg",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ).blurred(
              colorOpacity: 0.0,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(0)),
              blur: 5,
            ),
            SafeArea(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    width: double.infinity,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                          height: 40,
                        ),
                        Expanded(
                          child: Hero(
                            tag: "${ProfileScreen.path}${HeroConstants.appBarTitle}",
                            child: const Material(
                              color: Colors.transparent,
                              child: Text(
                                "Cá nhân",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  fontSize: 24,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 5.0,
                                      color: Colors.black,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Hero(
                          tag: "${ProfileScreen.path}${HeroConstants.appBarLeftIcon}",
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            width: 40,
                            height: 40,
                            child: MaterialButton(
                              onPressed: () {
                                Get.to(() => SettingScreen(ProfileScreen.path));
                                _showInterAd();
                              },
                              color: Colors.white,
                              padding: const EdgeInsets.all(0),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                      children: [
                        AvatarGlow(
                          glowColor: Colors.white,
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.asset(
                              'assets/images/anim_2.gif',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(45.0)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              _buildClock(),
                              const Text(
                                "Ⓒmckimquyen",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Phiên bản ${_controllerMain.getAppVersion()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const Text(
                                "⇜-----------v-----------⇝",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  ToggleSwitch(
                                    minWidth: Get.width / 3,
                                    initialLabelIndex: _controllerMain.themeIndex.value,
                                    cornerRadius: 45.0,
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: Colors.grey,
                                    inactiveFgColor: Colors.white,
                                    totalSwitches: 2,
                                    labels: const ['Theme Tối ưu', 'Theme Web'],
                                    icons: const [
                                      Icons.looks_one,
                                      Icons.looks_two,
                                    ],
                                    activeBgColors: const [
                                      [ColorConstants.appColor],
                                      [ColorConstants.appColor]
                                    ],
                                    onToggle: (index) {
                                      // debugPrint('switched to: $index');
                                      _controllerMain.setThemeIndex(index);
                                      _showPopupRestart();
                                    },
                                  ),
                                  const PulseContainer(
                                    child: Text(
                                      'Bạn có thể lựa chọn giao diện tại đây\nChúng tôi khuyến cáo chọn Theme Tối Ưu\nsẽ cho trải nghiệm mượt mà hơn',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              UIUtils.getButton(
                                "Giới thiệu ứng dụng",
                                Icons.hotel_class,
                                description:
                                    "Chào mừng đến với ứng dụng KQXS, XSMN, XSMB, XSMT – ứng dụng tra cứu kết quả xổ số tiện lợi và đầy đủ tính năng dành cho cộng đồng yêu thích xổ số!",
                                () {
                                  Get.to(() => IntroductionScreen(ProfileScreen.path));
                                },
                              ),
                              UIUtils.getButton(
                                "Đánh giá ứng dụng",
                                Icons.hotel_class,
                                description: "Ứng dụng này hoàn toàn miễn phí, hãy đánh giá 5⭐bạn nhé!Tks bạn nhiều 😘",
                                () {
                                  UrlLauncherUtils.rateApp(null, null);
                                },
                              ),
                              UIUtils.getButton(
                                "Thêm ứng dụng",
                                Icons.card_giftcard,
                                description:
                                    "Có rất nhiều ứng dụng bổ ích khác nữa. Dĩ nhiên là cũng miễn phí. Bạn hãy tải về trải nghiệm nhé! 👉👈",
                                () {
                                  UrlLauncherUtils.moreApp();
                                },
                              ),
                              UIUtils.getButton(
                                "Chia sẻ ứng dụng",
                                Icons.ios_share,
                                description: "Nhấn vào đây để chia sẻ ứng dụng bổ ích này cho người thân của bạn 👉👈",
                                () async {
                                  final result = await Share.share(
                                      'https://play.google.com/store/apps/details?id=com.mckimquyen.kqxs');
                                  if (result.status == ShareResultStatus.success) {
                                    showSnackBarFull("KQXS", "Cảm ơn bạn đã chia sẻ 👉👈");
                                  }
                                },
                              ),
                              UIUtils.getButton(
                                "Chính sách bảo mật",
                                Icons.local_police,
                                description:
                                    "Nhấn vào đây để đọc chi tiết toàn bộ nội dung của chính sách bảo mật và quyền riêng tư ✍️",
                                () {
                                  UrlLauncherUtils.launchPolicy();
                                },
                              ),
                              UIUtils.getButton(
                                "Source code ở Github",
                                Icons.data_object,
                                description:
                                    "Nếu bạn là nhà phát triển và muốn đóng góp một chút công sức vào dự án. Hãy nhấn vào đây nhé 😇",
                                () {
                                  UrlLauncherUtils.launchInBrowser("https://github.com/gj-loitp/KetQuaXoSo");
                                },
                              ),
                              UIUtils.getButton(
                                "Xoá dữ liệu tooltip",
                                Icons.info,
                                description:
                                    "Ứng dụng sẽ hiển thị lại các mục tooltip, giống như lần đầu tiên bạn tải ứng dụng này về",
                                () {
                                  showSnackBarFull(StringConstants.warning,
                                      "Xoá dữ liệu tooltip thành công, bạn có thể sẽ cần khởi động lại để thấy kết quả");
                                  SharedPreferencesUtil.setBool(SharedPreferencesUtil.keyTooltipTheme, false);
                                  SharedPreferencesUtil.setBool(SharedPreferencesUtil.keyTooltipCalendarXSMN, false);
                                  SharedPreferencesUtil.setBool(SharedPreferencesUtil.keyTooltipCityXSMN, false);
                                  SharedPreferencesUtil.setBool(SharedPreferencesUtil.keyTooltipTodayXSMN, false);
                                },
                              ),
                              if (kDebugMode)
                                UIUtils.getButton(
                                  "Applovin (only in Debug mode)",
                                  Icons.ad_units,
                                  description: "",
                                  () {
                                    Get.to(() => const ApplovinScreen());
                                  },
                                ),
                            ],
                          ),
                        ),
                        AvatarGlow(
                          glowColor: Colors.white,
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.asset(
                              'assets/images/anim_2.gif',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildBannerAd(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPopupRestart() {
    PanaraInfoDialog.showAnimatedGrow(
      context,
      imagePath: "assets/images/anim_1.gif",
      title: "Kết quả xổ số",
      message: "Đã thay đổi giao diện thành công, bạn cần khởi động lại ứng dụng.",
      buttonText: "Okay",
      onTapDismiss: () {
        Restart.restartApp();
      },
      panaraDialogType: PanaraDialogType.custom,
      barrierDismissible: true,
      color: ColorConstants.appColor,
    );
  }

  Widget _buildBannerAd() {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
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

  Widget _buildClock() {
    final day = DateTime.now().day;
    final month = DateTime.now().month;
    final year = DateTime.now().year;
    Lunar date = Lunar.fromDate(DateTime.now());

    return Container(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Text(
            "Hôm nay ngày $day/$month/$year",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          Text(
            "(ngày âm lịch ${date.getDay()}/${date.getMonth()}/${date.getYear()})",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
