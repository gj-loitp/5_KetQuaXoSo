import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/common/const/string_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class XSMBScreen extends StatefulWidget {
  const XSMBScreen({
    super.key,
  });

  @override
  State<XSMBScreen> createState() => _XSMBScreenState();
}

class _XSMBScreenState extends BaseStatefulState<XSMBScreen> {
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
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('Xin chào'),
                    WavyAnimatedText('Chức năng này'),
                    WavyAnimatedText('sẽ được cập nhật'),
                    WavyAnimatedText('ở phiên bản tiếp theo :)~'),
                  ],
                  isRepeatingAnimation: true,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
