import 'package:applovin_max/applovin_max.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../common/const/color_constants.dart';
import '../../common/const/dimen_constants.dart';
import '../../common/const/hero_constants.dart';
import '../../core/base_stateful_state.dart';
import '../applovin/applovin_screen.dart';
import '../main/controller_main.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends BaseStatefulState<SettingScreen> {
  final ControllerMain _controllerMain = Get.find();

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
        child: Stack(
          alignment: Alignment.center,
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
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Hero(
                          tag: HeroConstants.appBarRightIcon,
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: MaterialButton(
                              onPressed: () {
                                Get.back();
                              },
                              color: Colors.white,
                              padding: const EdgeInsets.all(0),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.clear,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Hero(
                            tag: HeroConstants.appBarTitle,
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                "Cài đặt",
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
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildBody(),
                  const Spacer(),
                  _buildBannerAd(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(45.0)),
        color: Colors.white,
      ),
      child: _buildColumn(),
    );
  }

  Widget _buildColumn() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bật/tắt tính năng chữ chạy khi nội dung Text không đủ khoảng trống",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 16, 0, 32),
            alignment: Alignment.center,
            child: ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 45.0,
              activeBgColors: const [
                [ColorConstants.appColor],
                [ColorConstants.appColor]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: _controllerMain.isSettingOnTextOverflow.value ? 1 : 0,
              totalSwitches: 2,
              labels: const ['Tắt', 'Bật'],
              radiusStyle: true,
              onToggle: (index) {
                _controllerMain.setIsOnTextOverflow((index == 1) ? true : false);
              },
            ),
          ),
          const Text(
            "(Beta) Bật/tắt kết quả xổ số Vietlot Max3D",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const Text(
            "Lưu ý: Đây là tính năng đang trong quá trình thử nghiệm, có thể sẽ có lỗi không mong muốn sẽ xảy ra",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Colors.redAccent,
              decoration: TextDecoration.underline,
              decorationColor: Colors.redAccent,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            alignment: Alignment.center,
            child: ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 45.0,
              activeBgColors: const [
                [ColorConstants.appColor],
                [ColorConstants.appColor]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: _controllerMain.isSettingOnResultVietlotMax3d.value ? 1 : 0,
              totalSwitches: 2,
              labels: const ['Tắt', 'Bật'],
              radiusStyle: true,
              onToggle: (index) {
                _controllerMain.setIsOnResultVietlotMax3d((index == 1) ? true : false);
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildBannerAd() {
    return Container(
      color: getBannerBackgroundColor(),
      margin: const EdgeInsets.only(top: DimenConstants.marginPaddingSmall),
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
