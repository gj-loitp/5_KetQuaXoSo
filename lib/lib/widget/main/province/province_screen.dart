import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';

class ProvinceScreen extends StatefulWidget {
  const ProvinceScreen({
    super.key,
  });

  @override
  State<ProvinceScreen> createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends BaseStatefulState<ProvinceScreen> {
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
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
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
                Expanded(child: _buildViewListProvince()),
              ],
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
                  onTap: () {},
                ),
              );
            }),
      );
    });
  }
}
