import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/common/const/hero_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/widget/keep_alive_age.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/soccer/league/league_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/soccer/team/team_screen.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/soccer/upcoming/upcoming_match_screen.dart';

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
    const KeepAlivePage(child: LeagueWidget()),
    const KeepAlivePage(child: UpcomingMatchWidget()),
    const KeepAlivePage(child: TeamScreen()),
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
    return Stack(
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
                margin: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Hero(
                      tag: "${widget.from}${HeroConstants.appBarLeftIcon}",
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
                    const SizedBox(width: 16),
                    Expanded(
                      child: Hero(
                        tag: "${widget.from}${HeroConstants.appBarTitle}",
                        child: const Material(
                          color: Colors.transparent,
                          child: Text(
                            "CLB bóng đá",
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
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabControllerMain,
                  children: bottomBarPages,
                ),
              ),
            ],
          ),
        ),
      ],
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
              icon: Icon(Icons.gradient),
              text: "Giải đấu",
              iconMargin: EdgeInsets.only(bottom: 2.0),
            ),
            Tab(
              icon: Icon(Icons.access_time_outlined),
              text: "Trận đấu sắp tới",
              iconMargin: EdgeInsets.only(bottom: 2.0),
            ),
            Tab(
              icon: Icon(Icons.favorite_outlined),
              text: "Đội của tôi",
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
