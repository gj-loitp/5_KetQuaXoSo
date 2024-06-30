import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';
import 'package:ketquaxoso/mckimquyen/widget/main/controller_main.dart';

class ChooseLeagueWidget extends StatefulWidget {
  const ChooseLeagueWidget({
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
      var text = _tecSearch.text.toString();
    });
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
                  // Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchView() {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(45)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: TextField(
        controller: _tecSearch,
        autofocus: true,
        textInputAction: TextInputAction.next,
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
    );
  }
}
