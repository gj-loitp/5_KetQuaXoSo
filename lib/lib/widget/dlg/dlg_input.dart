import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/formatter/date_text_formatter.dart';
import 'package:ketquaxoso/lib/model/province.dart';
import 'package:ketquaxoso/lib/util/duration_util.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';
import 'package:ketquaxoso/lib/widget/main/province/province_screen.dart';
import 'package:ketquaxoso/lib/widget/main/xsmn/xsmn_screen.dart';
import 'package:ketquaxoso/lib/widget/main/xsmt/xsmt_screen.dart';

class DlgInput extends StatefulWidget {
  final String callFromScreen;
  final Province? province;

  const DlgInput({
    super.key,
    required this.callFromScreen,
    required this.province,
  });

  @override
  State<DlgInput> createState() => _DlgInputState();
}

class _DlgInputState extends State<DlgInput> {
  final ControllerMain _controllerMain = Get.find();
  final TextEditingController _tecNumber = TextEditingController();
  final TextEditingController _tecDate = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  /*
  if(widget.callFromScreen == XSMNScreen.path){

  }else if(widget.callFromScreen == XSMTScreen.path){

  }
  */

  @override
  void initState() {
    super.initState();
    _tecNumber.addListener(() {
      var text = _tecNumber.text.toString();
      // debugPrint("text $text");
      if (widget.callFromScreen == XSMNScreen.path) {
        _controllerMain.setCurrentNumberXSMN(text);
      } else if (widget.callFromScreen == XSMTScreen.path) {
        _controllerMain.setCurrentNumberXSMT(text);
      } else if (widget.callFromScreen == ProvinceScreen.path) {
        _controllerMain.setCurrentNumberProvince(text);
      }
    });
    _tecDate.addListener(() {
      var text = _tecDate.text.toString();
      if (widget.callFromScreen == XSMNScreen.path) {
        _controllerMain.setCurrentDateXSMN(text);
      } else if (widget.callFromScreen == XSMTScreen.path) {
        _controllerMain.setCurrentDateXSMT(text);
      } else if (widget.callFromScreen == ProvinceScreen.path) {
        _controllerMain.setCurrentDateProvince(text);
      }
    });
    DateTime currentSelectedDateTime;
    if (widget.callFromScreen == XSMNScreen.path) {
      currentSelectedDateTime = _controllerMain.xsmnSelectedDateTime.value;
    } else if (widget.callFromScreen == XSMTScreen.path) {
      currentSelectedDateTime = _controllerMain.xsmtSelectedDateTime.value;
    } else if (widget.callFromScreen == ProvinceScreen.path) {
      currentSelectedDateTime = _controllerMain.provinceSelectedDateTime.value;
    } else {
      currentSelectedDateTime = DateTime.now();
    }

    var sCurrentSelectedDateTime = DurationUtils.getFormattedDate(currentSelectedDateTime);
    _tecDate.text = sCurrentSelectedDateTime;

    var sCurrentSearchNumber = "";
    if (widget.callFromScreen == XSMNScreen.path) {
      sCurrentSearchNumber = _controllerMain.xsmnCurrentSearchNumber.value;
    } else if (widget.callFromScreen == XSMTScreen.path) {
      sCurrentSearchNumber = _controllerMain.xsmtCurrentSearchNumber.value;
    } else if (widget.callFromScreen == ProvinceScreen.path) {
      sCurrentSearchNumber = _controllerMain.provinceCurrentSearchNumber.value;
    }

    if (sCurrentSearchNumber.isNotEmpty) {
      _tecNumber.text = sCurrentSearchNumber;
    }

    //show keyboard & focus to _tecNumber
    DurationUtils.delay(300, () {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/bkg_3.jpg",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Obx(() {
            return Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                  width: double.infinity,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 40,
                        height: 40,
                      ),
                      const Expanded(
                        child: Text(
                          "Nhập vé số của tôi",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 24,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: MaterialButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Get.back();
                          },
                          color: Colors.white,
                          padding: const EdgeInsets.all(0),
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  height: 325,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.white,
                  ),
                  child: _buildViewBody(),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildViewBody() {
    var msgInvalidCurrentSearchDate = "";
    if (widget.callFromScreen == XSMNScreen.path) {
      msgInvalidCurrentSearchDate = _controllerMain.msgInvalidCurrentSearchDateXSMN();
    } else if (widget.callFromScreen == XSMTScreen.path) {
      msgInvalidCurrentSearchDate = _controllerMain.msgInvalidCurrentSearchDateXSMT();
    } else if (widget.callFromScreen == ProvinceScreen.path) {
      msgInvalidCurrentSearchDate = _controllerMain.msgInvalidCurrentSearchDateProvince();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 32,
          width: double.infinity,
          color: Colors.white,
          child: const Text(
            "Mời nhập thông tin",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 52,
          color: Colors.white,
          alignment: Alignment.centerRight,
          child: Focus(
            child: TextField(
              focusNode: _focusNode,
              controller: _tecNumber,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.local_atm),
                hintText: "Nhập đúng dãy số của bạn",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                  fontSize: 15,
                ),
                counterText: "",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
            onFocusChange: (value) {},
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 52,
          color: Colors.white,
          alignment: Alignment.centerRight,
          child: Focus(
            child: TextField(
              controller: _tecDate,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                DateTextFormatter(),
              ],
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                icon: Icon(Icons.date_range),
                hintText: "dd/MM/yyyy",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                  fontSize: 15,
                ),
                counterText: "",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
            onFocusChange: (value) {},
          ),
        ),
        Container(
          height: 32,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Text(
            msgInvalidCurrentSearchDate,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.redAccent,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          height: 52,
          margin: const EdgeInsets.fromLTRB(32, 8, 32, 0),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            onPressed: msgInvalidCurrentSearchDate.isEmpty
                ? () {
                    _applySearch();
                  }
                : null,
            child: const Text('Xác nhận'),
          ),
        ),
      ],
    );
  }

  void _applySearch() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (widget.callFromScreen == XSMNScreen.path) {
      _controllerMain.applySearchXSMN();
    } else if (widget.callFromScreen == XSMTScreen.path) {
      _controllerMain.applySearchXSMT();
    } else if (widget.callFromScreen == ProvinceScreen.path) {
      if (widget.province != null) {
        _controllerMain.applySearchProvince(widget.province!, false, false);
      }
    }
    Get.back();
  }
}
