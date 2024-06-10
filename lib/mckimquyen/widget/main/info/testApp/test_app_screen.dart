import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/util/ui_utils.dart';
import 'package:ketquaxoso/mckimquyen/util/url_launcher_utils.dart';
import 'package:slider_button/slider_button.dart';

class TestAppScreen extends StatefulWidget {
  const TestAppScreen({
    super.key,
  });

  @override
  State<TestAppScreen> createState() => _TestAppScreenState();
}

class _TestAppScreenState extends BaseStatefulState<TestAppScreen> {
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
                        const Material(
                          color: Colors.transparent,
                          child: Text(
                            "Cộng đồng test app",
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
                  Expanded(
                    child: _buildBody(),
                  ),
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(45.0)),
        color: Colors.white,
      ),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          _buildTextHeader("Giới thiệu về Cộng đồng test app"),
          _buildTextBody(
              "Hoan nghênh bạn đến với Cộng đồng test app. Đây là nơi mà bạn sẽ được trải nghiệm những ứng dụng đầu tiên từ nhà phát triển, trước khi các ứng dụng này được xuất bản công khai ra thị trường."),
          _buildTextHeader("Quyền lợi"),
          _buildTextBody(
              "Khi đăng ký thành công Cộng đồng test app, bạn sẽ được trải nghiệm ứng dụng đầu tiên. Bạn sẽ là người tiên phong và có quyền yêu cầu nhà phát triển chỉnh sửa phần mềm này theo nhu cầu của bạn."),
          _buildTextHeader("Cách đăng ký"),
          _buildTextBody(
              "Bằng cách nhấn vào nút Đăng Ký ở bên dưới. Bạn sẽ được điều hướng tham gia nhóm Tester của chúng tôi, sau đó bạn sẽ nhận được màn hình xác nhận tham gia nhóm. Nhấn nút Tham Gia/Join để hoàn tất quá trình đăng kí."),
          const SizedBox(height: 16),
          SliderButton(
            vibrationFlag: true,
            action: () async {
              _goToGroupTester();
              return false;
            },
            label: const Text(
              "Trượt sang phải để đăng ký",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            icon: const Text(
              "➤",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
            buttonColor: ColorConstants.appColor.withOpacity(0.8),
            backgroundColor: Colors.blue.withOpacity(0.5),
            highlightedColor: Colors.white,
            baseColor: ColorConstants.appColor,
          ),
          const SizedBox(height: 16),
          _buildTextBody(
              "Sau khi đã hoàn tất đăng ký vào Cộng đồng tester, bạn có thể click vào các nút bên dưới để trải nghịệm những ứng dụng mới nhất, sớm nhất từ chúng tôi."),
          UIUtils.getButton(
            "Cat Gallery",
            Icons.navigate_next,
            () {
              UrlLauncherUtils.launchInBrowser("https://play.google.com/store/apps/details?id=com.mckimquyen.gallery");
            },
          ),
          UIUtils.getButton(
            "Cat Scanner with history",
            Icons.navigate_next,
            () {
              UrlLauncherUtils.launchInBrowser(
                  "https://play.google.com/store/apps/details?id=com.mckimquyen.binaryeye");
            },
          ),
          UIUtils.getButton(
            "RSS Cat hub",
            Icons.navigate_next,
            () {
              UrlLauncherUtils.launchInBrowser("https://play.google.com/store/apps/details?id=com.mckimquyen.reader");
            },
          ),
          UIUtils.getButton(
            "Cat compass",
            Icons.navigate_next,
            () {
              UrlLauncherUtils.launchInBrowser("https://play.google.com/store/apps/details?id=com.mckimquyen.compass");
            },
          ),
          UIUtils.getButton(
            "Cute Cat Weather",
            Icons.navigate_next,
            () {
              UrlLauncherUtils.launchInBrowser(
                  "https://play.google.com/store/apps/details?id=com.mckimquyen.catweatherforecast");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextHeader(String s) {
    return Text(
      s,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextBody(String s) {
    return Text(
      s,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14,
        color: Colors.black.withOpacity(0.8),
      ),
    );
  }

  void _goToGroupTester() {
    debugPrint("roy93~ _goToGroupTester");
    UrlLauncherUtils.launchGroupTester();
  }
}
