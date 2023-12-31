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
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    "Danh sách các đài",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black,
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
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: listProvince.length,
            itemBuilder: (BuildContext context, int index) {
              var province = listProvince[index];
              return ListTile(
                title: Text("${province.name}"),
                leading: const Icon(Icons.person_outline_rounded),
                trailing: const Icon(Icons.select_all_rounded),
                onTap: () {
                },
              );
            }),
      );
    });
  }
}
