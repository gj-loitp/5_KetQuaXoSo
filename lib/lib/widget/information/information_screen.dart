import 'package:blur/blur.dart';
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
                        const SizedBox(width: 16,),
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
                            textAlign: TextAlign.start,
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
                                        htmlContent: infor_0,
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
                                        titleAppBar:
                                            "Cách chơi xổ số truyền thống miền Bắc khác gì với 2 miền còn lại?",
                                        htmlContent: infor_1,
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
                                        htmlContent: infor_2,
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
                                        htmlContent: infor_3,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Thay đổi giờ mở thưởng Xổ số Miền Bắc",
                                  Icons.navigate_next,
                                  () {
                                    Get.to(
                                      () => HtmlContentScreen(
                                        titleAppBar: "Thay đổi giờ mở thưởng Xổ số Miền Bắc",
                                        htmlContent: infor_4,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Đổi số trúng đặc biệt ở đâu và thủ tục như thế nào?",
                                  Icons.navigate_next,
                                  () {
                                    Get.to(
                                      () => HtmlContentScreen(
                                        titleAppBar: "Đổi số trúng đặc biệt ở đâu và thủ tục như thế nào?",
                                        htmlContent: infor_5,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Khuyến cáo khi đổi số trúng",
                                  Icons.navigate_next,
                                  () {
                                    Get.to(
                                      () => HtmlContentScreen(
                                        titleAppBar: "Khuyến cáo khi đổi số trúng",
                                        htmlContent: infor_6,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Mức chi hoa hồng đại lý của các loại hình xổ số",
                                  Icons.navigate_next,
                                  () {
                                    Get.to(
                                      () => HtmlContentScreen(
                                        titleAppBar: "Mức chi hoa hồng đại lý của các loại hình xổ số",
                                        htmlContent: infor_7,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Hướng dẫn cách chơi xổ số kiến thiết miền Nam mới nhất",
                                  Icons.navigate_next,
                                  () {
                                    Get.to(
                                      () => HtmlContentScreen(
                                        titleAppBar: "Hướng dẫn cách chơi xổ số kiến thiết miền Nam mới nhất",
                                        htmlContent: infor_8,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Bật mí 5+ cách tính lô đề miền Nam của các chuyên gia",
                                  Icons.navigate_next,
                                  () {
                                    Get.to(
                                      () => HtmlContentScreen(
                                        titleAppBar: "Bật mí 5+ cách tính lô đề miền Nam của các chuyên gia",
                                        htmlContent: infor_9,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Số 0 có ý nghĩa gì? Luận giải chi tiết về số 0 bạn nên biết",
                                  Icons.navigate_next,
                                  () {
                                    Get.to(
                                      () => HtmlContentScreen(
                                        titleAppBar: "Số 0 có ý nghĩa gì? Luận giải chi tiết về số 0 bạn nên biết",
                                        htmlContent: infor_10,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Câu chuyện chơi lô đề ở đâu cũng có",
                                  Icons.navigate_next,
                                  () {
                                    Get.to(
                                      () => HtmlContentScreen(
                                        titleAppBar: "Câu chuyện chơi lô đề ở đâu cũng có",
                                        htmlContent: infor_11,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Dở khóc dở cười với 4 tuyệt chiêu bán vé số ở Sài Gòn",
                                  Icons.navigate_next,
                                  () {
                                    Get.to(
                                      () => HtmlContentScreen(
                                        titleAppBar: "Dở khóc dở cười với 4 tuyệt chiêu bán vé số ở Sài Gòn",
                                        htmlContent: infor_12,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Chia sẻ kinh nghiệm chơi vietlott mega dễ ăn dễ trúng nhất",
                                  Icons.navigate_next,
                                  () {
                                    Get.to(
                                      () => HtmlContentScreen(
                                        titleAppBar: "Chia sẻ kinh nghiệm chơi vietlott mega dễ ăn dễ trúng nhất",
                                        htmlContent: infor_13,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Mơ thấy người chết - Chiêm bao thấy người chết đánh con gì?",
                                  Icons.navigate_next,
                                  () {
                                    Get.to(
                                      () => HtmlContentScreen(
                                        titleAppBar: "Mơ thấy người chết - Chiêm bao thấy người chết đánh con gì?",
                                        htmlContent: infor_14,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Mơ thấy rắn cắn – Chiêm bao thấy rắn cắn đánh con gì?",
                                  Icons.navigate_next,
                                      () {
                                    Get.to(
                                          () => HtmlContentScreen(
                                        titleAppBar: "Mơ thấy rắn cắn – Chiêm bao thấy rắn cắn đánh con gì?",
                                        htmlContent: infor_15,
                                      ),
                                    );
                                  },
                                ),
                                UIUtils.getButton(
                                  "Xổ số Vietlott có đáng tin hay không?",
                                  Icons.navigate_next,
                                      () {
                                    Get.to(
                                          () => HtmlContentScreen(
                                        titleAppBar: "Xổ số Vietlott có đáng tin hay không?",
                                        htmlContent: infor_16,
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
            ),
          ],
        ),
      ),
    );
  }
}
