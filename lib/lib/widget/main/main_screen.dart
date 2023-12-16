import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/ui_utils.dart';

import 'controller_main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    this.title,
  });

  final String? title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends BaseStatefulState<MainScreen> {
  ControllerMain controllerLogin = Get.put(ControllerMain());

  TextEditingController textControllerId = TextEditingController();
  TextEditingController textControllerPw = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controllerLogin.clearOnDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "Demo",
        () {
          SystemNavigator.pop();
        },
        () {},
        iconData: Icons.policy,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.yellow,
        child: Column(
          children: [
            TextField(
              controller: textControllerId,
              onChanged: (val) {
                controllerLogin.setId(textControllerId.text.toString());
              },
            ),
            TextField(
              controller: textControllerPw,
              onChanged: (val) {
                controllerLogin.setId(textControllerPw.text.toString());
              },
            ),
            TextButton(
                onPressed: () {
                  _doLogin();
                },
                child: const Text("Login")),
          ],
        ),
      ),
    );
  }

  void _doLogin() {
    controllerLogin.callApiLogin();
  }
}
