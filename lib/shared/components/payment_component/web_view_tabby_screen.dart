import 'package:flutter/material.dart';
import 'package:safsofa/shared/components/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';


class WebViewTabbyScreen extends StatefulWidget {
  const WebViewTabbyScreen({super.key});

  @override
  State<WebViewTabbyScreen> createState() => _WebViewTabbyScreenState();
}

class _WebViewTabbyScreenState extends State<WebViewTabbyScreen> {
  final controller=WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..loadRequest(Uri.parse('https://taqiviolet.com/login-page'));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'tabby'.tr(),
        ),
        body: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
