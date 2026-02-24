import 'dart:convert';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/api_path.dart' show ApiPath;

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  final String type;

  const WebViewScreen({
    super.key,
    required this.url,
    this.title = "Loading...",
    required this.type,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool isLoading = true;
  @override
  void dispose() {
    _controller.clearCache(); // Optional
    super.dispose();
  }

  @override
  void initState() {
    print("typetype${widget.type}");
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (mounted) setState(() => isLoading = true);
            _handleNavigation(url);
          },
          onPageFinished: (url) {
            if (mounted) setState(() => isLoading = false);
            _handleNavigation(url);
          },
          onWebResourceError: (error) {
            print('❌ WebView Error: ${error.description}');
            if (mounted) setState(() => isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url)); // 👇 This is initial URL

  }

  void _handleNavigation(String url) {
    if (!mounted) return;

    if (widget.type == "order") {
      if (url.contains("${ApiPath.baseUrlStrip}/orders/success")) {
        _handlePaymentResult(url, isSuccess: true, isOrder: true);
      } else if (url.contains("${ApiPath.baseUrlStrip}/orders/cancel")) {
        _handlePaymentResult(url, isSuccess: false, isOrder: true);
      }
    } /*else if (widget.type == "purchasePlan") {
      print("falseeeeeeeeeee11111111");
      if (url.contains("https://dev.cookingchamps.info/purchase-plan/success")) {
        print("falseeeeeeeeeee");
        _handlePaymentResult(url, isSuccess: true, isOrder: true);
      } else if (url.contains("https://dev.cookingchamps.info/purchase-plan/cancel")) {
        print("truuuuuuuuuuuuu");
        _handlePaymentResult(url, isSuccess: false, isOrder: true);
      }
    }*/ else {
      if (url.contains("${ApiPath.baseUrlStrip}/payment/success")) {
        _handlePaymentResult(url, isSuccess: true);
      } else if (url.contains("${ApiPath.baseUrlStrip}/payment/cancel")) {
        _handlePaymentResult(url, isSuccess: false);
      }
    }
  }


  Future<void> _handlePaymentResult(String url, {required bool isSuccess, bool isOrder = false}) async {
    try {
      final result = await _controller.runJavaScriptReturningResult("document.body.innerText");

      String rawString = result.toString()
          .replaceAll(r'\"', '"')
          .replaceAll(r'\n', '')
          .replaceAll(RegExp(r'^"|"$'), '');

      if (!rawString.trim().startsWith('{')) {
        rawString = '{$rawString}';
      }

      final json = jsonDecode(rawString);
      if (json.containsKey('status') && json['status'] is bool) {
        final bool status = json['status'];
        final String message = json['message'] ?? (status ? "Payment successful." : "Payment failed.");

        if (mounted) {
          Navigator.pop(context, {
            'status': status,
            'message': message,
          });
        }
      }
    } catch (e) {
      debugPrint("Error parsing WebView response: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        title: widget.title,
        centerTitle: false,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(color: MyColor.appTheme),
            ),
        ],
      ),
    );
  }
}