import 'package:applovin_max/applovin_max.dart';
import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/province/province_screen.dart';

import '../../../common/const/color_constants.dart';
import '../../../common/const/dimen_constants.dart';
import '../../../common/const/hero_constants.dart';
import '../../../core/base_stateful_state.dart';
import '../../applovin/applovin_screen.dart';
import '../controller_main.dart';

class ProvinceListScreen extends StatefulWidget {
  const ProvinceListScreen(
    this.from, {
    super.key,
  });

  final String from;

  @override
  State<ProvinceListScreen> createState() => _ProvinceListScreenState();
}

class _ProvinceListScreenState extends BaseStatefulState<ProvinceListScreen> {
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
    _controllerMain.genListProvince();
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
                  Hero(
                    tag: "${widget.from}${HeroConstants.appBar}",
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
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
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Text(
                                "Danh sách các đài",
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: _buildViewListProvince()),
                  _buildBannerAd(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewListProvince() {
    return Obx(() {
      var listProvince = _controllerMain.listProvince;
      return ListView.builder(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          physics: const BouncingScrollPhysics(),
          itemCount: listProvince.length,
          itemBuilder: (BuildContext context, int index) {
            var province = listProvince[index];
            return Hero(
              tag: "${HeroConstants.itemProvince}$index",
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.transparent,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${province.name}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.to(
                          () => ProvinceScreen(
                        province: province,
                        index: index,
                      ),
                    );
                    _showInterAd();
                  },
                ),
              ),
            );
          });
    });
  }

  Widget _buildBannerAd() {
    return Container(
      color: Colors.transparent,
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
