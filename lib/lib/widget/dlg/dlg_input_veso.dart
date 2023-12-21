import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DlgInputVeSo extends StatefulWidget {
  const DlgInputVeSo({super.key});

  @override
  State<DlgInputVeSo> createState() => _DlgInputVeSoState();
}

class _DlgInputVeSoState extends State<DlgInputVeSo> {
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
          ],
        ),
      ),
    );
  }
}
