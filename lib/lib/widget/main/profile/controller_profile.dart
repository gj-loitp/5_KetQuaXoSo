import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/string_constants.dart';
import 'package:ketquaxoso/lib/core/base_controller.dart';
import 'package:ketquaxoso/lib/model/kqxs.dart';
import 'package:ketquaxoso/lib/util/log_dog_utils.dart';
import 'package:ketquaxoso/lib/util/shared_preferences_util.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dio/dio.dart';

class ControllerProfile extends BaseController {
  var themeIndex = SharedPreferencesUtil.themeIndexNativeView.obs;

  void clearOnDispose() {
    Get.delete<ControllerProfile>();
  }

  Future<void> getThemeIndex() async {
    var index = await SharedPreferencesUtil.getInt(SharedPreferencesUtil.themeIndex);
    if (index != null) {
      themeIndex.value = index;
    }
  }

  void setThemeIndex(int? index) {
    if (index != null) {
      themeIndex.value = index;
      SharedPreferencesUtil.setInt(SharedPreferencesUtil.themeIndex, index);
    }
  }
}
