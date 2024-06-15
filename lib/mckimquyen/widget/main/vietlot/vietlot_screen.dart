import 'package:applovin_max/applovin_max.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/vietlot/power/power_screen.dart';

import '../../../common/const/color_constants.dart';
import '../../../core/base_stateful_state.dart';
import '../../applovin/applovin_screen.dart';
import '../../setting/setting_screen.dart';
import '../controller_main.dart';
import 'max3d/max3d_screen.dart';
import 'mega/mega_screen.dart';

class VietlotScreen extends StatefulWidget {
  const VietlotScreen({
    super.key,
  });

  @override
  State<VietlotScreen> createState() => _VietlotScreenState();
}

class _VietlotScreenState extends BaseStatefulState<VietlotScreen> {
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
        height: Get.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/bkg_3.jpg",
              height: Get.height,
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
                  Expanded(
                    child: Obx(() {
                      return ListView(
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => const MegaScreen());
                            },
                            child: Container(
                              height: Get.height / 7,
                              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Image.asset(
                                "assets/images/ic_mega.png",
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const PowerScreen());
                            },
                            child: Container(
                              height: Get.height / 7,
                              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Image.asset(
                                "assets/images/ic_power.png",
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_controllerMain.isSettingOnResultVietlotMax3d.value) {
                                Get.to(() => const Max3dScreen());
                              } else {
                                showDialogSuccess(
                                  const Material(
                                    child: Text(
                                      "Đây là tính năng đang trong giai đoạn thử nghiệm, có thể sẽ có lỗi không mong muốn xảy ra.\nBạn có thể bật/tắt tính năng tra cứu kết quả Max3D trong trang Cài đặt.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  "Cài đặt",
                                  "assets/files/test.json",
                                  true,
                                  () {
                                    Get.to(() => const SettingScreen());
                                  },
                                );
                              }
                            },
                            child: Container(
                              height: Get.height / 7,
                              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                color: _controllerMain.isSettingOnResultVietlotMax3d.value
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Stack(
                                children: [
                                  Opacity(
                                    opacity: _controllerMain.isSettingOnResultVietlotMax3d.value ? 1 : 0.5,
                                    child: Image.asset(
                                      "assets/images/ic_max.png",
                                      width: double.infinity,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(right: 8),
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                      "assets/images/ic_beta.png",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     showSnackBarFull(StringConstants.warning, StringConstants.comingSoon);
                          //   },
                          //   child: Container(
                          //     height: Get.height / 7,
                          //     margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          //     decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(16),
                          //     ),
                          //     child: Image.asset(
                          //       "assets/images/ic_keno.png",
                          //       width: double.infinity,
                          //       fit: BoxFit.contain,
                          //     ),
                          //   ),
                          // ),
                        ],
                      );
                    }),
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
}
