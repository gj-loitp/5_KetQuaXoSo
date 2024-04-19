import 'package:applovin_max/applovin_max.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/common/const/dimen_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/widget/applovin/applovin_screen.dart';

class HtmlContentScreen extends StatefulWidget {
  final String? titleAppBar;
  final String? htmlContent;

  const HtmlContentScreen({
    super.key,
    required this.titleAppBar,
    required this.htmlContent,
  });

  @override
  State<HtmlContentScreen> createState() => _HtmlContentScreenState();
}

class _HtmlContentScreenState extends BaseStatefulState<HtmlContentScreen> {
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
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            widget.titleAppBar ?? "",
                            style: const TextStyle(
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        color: Colors.white,
                      ),
                      child: HtmlWidget(
                        widget.htmlContent ?? "",
                        renderMode: RenderMode.listView,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        enableCaching: false,
                        onTapUrl: (url) {
                          return true;
                        },
                      ),
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
