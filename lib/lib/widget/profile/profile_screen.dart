import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/ui_utils.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:restart_app/restart_app.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseStatefulState<ProfileScreen> {
  final ControllerMain _controllerMain = Get.find();

  @override
  void initState() {
    super.initState();
    _controllerMain.getThemeIndex();
  }

  @override
  void dispose() {
    // _controllerMain.clearOnDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
          alignment: Alignment.center,
          color: ColorConstants.bkg,
          child: Stack(
            children: [
              Image.asset(
                "assets/images/bkg_3.jpg",
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: double.infinity,
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
                  AvatarGlow(
                    glowColor: Colors.white,
                    endRadius: 60.0,
                    showTwoGlows: true,
                    child: Image.asset(
                      'assets/images/anim_2.gif',
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Chọn giao diện",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ToggleSwitch(
                          minWidth: Get.width / 3,
                          initialLabelIndex: _controllerMain.themeIndex.value,
                          cornerRadius: 45.0,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          totalSwitches: 2,
                          labels: const ['Native view', 'Webview'],
                          icons: const [
                            Icons.looks_one,
                            Icons.looks_two,
                          ],
                          activeBgColors: const [
                            [ColorConstants.appColor],
                            [ColorConstants.appColor]
                          ],
                          onToggle: (index) {
                            debugPrint('switched to: $index');
                            _controllerMain.setThemeIndex(index);
                            _showPopupRestart();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showPopupRestart() {
    PanaraInfoDialog.showAnimatedGrow(
      context,
      imagePath: "assets/images/anim_1.gif",
      title: "Kết quả xổ số",
      message: "Đã thay đổi giao diện thành công, bạn cần khởi động lại ứng dụng.",
      buttonText: "Okay",
      onTapDismiss: () {
        Restart.restartApp();
      },
      panaraDialogType: PanaraDialogType.custom,
      barrierDismissible: true,
      color: ColorConstants.appColor,
    );
  }
}
