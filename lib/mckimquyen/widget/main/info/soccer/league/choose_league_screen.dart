import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/hero_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/util/shared_preferences_util.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/controller_main.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/info/soccer/list_league.dart';

class ChooseLeagueWidget extends StatefulWidget {
  final String from;
  final Function(League league)? onTap;

  const ChooseLeagueWidget(
    this.from,
    this.onTap, {
    super.key,
  });

  @override
  State<ChooseLeagueWidget> createState() => _ChooseLeagueWidgetState();
}

class _ChooseLeagueWidgetState extends BaseStatefulState<ChooseLeagueWidget> {
  final ControllerMain _controllerMain = Get.find();
  final TextEditingController _tecSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tecSearch.addListener(() {
      EasyDebounce.debounce(
        'searchLeague',
        const Duration(milliseconds: 500),
        () {
          var text = _tecSearch.text.toString();
          // debugPrint("text $text");
          _controllerMain.searchLeague(text);
        },
      );
    });
    _setupData();
  }

  Future<void> _setupData() async {
    var keyword = await SharedPreferencesUtil.getString(SharedPreferencesUtil.keySearchLeague);
    // debugPrint("_setupData keyword $keyword");
    if (keyword != null) {
      _tecSearch.text = keyword;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        color: Colors.white,
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
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(8, 2, 8, 8),
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
                        const Expanded(
                          child: Text(
                            "Tìm kiếm giải đấu",
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
                  _buildSearchView(),
                  _buildLoadingView(),
                  Expanded(child: _buildListView()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchView() {
    return Hero(
      tag: "${widget.from}${HeroConstants.searchView}",
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(45)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: Material(
          color: Colors.transparent,
          child: TextField(
            controller: _tecSearch,
            autofocus: true,
            textInputAction: TextInputAction.search,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: "Nhập giải đấu",
              hintStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.grey,
                fontSize: 22,
              ),
              counterText: "",
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            ),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 22,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Obx(() {
      var isLoadingListLeague = _controllerMain.isLoadingListLeague.value;
      if (isLoadingListLeague) {
        return Container(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
          width: 50,
          height: 74,
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 6.0,
            strokeCap: StrokeCap.round,
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _buildListView() {
    return Obx(() {
      var list = _controllerMain.listLeague;
      if (list.isEmpty) {
        return SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Image.asset(
                "assets/images/anim_1.gif",
                height: 180,
                fit: BoxFit.cover,
              ),
              const Text(
                "Không tìm thấy giải đấu này",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }
      return Container(
        margin: const EdgeInsets.only(top: 0),
        color: Colors.transparent,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          physics: const BouncingScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, i) {
            var league = list[i];
            return InkWell(
              onTap: () {
                widget.onTap?.call(league);
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(45)),
                  color: Colors.white.withOpacity(0.8),
                ),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: league.src ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const SizedBox(
                        width: 45,
                        height: 45,
                        child: CupertinoActivityIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        league.name ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Icon(Icons.navigate_next),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
