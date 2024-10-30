import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/dimensions.dart';

void showCustomSnackBar(String message, {bool isError = false, int? duration}) {
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.all(DimensionUtils.PADDING_SIZE_SMALL),
        duration: Duration(seconds: duration ?? 3),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(DimensionUtils.BORDER_RADIUS_SMALL),
        ),
        content: Text(message),
      ),
    );
  }
}

void hideSnackBar() {
  ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
}
