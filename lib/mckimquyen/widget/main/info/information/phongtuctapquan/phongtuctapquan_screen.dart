import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/util/ui_utils.dart';
import '../../htmlContent/html_content_screen.dart';
import 'const_phongtuctapquan.dart';

///TODO ref https://ngaydep.com/phong-tuc-tap-quan.html
class PhongTucTapQuanScreen extends StatefulWidget {
  const PhongTucTapQuanScreen({
    super.key,
  });

  @override
  State<PhongTucTapQuanScreen> createState() => _PhongTucTapQuanScreenState();
}

class _PhongTucTapQuanScreenState extends BaseStatefulState<PhongTucTapQuanScreen> {
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
                        const Expanded(
                          child: Text(
                            "Phong tục tập quán",
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
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(45.0)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              UIUtils.getButton(
                                "Một số lưu ý khi đi tảo mộ trong dịp tết thanh minh",
                                Icons.navigate_next,
                                    () {
                                  Get.to(
                                        () => HtmlContentScreen(
                                      titleAppBar: "Một số lưu ý khi đi tảo mộ trong dịp tết thanh minh",
                                      htmlContent: ConstPhongTucTapQuan.text0,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
