import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/util/ui_utils.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/soccer/tab1.dart';

class SoccerScreen extends StatefulWidget {
  const SoccerScreen({
    super.key,
  });

  @override
  State<SoccerScreen> createState() => _SoccerScreenState();
}

class _SoccerScreenState extends BaseStatefulState<SoccerScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "Câu lạc bộ bóng đá",
        () => Get.back(),
        null,
        backgroundColor: ColorConstants.appColor,
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Tab1(),
          Tab1(),
          Tab1(),
          Tab1(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: SizedBox(
          height: 48,
          child: TabBar(
            tabs: const <Tab>[
              Tab(
                icon: Icon(Icons.add_chart),
                text: "Kết quả",
                iconMargin: EdgeInsets.only(bottom: 2.0),
              ),
              Tab(
                icon: Icon(Icons.calendar_month),
                text: "Lịch",
                iconMargin: EdgeInsets.only(bottom: 2.0),
              ),
              Tab(
                icon: Icon(Icons.live_tv),
                text: "Trực tiếp",
                iconMargin: EdgeInsets.only(bottom: 2.0),
              ),
              Tab(
                icon: Icon(Icons.image_aspect_ratio),
                text: "Xem tỉ lệ",
                iconMargin: EdgeInsets.only(bottom: 2.0),
              ),
            ],
            // setup the controller
            controller: _tabController,
            indicatorColor: ColorConstants.appColor,
            labelColor: ColorConstants.appColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 10,
            ),
            labelPadding: EdgeInsets.zero,
            splashBorderRadius: const BorderRadius.all(Radius.circular(0)),
            tabAlignment: TabAlignment.fill,
          ),
        ),
      ),
    );
  }
}
