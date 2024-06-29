import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/common/const/hero_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';

class SoccerScreen extends StatefulWidget {
  const SoccerScreen(
    this.from, {
    super.key,
  });

  final String from;

  @override
  State<SoccerScreen> createState() => _SoccerScreenState();
}

class _SoccerScreenState extends BaseStatefulState<SoccerScreen> {
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
                  Material(
                    color: Colors.transparent,
                    child: Container(
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
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: _buildBodyView()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyView() {
    return Container();
  }
}
