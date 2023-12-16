import 'package:get/get.dart';
import 'package:ketquaxoso/lib/core/base_controller.dart';
import 'package:ketquaxoso/lib/util/log_dog_utils.dart';

class ControllerXSMN extends BaseController {
  var selectedDateTime = DateTime.now().obs;

  void clearOnDispose() {
    Get.delete<ControllerXSMN>();
  }

  void setSelectedDateTime(DateTime dateTime) {
    selectedDateTime.value = dateTime;
  }
}
