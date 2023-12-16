import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/shared_preferences_util.dart';
import 'package:ketquaxoso/lib/widget/main/profile/controller_profile.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseStatefulState<ProfileScreen> {
  final _controllerProfile = Get.put(ControllerProfile());

  @override
  void initState() {
    super.initState();
    _controllerProfile.getThemeIndex();
  }

  @override
  void dispose() {
    _controllerProfile.clearOnDispose();
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
                          initialLabelIndex: _controllerProfile.themeIndex.value,
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
                            _controllerProfile.setThemeIndex(index);
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
}
