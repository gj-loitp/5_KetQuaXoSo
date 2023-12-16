import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';

import 'lib/util/ui_utils.dart';

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({
    super.key,
    this.title,
  });

  final String? title;

  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends BaseStatefulState<MyHomePage1> {
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
      appBar: UIUtils.getAppBar(
        "Screen 2",
        () {
          Get.back();
        },
        () {},
        iconData: Icons.policy,
      ),
      body: Container(
        color: Colors.red,
        child: const Text("Screen 2"),
      ),
    );
  }
}
