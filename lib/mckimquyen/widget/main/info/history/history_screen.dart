import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/db/history.dart';
import 'package:ketquaxoso/mckimquyen/util/ui_utils.dart';
import 'package:ketquaxoso/mckimquyen/util/url_launcher_utils.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/controller_main.dart';
import 'package:slider_button/slider_button.dart';

//TODO roy93~ xoa tat ca
//TODO roy93~ xoa tung item
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    super.key,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends BaseStatefulState<HistoryScreen> {
  final ControllerMain _controllerMain = Get.find();

  @override
  void initState() {
    super.initState();
    _controllerMain.getListHistory();
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
                            "Lịch sử dò nhanh",
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
    return Obx(() {
      var listHistory = _controllerMain.listHistory;
      if (listHistory.isEmpty) {
        return _buildEmptyView();
      } else {
        return _buildListView(listHistory);
      }
    });
  }

  Widget _buildEmptyView() {
    return Container(
      color: Colors.transparent,
      width: Get.width,
      height: Get.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/anim_1.gif",
            height: 250,
            fit: BoxFit.cover,
          ),
          const Text(
            "Chưa có lịch sử dò nhanh",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<History> listHistory) {
    return Container(
      color: Colors.transparent,
      width: Get.width,
      height: Get.height,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: listHistory.length,
        itemBuilder: (context, i) {
          return _buildItemView(listHistory[i]);
        },
      ),
    );
  }

  Widget _buildItemView(History history) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: Colors.white.withOpacity(0.9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Dò số:",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(45),
                  ),
                  color: Colors.yellow,
                ),
                child: Text(
                  history.number ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Ngày:",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Text(
                history.datetime ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
          if (history.province?.name?.isNotEmpty == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Đài:",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  history.province?.name ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
