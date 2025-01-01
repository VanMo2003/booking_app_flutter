import 'dart:developer';

import 'package:booking_app_demo/controller/payment_controller.dart';
import 'package:booking_app_demo/helpers/route_helper.dart';
import 'package:booking_app_demo/views/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import '../home/user/user_sceen.dart';

class VNPayPaymentScreen extends StatefulWidget {
  const VNPayPaymentScreen({super.key, required this.paymentUrl});

  final String paymentUrl;

  @override
  _VNPayPaymentScreenState createState() => _VNPayPaymentScreenState();
}

class _VNPayPaymentScreenState extends State<VNPayPaymentScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.paymentUrl))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (url.contains("callback")) {
              _handleCallback(url);
            }
          },
        ),
      );
  }

  void _handleCallback(String url) {
    log(url);

    Get.find<PaymentController>().callbackPayment(url.split("?")[1]).then(
      (value) {
        if (value == 200) {
          Get.offAll(const UserScreen());
          if (Get.find<PaymentController>().paymentResponse!.code == "00") {
            showCustomSnackBar("Thanh toán thành công");
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thanh toán VNPay")),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
