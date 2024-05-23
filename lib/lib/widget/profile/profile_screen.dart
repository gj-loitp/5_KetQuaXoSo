import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:blur/blur.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/common/const/hero_constants.dart';
import 'package:ketquaxoso/lib/common/const/string_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/shared_preferences_util.dart';
import 'package:ketquaxoso/lib/util/ui_utils.dart';
import 'package:ketquaxoso/lib/util/url_launcher_utils.dart';
import 'package:ketquaxoso/lib/widget/applovin/applovin_screen.dart';
import 'package:ketquaxoso/lib/widget/information/thontinhuuich/information_screen.dart';
import 'package:ketquaxoso/lib/widget/introduction/introduction_screen.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';
import 'package:ketquaxoso/lib/widget/setting/setting_screen.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:relative_dialog/relative_dialog.dart';
import 'package:restart_app/restart_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfileScreen extends StatefulWidget {
  static String screenName = "/ProfileScreen";

  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseStatefulState<ProfileScreen> {
  final ControllerMain _controllerMain = Get.find();
  GlobalKey key = GlobalKey();

  var _interstitialRetryAttempt = 0;

  void _initializeInterstitialAds() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
        debugPrint('roy93~ nterstitial ad loaded from ${ad.networkName}');
        // Reset retry attempt
        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;
        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();
        debugPrint('roy93~ Interstitial ad failed to load with code ${error.code} - retrying in ${retryDelay}s');
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _showTooltip();
    });
  }

  Future<void> _showTooltip() async {
    var keyTooltipTheme = await SharedPreferencesUtil.getBool(SharedPreferencesUtil.keyTooltipTheme);
    if (keyTooltipTheme == true) {
      return;
    }
    RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    WidgetsBinding.instance.handlePointerEvent(PointerDownEvent(
      pointer: 0,
      position: position,
    ));
    WidgetsBinding.instance.handlePointerEvent(PointerUpEvent(
      pointer: 0,
      position: position,
    ));
  }

  @override
  void dispose() {
    _showInterAd();
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
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(8, 42, 8, 8),
                  width: double.infinity,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 40,
                        height: 40,
                      ),
                      const Expanded(
                        child: Hero(
                          tag: HeroConstants.appBarTitle,
                          child: Material(
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
                        tag: HeroConstants.appBarRightIcon,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          width: 40,
                          height: 40,
                          child: MaterialButton(
                            onPressed: () {
                              Get.to(() => const SettingScreen());
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
                _buildBannerAd(),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
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
                            Builder(builder: (context) {
                              return InkWell(
                                key: key,
                                child: const Text(
                                  "Chọn giao diện",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  showRelativeDialog(
                                      context: context,
                                      alignment: Alignment.bottomCenter,
                                      builder: (context) {
                                        return WillPopScope(
                                          onWillPop: () {
                                            // debugPrint("WillPopScope");
                                            SharedPreferencesUtil.setBool(SharedPreferencesUtil.keyTooltipTheme, true);
                                            return Future(() => true);
                                          },
                                          child: Material(
                                            color: Colors.transparent,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(45.0)),
                                                color: Colors.white,
                                              ),
                                              padding: const EdgeInsets.all(16),
                                              child: const Text(
                                                'Bạn có thể lựa chọn giao diện tại đây\nChúng tôi khuyến cáo chọn Theme Tối Ưu\nsẽ cho trải nghiệm mượt mà hơn',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              );
                            }),
                            const SizedBox(height: 16),
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
                            const SizedBox(height: 32),
                            //TODO roy93~ impl
                            // UIUtils.getButton(
                            //   "Lịch sử dò vé số",
                            //   Icons.history,
                            //   description: "Tra cứu lịch sử dò vé số của bạn 😤",
                            //   () {
                            //     Get.to(() => const HistoryScreen());
                            //   },
                            // ),
                            UIUtils.getButton(
                              "Tin tức",
                              Icons.info,
                              description: "Các thông tin hữu ích 😘",
                              () {
                                Get.to(() => const InformationScreen());
                                _showInterAd();
                              },
                            ),
                            //TODO roy93~ impl
                            // UIUtils.getButton(
                            //   "Xem tử vi trọn đời của 12 con giáp",
                            //   Icons.people_sharp,
                            //   description:
                            //       "Tử vi trọn đời cung cấp cho bạn thông tin tổng quát về tử vi phương đông của 12 con giáp.",
                            //   () {
                            //     Get.to(() => const TuViTronDoiScreen());
                            //   },
                            // ),
                            //TODO roy93~ impl
                            // UIUtils.getButton(
                            //   "Phong tục tập quán",
                            //   Icons.favorite,
                            //   description: "Phong tục tập quán - Phong tục ngày Tết Việt Nam",
                            //   () {
                            //     Get.to(() => const PhongTucTapQuanScreen());
                            //   },
                            // ),
                            // UIUtils.getButton(
                            //   "Phật pháp tổng hợp",
                            //   Icons.family_restroom,
                            //   description: "Cha mẹ, gia đình là điều quan trọng nhất trong cuộc đời mỗi con người",
                            //   () {
                            //     //TODO roy93~ ref https://ngaydep.com/phat-phap-ung-dung.html
                            //     showSnackBarFull(StringConstants.warning, StringConstants.comingSoon);
                            //   },
                            // ),
                            // UIUtils.getButton(
                            //   "Blog cuộc sống",
                            //   Icons.emoji_emotions,
                            //   description:
                            //       "Trong cuộc sống, chúng ta không thể tránh khỏi những phút giây mệt mỏi, áp lực hoặc những cảm xúc tiêu cực xảy đến mỗi ngày.",
                            //   () {
                            //     //TODO roy93~ ref https://ngaydep.com/blog-cuoc-song.html
                            //     showSnackBarFull(StringConstants.warning, StringConstants.comingSoon);
                            //   },
                            // ),
                            // UIUtils.getButton(
                            //   "Phong thủy đời sống",
                            //   Icons.warehouse_outlined,
                            //   description:
                            //       "Trưng bày cây cảnh trong phòng khách hay trong không gian ngôi nhà vốn là một thói quen tốt được nhiều người ưa chuộng.",
                            //   () {
                            //     //TODO roy93~ ref https://ngaydep.com/phong-thuy.html
                            //     showSnackBarFull(StringConstants.warning, StringConstants.comingSoon);
                            //   },
                            // ),
                            // UIUtils.getButton(
                            //   "Nhân tướng học - Xem tướng, xem nốt ruồi, xem chỉ tay",
                            //   Icons.monetization_on_rounded,
                            //   description: "Trang thông tin ngày giờ và tử vi",
                            //   () {
                            //     //TODO roy93~ ref https://ngaydep.com/xem-tuong.html
                            //     showSnackBarFull(StringConstants.warning, StringConstants.comingSoon);
                            //   },
                            // ),
                            // UIUtils.getButton(
                            //   "Bí mật về 12 cung hoàng đạo",
                            //   Icons.ac_unit_sharp,
                            //   description:
                            //       "Mỗi cung hoàng đạo đều có tính cách khác nhau, có người dễ tính, thoải mái nhưng cũng có người luôn muốn được phục tùng, chiều chuộng",
                            //   () {
                            //     //TODO roy93~ ref https://ngaydep.com/bi-mat-12-cung-hoang-dao.html
                            //     showSnackBarFull(StringConstants.warning, StringConstants.comingSoon);
                            //   },
                            // ),
                            UIUtils.getButton(
                              "Giới thiệu ứng dụng",
                              Icons.hotel_class,
                              description:
                                  "Chào mừng đến với ứng dụng KQXS, XSMN, XSMB, XSMT – ứng dụng tra cứu kết quả xổ số tiện lợi và đầy đủ tính năng dành cho cộng đồng yêu thích xổ số!",
                              () {
                                Get.to(() => IntroductionScreen(ProfileScreen.screenName));
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
              ],
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
      color: getBannerBackgroundColor(),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
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
}
