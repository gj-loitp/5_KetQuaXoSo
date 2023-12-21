import 'package:flutter/material.dart';
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
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: Material(
                child: InkWell(
                  customBorder: const CircleBorder(),
                  child: const Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 48.0,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
