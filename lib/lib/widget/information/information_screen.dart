import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/ui_utils.dart';
import 'package:ketquaxoso/lib/widget/htmlContent/html_content_screen.dart';
import 'package:ketquaxoso/lib/widget/information/const_information.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({
    super.key,
  });

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends BaseStatefulState<InformationScreen> {
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
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                  width: double.infinity,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 40,
                        height: 40,
                      ),
                      const Expanded(
                        child: Text(
                          "Thông tin hữu ích",
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
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoScrollbar(
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
                                "Hướng dẫn cách chơi xổ số miền bắc cho người mới chơi",
                                Icons.navigate_next,
                                () {
                                  Get.to(
                                    () => HtmlContentScreen(
                                      titleAppBar: "Hướng dẫn cách chơi xổ số miền bắc cho người mới chơi",
                                      htmlContent: ConstInformation.infor_0,
                                    ),
                                  );
                                },
                              ),
                              UIUtils.getButton(
                                "Cách chơi xổ số truyền thống miền Bắc khác gì với 2 miền còn lại?",
                                Icons.navigate_next,
                                () {
                                  Get.to(
                                    () => HtmlContentScreen(
                                      titleAppBar: "Cách chơi xổ số truyền thống miền Bắc khác gì với 2 miền còn lại?",
                                      htmlContent: ConstInformation.infor_1,
                                    ),
                                  );
                                },
                              ),
                              UIUtils.getButton(
                                "Thuế thu nhập trúng xổ số bao nhiêu phần trăm?",
                                Icons.navigate_next,
                                () {
                                  Get.to(
                                    () => HtmlContentScreen(
                                      titleAppBar: "Thuế thu nhập trúng xổ số bao nhiêu phần trăm?",
                                      htmlContent: ConstInformation.infor_2,
                                    ),
                                  );
                                },
                              ),
                              UIUtils.getButton(
                                "Nghị định 78/2012/NĐ-CP: Hiệu lực quản lý mới với hoạt động kinh doanh xổ số",
                                Icons.navigate_next,
                                () {
                                  Get.to(
                                    () => HtmlContentScreen(
                                      titleAppBar:
                                          "Nghị định 78/2012/NĐ-CP: Hiệu lực quản lý mới với hoạt động kinh doanh xổ số",
                                      htmlContent: ConstInformation.infor_3,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
