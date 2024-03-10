import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:ketquaxoso/lib/util/shared_preferences_util.dart';
import 'package:marquee/marquee.dart';

import 'main/controller_main.dart';

class TextMarquee extends StatefulWidget {
  const TextMarquee(
    this.text, {
    super.key,
  });

  final String text;

  @override
  State<StatefulWidget> createState() {
    return _TextMarqueeState();
  }
}

class _TextMarqueeState extends BaseStatefulState<TextMarquee> {
  final ControllerMain _controllerMain = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var onOffTextOverflow = _controllerMain.onOffTextOverflowIndex.value;
      if (onOffTextOverflow == SharedPreferencesUtil.onTextOverflow) {
        return Marquee(
          text: widget.text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          blankSpace: 50.0,
        );
      } else {
        return Text(
          widget.text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        );
      }
    });
  }
}
