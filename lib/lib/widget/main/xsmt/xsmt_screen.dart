import 'package:flutter/material.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/common/const/string_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class XSMTScreen extends StatefulWidget {
  const XSMTScreen({
    super.key,
  });

  @override
  State<XSMTScreen> createState() => _XSMTScreenState();
}

class _XSMTScreenState extends BaseStatefulState<XSMTScreen> {
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
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                "Chức năng này sẽ được cập nhật ở phiên bản tiếp theo :)~",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
