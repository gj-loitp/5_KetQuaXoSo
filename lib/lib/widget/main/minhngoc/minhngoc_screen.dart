import 'package:flutter/material.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';

class MinhNgocScreen extends StatefulWidget {
  const MinhNgocScreen({
    super.key,
  });

  @override
  State<MinhNgocScreen> createState() => _MinhNgocScreenState();
}

class _MinhNgocScreenState extends BaseStatefulState<MinhNgocScreen> {
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
        color: Colors.green,
      ),
    );
  }
}
