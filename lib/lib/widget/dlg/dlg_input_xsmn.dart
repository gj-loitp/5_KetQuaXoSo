import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/formatter/date_text_formatter.dart';
import 'package:ketquaxoso/lib/util/duration_util.dart';
import 'package:ketquaxoso/lib/widget/main/controller_main.dart';

class DlgInputXSMN extends StatefulWidget {
  const DlgInputXSMN({super.key});

  @override
  State<DlgInputXSMN> createState() => _DlgInputXSMNState();
}

class _DlgInputXSMNState extends State<DlgInputXSMN> {
  final ControllerMain _controllerMain = Get.find();
  final TextEditingController _tecNumber = TextEditingController();
  final TextEditingController _tecDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tecNumber.addListener(() {
      var text = _tecNumber.text.toString();
      _controllerMain.setCurrentNumberXSMN(text);
    });
    _tecDate.addListener(() {
      var text = _tecDate.text.toString();
      _controllerMain.setCurrentDateXSMN(text);
    });
    var currentSelectedDateTime = _controllerMain.xsmnSelectedDateTime.value;
    var sCurrentSelectedDateTime = DurationUtils.getFormattedDate(currentSelectedDateTime);
    _tecDate.text = sCurrentSelectedDateTime;

    var sCurrentSearchNumber = _controllerMain.xsmnCurrentSearchNumber.value;
    if (sCurrentSearchNumber.isNotEmpty) {
      _tecNumber.text = sCurrentSearchNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.transparent,
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
            return Center(
              child: Container(
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
            );
          }),
        ],
      ),
    );
  }

  Widget _buildViewBody() {
    var msgInvalidCurrentSearchDate = _controllerMain.msgInvalidCurrentSearchDateXSMN();
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
              autofocus: true,
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
    _controllerMain.applySearchXSMN();
    Get.back();
  }
}
