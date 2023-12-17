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
        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).viewPadding.top, 0, 0),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        color: ColorConstants.bkg,
      ),
    );
  }
}
