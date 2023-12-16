import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/log_dog_utils.dart';

import '../lib/util/ui_utils.dart';
import 'controller_login.dart';

class DemoLoginScreen extends StatefulWidget {
  const DemoLoginScreen({
    super.key,
    this.title,
  });

  final String? title;

  @override
  State<DemoLoginScreen> createState() => _DemoLoginScreenState();
}

class _DemoLoginScreenState extends BaseStatefulState<DemoLoginScreen> {
  ControllerLogin controllerLogin = Get.put(ControllerLogin());

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
          Get.back();
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
