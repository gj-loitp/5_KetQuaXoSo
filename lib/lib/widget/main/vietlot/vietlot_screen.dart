import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';
import 'package:ketquaxoso/lib/widget/main/vietlot/max3d/max3d_screen.dart';
import 'package:ketquaxoso/lib/widget/main/vietlot/mega/mega_screen.dart';
import 'package:ketquaxoso/lib/widget/main/vietlot/power/power_screen.dart';
import 'package:ketquaxoso/lib/widget/setting/setting_screen.dart';

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
            Obx(() {
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
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
          ],
        ),
      ),
    );
  }
}
