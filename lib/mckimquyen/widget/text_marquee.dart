import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/mckimquyen/common/v/text_slide_animation.dart';

import '../core/base_stateful_state.dart';
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
      var onOffTextOverflow = _controllerMain.isSettingOnTextOverflow.value;
      if (onOffTextOverflow == true) {
        return TextSlideAnimation(
          widget.text,
          const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        );
      } else {
        return Text(
          widget.text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        );
      }
    });
  }
}
