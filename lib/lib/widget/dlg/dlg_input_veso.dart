import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DlgInputVeSo extends StatefulWidget {
  const DlgInputVeSo({super.key});

  @override
  State<DlgInputVeSo> createState() => _DlgInputVeSoState();
}

class _DlgInputVeSoState extends State<DlgInputVeSo> {
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: Material(
                child: InkWell(
                  customBorder: const CircleBorder(),
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.black,
                    size: 32.0,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
            ),
            const Text(
              "Mời nhập thông tin",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              height: 52,
              alignment: Alignment.centerRight,
              child: TextField(
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
                    fontSize: 18,
                  ),
                  counterText: "",
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              height: 52,
              alignment: Alignment.centerRight,
              child: TextField(
                controller: _dateController,
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
                    fontSize: 18,
                  ),
                  counterText: "",
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: const Text(
                "Hãy nhập đúng định dạng dd/MM/yyyy",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.redAccent,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > oldValue.text.length && newValue.text.isNotEmpty && oldValue.text.isNotEmpty) {
      if (RegExp('[^0-9/]').hasMatch(newValue.text)) return oldValue;
      if (newValue.text.length > 10) return oldValue;
      if (newValue.text.length == 2 || newValue.text.length == 5) {
        return TextEditingValue(
          text: '${newValue.text}/',
          selection: TextSelection.collapsed(
            offset: newValue.selection.end + 1,
          ),
        );
      } else if (newValue.text.length == 3 && newValue.text[2] != '/') {
        return TextEditingValue(
          text: '${newValue.text.substring(0, 2)}/${newValue.text.substring(2)}',
          selection: TextSelection.collapsed(
            offset: newValue.selection.end + 1,
          ),
        );
      } else if (newValue.text.length == 6 && newValue.text[5] != '/') {
        return TextEditingValue(
          text: '${newValue.text.substring(0, 5)}/${newValue.text.substring(5)}',
          selection: TextSelection.collapsed(
            offset: newValue.selection.end + 1,
          ),
        );
      }
    } else if (newValue.text.length == 1 && oldValue.text.isEmpty && RegExp('[^0-9]').hasMatch(newValue.text)) {
      return oldValue;
    }
    return newValue;
  }
}
