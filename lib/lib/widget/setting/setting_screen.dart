import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/common/const/hero_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
      child: Column(
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
            margin: const EdgeInsets.only(top: 16),
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
              initialLabelIndex: 1,
              totalSwitches: 2,
              labels: ['Bật', 'Tắt'],
              radiusStyle: true,
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
          ),
        ],
      ),
    );
  }
}
