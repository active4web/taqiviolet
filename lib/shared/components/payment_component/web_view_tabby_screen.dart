import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


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
        appBar: AppBar(),
        body: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
