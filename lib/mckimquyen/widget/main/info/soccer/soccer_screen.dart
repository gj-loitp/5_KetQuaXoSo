import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' show parse;
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/widget/keep_alive_age.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/info_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/soccer/kq1.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/profile/profile_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/vietlot/vietlot_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/xsmb/xsmb_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/xsmn/xsmn_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/xsmt/xsmt_screen.dart';

class SoccerScreen extends StatefulWidget {
  const SoccerScreen(
    this.from, {
    super.key,
  });

  final String from;

  @override
  State<SoccerScreen> createState() => _SoccerScreenState();
}

class _SoccerScreenState extends BaseStatefulState<SoccerScreen> with SingleTickerProviderStateMixin {
  TabController? tabControllerMain;

  final List<Widget> bottomBarPages = [
    const KeepAlivePage(child: KQ1Widget()),
    const KeepAlivePage(child: KQ1Widget()),
    const KeepAlivePage(child: KQ1Widget()),
  ];

  @override
  void initState() {
    super.initState();
    tabControllerMain = TabController(length: bottomBarPages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      extendBody: true,
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildPageView() {
    return TabBarView(
      // physics: const NeverScrollableScrollPhysics(),
      controller: tabControllerMain,
      children: bottomBarPages,
    );
  }

  Widget? _buildBottomBar() {
    return Container(
      color: Colors.grey,
      padding: const EdgeInsets.only(top: 1),
      child: Container(
        color: Colors.white,
        height: 48,
        child: TabBar(
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
          // dividerColor: ColorConstants.appColor,
          // dividerHeight: 0.0,
          // physics: const BouncingScrollPhysics(),
          splashBorderRadius: const BorderRadius.all(Radius.circular(0)),
          tabAlignment: TabAlignment.fill,
          tabs: const <Tab>[
            Tab(
              icon: Icon(Icons.looks_one_outlined),
              text: "XSMN",
              iconMargin: EdgeInsets.only(bottom: 2.0),
            ),
            Tab(
              icon: Icon(Icons.looks_two_outlined),
              text: "XSMT",
              iconMargin: EdgeInsets.only(bottom: 2.0),
            ),
            Tab(
              icon: Icon(Icons.looks_3_outlined),
              text: "XSMB",
              iconMargin: EdgeInsets.only(bottom: 2.0),
            ),
          ],
          // setup the controller
          controller: tabControllerMain,
        ),
      ),
    );
  }
}
