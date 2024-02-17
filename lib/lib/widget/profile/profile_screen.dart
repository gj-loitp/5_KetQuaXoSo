import 'package:avatar_glow/avatar_glow.dart';
import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/common/const/string_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/ui_utils.dart';
import 'package:ketquaxoso/lib/util/url_launcher_utils.dart';
import 'package:ketquaxoso/lib/widget/history/history_screen.dart';
import 'package:ketquaxoso/lib/widget/information/information_screen.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:restart_app/restart_app.dart';
import 'package:share_plus/share_plus.dart';
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
              ).blurred(
                colorOpacity: 0.0,
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(0)),
                blur: 5,
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                    width: double.infinity,
                    child: const Row(
                      children: [
                        // const SizedBox(
                        //   width: 40,
                        //   height: 40,
                        // ),
                        Expanded(
                          child: Text(
                            "Cá nhân",
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
                        // SizedBox(
                        //   width: 40,
                        //   height: 40,
                        //   child: MaterialButton(
                        //     onPressed: () {
                        //       Get.back();
                        //     },
                        //     color: Colors.white,
                        //     padding: const EdgeInsets.all(0),
                        //     shape: const CircleBorder(),
                        //     child: const Icon(
                        //       Icons.clear,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CupertinoScrollbar(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
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
                                  "Ⓒmckimquyen",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Phiên bản ${_controllerMain.getAppVersion()}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Text(
                                  "⇜-----------v-----------⇝",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 16),
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
                                  labels: const ['Theme Tối ưu', 'Theme Web'],
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
                                const SizedBox(height: 32),
                                UIUtils.getButton(
                                  "Lịch sử dò vé số",
                                  Icons.history,
                                  description: "Tra cứu lịch sử dò vé số của bạn 😤",
                                  () {
                                    Get.to(() => const HistoryScreen());
                                  },
                                ),
                                UIUtils.getButton(
                                  "Tin tức",
                                  Icons.info,
                                  description: "Các thông tin hữu ích 😘",
                                  () {
                                    Get.to(() => const InformationScreen());
                                  },
                                ),
                                UIUtils.getButton(
                                  "Xem tử vi trọn đời của 12 con giáp",
                                  Icons.people_sharp,
                                  description:
                                      "Tử vi trọn đời cung cấp cho bạn thông tin tổng quát về tử vi phương đông của 12 con giáp.",
                                  () {
                                    //TODO roy93~ ref https://ngaydep.com/tu-vi-tron-doi-cua-12-con-giap.html
                                    showSnackBarFull(StringConstants.warning, StringConstants.comingSoon);
                                  },
                                ),
                                UIUtils.getButton(
                                  "Đánh giá ứng dụng",
                                  Icons.hotel_class,
                                  description:
                                      "Ứng dụng này hoàn toàn miễn phí, hãy đánh giá 5⭐ bạn nhé!Tks bạn nhiều 😘",
                                  () {
                                    UrlLauncherUtils.rateApp(null, null);
                                  },
                                ),
                                UIUtils.getButton(
                                  "Thêm ứng dụng",
                                  Icons.card_giftcard,
                                  description:
                                      "Có rất nhiều ứng dụng bổ ích khác nữa. Dĩ nhiên là cũng miễn phí. Bạn hãy tải về trải nghiệm nhé! 👉👈",
                                  () {
                                    UrlLauncherUtils.moreApp();
                                  },
                                ),
                                UIUtils.getButton(
                                  "Chia sẻ ứng dụng",
                                  Icons.ios_share,
                                  description:
                                      "Nhấn vào đây để chia sẻ ứng dụng bổ ích này cho người thân của bạn 👉👈",
                                  () async {
                                    final result = await Share.shareWithResult(
                                        'https://play.google.com/store/apps/details?id=com.mckimquyen.kqxs');
                                    if (result.status == ShareResultStatus.success) {
                                      showSnackBarFull("KQXS", "Cảm ơn bạn đã chia sẻ 👉👈");
                                    }
                                  },
                                ),
                                UIUtils.getButton(
                                  "Chính sách bảo mật",
                                  Icons.local_police,
                                  description:
                                      "Nhấn vào đây để đọc chi tiết toàn bộ nội dung của chính sách bảo mật và quyền riêng tư ✍️",
                                  () {
                                    UrlLauncherUtils.launchPolicy();
                                  },
                                ),
                                UIUtils.getButton(
                                  "Source code ở Github",
                                  Icons.data_object,
                                  description:
                                      "Nếu bạn là nhà phát triển và muốn đóng góp một chút công sức vào dự án. Hãy nhấn vào đây nhé 😇",
                                  () {
                                    UrlLauncherUtils.launchInBrowser("https://github.com/gj-loitp/KetQuaXoSo");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
