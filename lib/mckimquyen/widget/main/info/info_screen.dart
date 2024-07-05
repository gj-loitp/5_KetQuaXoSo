import 'package:applovin_max/applovin_max.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/common/const/hero_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/widget/applovin/applovin_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/history/history_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/soccer/soccer_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/testApp/test_app_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/province/province_list_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/setting/setting_screen.dart';

import 'information/thontinhuuich/information_screen.dart';

class InfoScreen extends StatefulWidget {
  static String path = "InfoScreen";

  const InfoScreen({
    super.key,
  });

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends BaseStatefulState<InfoScreen> {
  // final ControllerMain _controllerMain = Get.find();
  GlobalKey key = GlobalKey();

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
      body: Container(
        alignment: Alignment.center,
        color: ColorConstants.bkg,
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/bkg_3.jpg",
              height: Get.height,
              width: Get.width,
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
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              "Phụ lục",
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
                        SizedBox(
                          width: 40,
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      children: [
                        _buildViewRow1(),
                        const SizedBox(height: 16),
                        _buildViewRow2(),
                        const SizedBox(height: 16),
                        _buildViewRow3(),
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

  Widget _buildViewRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildViewItem(
          "Dò theo\ntỉnh thành",
          "assets/images/ic_city.png",
          () {
            Get.to(() => ProvinceListScreen(InfoScreen.path));
          },
          "1icon",
          "1title",
        ),
        _buildViewItem(
          "Thông tin\nhữu ích",
          "assets/images/ic_info.png",
          () {
            Get.to(() => const InformationScreen());
          },
          "2icon",
          "2title",
        ),
        _buildViewItem(
          "Lịch sử\ndò nhanh",
          "assets/images/ic_history.png",
          () {
            Get.to(() => const HistoryScreen());
          },
          "3icon",
          "3title",
        ),
      ],
    );
  }

  Widget _buildViewRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildViewItem(
          "Cộng đồng\ntest app",
          "assets/images/ic_testing.png",
          () {
            Get.to(() => const TestAppScreen());
          },
          "4icon",
          "4title",
        ),
        _buildViewItem(
          "Hỗ trợ\nPhản hồi",
          "assets/images/ic_support.png",
          () {
            _showDialogSupport();
          },
          "5icon",
          "5title",
        ),
        _buildViewItem(
          "Cài đặt\nứng dụng",
          "assets/images/ic_settings.png",
          () {
            Get.to(() => SettingScreen(InfoScreen.path));
          },
          "${HeroConstants.appBarRightIcon}${InfoScreen.path}",
          "${HeroConstants.appBarTitle}${InfoScreen.path}",
        ),
      ],
    );
  }

  Widget _buildViewRow3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildViewItem(
          "CLB\nbóng đá",
          "assets/images/ic_ball.png",
          () {
            Get.to(() => SoccerScreen(InfoScreen.path));
          },
          "7icon",
          "7title",
        ),
        // _buildViewItem(
        //   "",
        //   "assets/images/ic_support.png",
        //   () {},
        // ),
        // _buildViewItem(
        //   "",
        //   "assets/images/ic_settings.png",
        //   () {},
        // ),
      ],
    );
  }

  Widget _buildViewItem(
    String text,
    String imgPath,
    GestureTapCallback onTap,
    String tagIcon,
    String tagTitle,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          border: Border.all(
            color: Colors.white.withOpacity(0.8),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        width: Get.width / 3.7,
        height: Get.width / 3.7,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: tagIcon,
                child: Image.asset(imgPath),
              ),
            ),
            Hero(
              tag: tagTitle,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
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

  Future<void> _showDialogSupport() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showDialogSuccess(
        const Material(
          child: Text(
            "Chào bạn :)\nNếu bạn gặp bất kỳ sự cố nào khi sử dụng ứng dụng hoặc cần hỗ trợ.\nHãy gửi email cho chúng tôi để nhận được giải đáp nhanh nhất trong vòng 24h.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        "Gửi email ngay",
        "assets/files/support.json",
        true,
        () {
          _sendEmail();
        },
      );
    });
  }

  Future<void> _sendEmail() async {
    final Email email = Email(
      body: 'Nhập phản hồi của bạn ở bên dưới nhé:',
      subject: '[V/v] Hỗ trợ cho ứng dụng KQXS',
      recipients: ['roy.mobile.dev@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
