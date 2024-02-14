import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';
import 'package:ketquaxoso/lib/widget/main/province/province_screen.dart';

class ProvinceListScreen extends StatefulWidget {
  const ProvinceListScreen({
    super.key,
  });

  @override
  State<ProvinceListScreen> createState() => _ProvinceListScreenState();
}

class _ProvinceListScreenState extends BaseStatefulState<ProvinceListScreen> {
  final ControllerMain _controllerMain = Get.find();

  @override
  void initState() {
    super.initState();
    _controllerMain.genListProvince();
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
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                          height: 40,
                        ),
                        const Expanded(
                          child: Text(
                            "Danh sách các đài",
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
                  Expanded(child: _buildViewListProvince()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewListProvince() {
    return Obx(() {
      var listProvince = _controllerMain.listProvince;
      return CupertinoScrollbar(
        child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
            physics: const BouncingScrollPhysics(),
            itemCount: listProvince.length,
            itemBuilder: (BuildContext context, int index) {
              var province = listProvince[index];
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.transparent,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${province.name}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.to(
                      () => ProvinceScreen(
                        province: province,
                      ),
                    );
                  },
                ),
              );
            }),
      );
    });
  }
}
