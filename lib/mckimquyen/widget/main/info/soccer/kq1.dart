import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' show parse;
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';
import 'package:ketquaxoso/mckimquyen/core/base_stateful_state.dart';

class KQ1Widget extends StatefulWidget {
  const KQ1Widget({
    super.key,
  });

  @override
  State<KQ1Widget> createState() => _KQ1WidgetState();
}

class _KQ1WidgetState extends BaseStatefulState<KQ1Widget> {
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
    return Container(
      width: Get.width,
      height: 500,
      color: Colors.white,
    );
  }
}
