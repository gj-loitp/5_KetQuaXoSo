import 'package:flutter/material.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({
    super.key,
  });

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends BaseStatefulState<TrackingScreen> {
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
      ),
    );
  }
}
