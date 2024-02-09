import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';

class VietlotScreen extends StatefulWidget {
  const VietlotScreen({
    super.key,
  });

  @override
  State<VietlotScreen> createState() => _VietlotScreenState();
}

class _VietlotScreenState extends BaseStatefulState<VietlotScreen> {
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
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                InkWell(
                  onTap: () {
                    //TODO roy93~
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
                    //TODO roy93~
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
                    //TODO roy93~
                  },
                  child: Container(
                    height: Get.height / 7,
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      "assets/images/ic_max.png",
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //TODO roy93~
                  },
                  child: Container(
                    height: Get.height / 7,
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      "assets/images/ic_keno.png",
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
