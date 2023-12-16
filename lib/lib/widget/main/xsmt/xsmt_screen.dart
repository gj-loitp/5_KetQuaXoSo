import 'package:flutter/material.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/common/const/string_constants.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class XSMTScreen extends StatefulWidget {
  const XSMTScreen({
    super.key,
  });

  @override
  State<XSMTScreen> createState() => _XSMTScreenState();
}

class _XSMTScreenState extends BaseStatefulState<XSMTScreen> {
  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white);

  @override
  void initState() {
    super.initState();
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) async {
          debugPrint("roy93~ onPageFinished");
          addBottomSpace();
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.prevent;
        },
      ),
    );
    _controller.loadRequest(Uri.parse(StringConstants.kqMienTrung));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).viewPadding.top, 0, 0),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        color: ColorConstants.bkg,
        child: _buildWebView(),
      ),
    );
  }

  Widget _buildWebView() {
    return WebViewWidget(controller: _controller);
  }

  Future<void> addBottomSpace() async {
    const script = '''
      var spaceDiv = document.createElement("div");
      spaceDiv.style.height = "150px";
      document.body.appendChild(spaceDiv);
    ''';

    await _controller.runJavaScript(script);
  }
}
