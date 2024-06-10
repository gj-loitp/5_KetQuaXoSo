import 'package:applovin_max/applovin_max.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/db/history.dart';

import '../../common/const/dimen_constants.dart';
import '../../core/base_stateful_state.dart';
import '../../formatter/date_text_formatter.dart';
import '../../model/province.dart';
import '../../util/duration_util.dart';
import '../applovin/applovin_screen.dart';
import '../main/controller_main.dart';
import '../main/province/province_screen.dart';
import '../main/xsmb/xsmb_screen.dart';
import '../main/xsmn/xsmn_screen.dart';
import '../main/xsmt/xsmt_screen.dart';

class SearchScreen extends StatefulWidget {
  final String callFromScreen;
  final Province? province;

  const SearchScreen({
    super.key,
    required this.callFromScreen,
    required this.province,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends BaseStatefulState<SearchScreen> {
  final ControllerMain _controllerMain = Get.find();
  final TextEditingController _tecNumber = TextEditingController();
  final TextEditingController _tecDate = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _initializeInterstitialAds() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
        debugPrint('roy93~ Interstitial ad loaded from ${ad.networkName}');
        // Reset retry attempt
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        // Interstitial ad failed to load
        debugPrint('roy93~ Interstitial onAdLoadFailedCallback error $error');
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
      AppLovinMAX.showInterstitial(getInterstitialAdUnitId());
    } else {
      debugPrint('roy93~ Loading interstitial ad...');
      AppLovinMAX.loadInterstitial(getInterstitialAdUnitId());
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeInterstitialAds();
    _tecNumber.addListener(() {
      var text = _tecNumber.text.toString();
      // debugPrint("text $text");
      if (widget.callFromScreen == XSMNScreen.path) {
        _controllerMain.setCurrentNumberXSMN(text);
      } else if (widget.callFromScreen == XSMTScreen.path) {
        _controllerMain.setCurrentNumberXSMT(text);
      } else if (widget.callFromScreen == ProvinceScreen.path) {
        _controllerMain.setCurrentNumberProvince(text);
      } else if (widget.callFromScreen == XSMBScreen.path) {
        _controllerMain.setCurrentNumberXSMB(text);
      }
    });
    _tecDate.addListener(() {
      var text = _tecDate.text.toString();
      if (widget.callFromScreen == XSMNScreen.path) {
        _controllerMain.setCurrentDateXSMN(text);
      } else if (widget.callFromScreen == XSMTScreen.path) {
        _controllerMain.setCurrentDateXSMT(text);
      } else if (widget.callFromScreen == ProvinceScreen.path) {
        _controllerMain.setCurrentDateProvince(text);
      } else if (widget.callFromScreen == XSMBScreen.path) {
        _controllerMain.setCurrentDateXSMB(text);
      }
    });
    DateTime currentSelectedDateTime;
    if (widget.callFromScreen == XSMNScreen.path) {
      currentSelectedDateTime = _controllerMain.xsmnSelectedDateTime.value;
    } else if (widget.callFromScreen == XSMTScreen.path) {
      currentSelectedDateTime = _controllerMain.xsmtSelectedDateTime.value;
    } else if (widget.callFromScreen == ProvinceScreen.path) {
      currentSelectedDateTime = _controllerMain.provinceSelectedDateTime.value;
    } else if (widget.callFromScreen == XSMBScreen.path) {
      currentSelectedDateTime = _controllerMain.xsmbSelectedDateTime.value;
    } else {
      currentSelectedDateTime = DateTime.now();
    }

    var sCurrentSelectedDateTime = DurationUtils.getFormattedDate(currentSelectedDateTime);
    // debugPrint("initState sCurrentSelectedDateTime $sCurrentSelectedDateTime");
    _tecDate.text = sCurrentSelectedDateTime;

    var sCurrentSearchNumber = "";
    if (widget.callFromScreen == XSMNScreen.path) {
      sCurrentSearchNumber = _controllerMain.xsmnCurrentSearchNumber.value;
    } else if (widget.callFromScreen == XSMTScreen.path) {
      sCurrentSearchNumber = _controllerMain.xsmtCurrentSearchNumber.value;
    } else if (widget.callFromScreen == ProvinceScreen.path) {
      sCurrentSearchNumber = _controllerMain.provinceCurrentSearchNumber.value;
    } else if (widget.callFromScreen == XSMBScreen.path) {
      sCurrentSearchNumber = _controllerMain.xsmbCurrentSearchNumber.value;
    }

    if (sCurrentSearchNumber.isNotEmpty) {
      _tecNumber.text = sCurrentSearchNumber;
    }

    //show keyboard & focus to _tecNumber
    DurationUtils.delay(300, () {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/bkg_3.jpg",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
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
                            _exitScreen();
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
                          "Nhập vé số của tôi",
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
                _buildBannerAd(),
                Obx(() {
                  return Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    height: 325,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Colors.white,
                    ),
                    child: _buildViewBody(),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewBody() {
    var msgInvalidCurrentSearchDate = "";
    if (widget.callFromScreen == XSMNScreen.path) {
      msgInvalidCurrentSearchDate = _controllerMain.msgInvalidCurrentSearchDateXSMN();
    } else if (widget.callFromScreen == XSMTScreen.path) {
      msgInvalidCurrentSearchDate = _controllerMain.msgInvalidCurrentSearchDateXSMT();
    } else if (widget.callFromScreen == ProvinceScreen.path) {
      msgInvalidCurrentSearchDate = _controllerMain.msgInvalidCurrentSearchDateProvince();
    } else if (widget.callFromScreen == XSMBScreen.path) {
      msgInvalidCurrentSearchDate = _controllerMain.msgInvalidCurrentSearchDateXSMB();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 32,
          width: double.infinity,
          color: Colors.white,
          child: const Text(
            "Mời nhập thông tin",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 52,
          color: Colors.white,
          alignment: Alignment.centerRight,
          child: Focus(
            child: TextField(
              focusNode: _focusNode,
              controller: _tecNumber,
              textInputAction: TextInputAction.next,
              inputFormatters: widget.callFromScreen == XSMBScreen.path
                  ? []
                  : [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
              maxLength: 6,
              keyboardType: widget.callFromScreen == XSMBScreen.path ? TextInputType.text : TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.local_atm),
                hintText: "Nhập đúng dãy số của bạn",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                  fontSize: 15,
                ),
                counterText: "",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
            onFocusChange: (value) {},
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 52,
          color: Colors.white,
          alignment: Alignment.centerRight,
          child: Focus(
            child: TextField(
              controller: _tecDate,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                DateTextFormatter(),
              ],
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                icon: Icon(Icons.date_range),
                hintText: "dd/MM/yyyy",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                  fontSize: 15,
                ),
                counterText: "",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
            onFocusChange: (value) {},
          ),
        ),
        Container(
          height: 32,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Text(
            msgInvalidCurrentSearchDate,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.redAccent,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          height: 52,
          margin: const EdgeInsets.fromLTRB(32, 8, 32, 0),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            onPressed: msgInvalidCurrentSearchDate.isEmpty
                ? () {
                    _showInterAd();
                    _applySearch();
                  }
                : null,
            child: const Text('Xác nhận'),
          ),
        ),
      ],
    );
  }

  void _applySearch() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (widget.callFromScreen == XSMNScreen.path) {
      _controllerMain.applySearchXSMN();
    } else if (widget.callFromScreen == XSMTScreen.path) {
      _controllerMain.applySearchXSMT();
    } else if (widget.callFromScreen == ProvinceScreen.path) {
      if (widget.province != null) {
        _controllerMain.applySearchProvince(widget.province!, false, false);
      }
    } else if (widget.callFromScreen == XSMBScreen.path) {
      _controllerMain.applySearchXSMB();
    }
    _controllerMain.insertHistory(
      History(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        callFromScreen: widget.callFromScreen,
        province: widget.province,
      ),
    );
    _exitScreen();
  }

  void _exitScreen() {
    _focusNode.unfocus();
    final keyBoardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    if (keyBoardVisible) {
      ///need delay for beauty efx
      DurationUtils.delay(200, () {
        Get.back();
      });
    } else {
      Get.back();
    }
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
