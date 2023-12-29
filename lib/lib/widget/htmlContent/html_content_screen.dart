import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';

class HtmlContentScreen extends StatefulWidget {
  final String? titleAppBar;
  final String? htmlContent;

  const HtmlContentScreen({
    super.key,
    required this.titleAppBar,
    required this.htmlContent,
  });

  @override
  State<HtmlContentScreen> createState() => _HtmlContentScreenState();
}

class _HtmlContentScreenState extends BaseStatefulState<HtmlContentScreen> {
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
        child: Stack(
          children: [
            Image.asset(
              "assets/images/bkg_3.jpg",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
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
                      Expanded(
                        child: Text(
                          widget.titleAppBar ?? "",
                          style: const TextStyle(
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: MaterialButton(
                          onPressed: () {
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
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      color: Colors.white,
                    ),
                    child: HtmlWidget(
                      widget.htmlContent ?? "",
                      renderMode: RenderMode.listView,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      enableCaching: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
