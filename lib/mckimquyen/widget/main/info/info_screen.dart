import 'package:applovin_max/applovin_max.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/common/const/hero_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/widget/applovin/applovin_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/controller_main.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/province/province_list_screen.dart';

import 'information/thontinhuuich/information_screen.dart';

class InfoScreen extends StatefulWidget {
  static String screenName = "/InfoScreen";

  const InfoScreen({
    super.key,
  });

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends BaseStatefulState<InfoScreen> {
  final ControllerMain _controllerMain = Get.find();
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
                          child: Hero(
                            tag: HeroConstants.appBarTitle,
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
          "Thông tin\nhữu ích",
          "assets/images/ic_info.png",
          () {
            Get.to(() => const InformationScreen());
          },
        ),
        _buildViewItem(
          "Dò theo\ntỉnh thành",
          "assets/images/ic_city.png",
          () {
            Get.to(() => ProvinceListScreen(InfoScreen.screenName));
          },
        ),
        //TODO roy93~ impl 20 tester close beta
        Opacity(
          opacity: 0.0,
          child: _buildViewItem(
            "Cộng đồng\ntest app",
            "assets/images/ic_testing.png",
            () {},
          ),
        ),
      ],
    );
  }

  Widget _buildViewItem(String text, String imgPath, GestureTapCallback onTap) {
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
              child: Image.asset(imgPath),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
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
