import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/common/const/hero_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/controller_main.dart';

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
              ],
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
        _buildViewItem(),
        // _buildViewItem(),
        // _buildViewItem(),
      ],
    );
  }

  Widget _buildViewItem() {
    return Container(
      width: Get.width / 3.7,
      height: Get.width / 3.7,
      color: Colors.white,
    );
  }
}
