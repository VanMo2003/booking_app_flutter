import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/theme_controller.dart';

class ColorConstant {
  static Color getPrimaryColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xff1C3F73)
        : Color(0xff0BA1DA);
  }

  static Color getLoadingColor() {
    return Color(0xff0BA1DA);
  }

  static Color getTextPrimaryColor() {
    return Get.find<ThemeController>().darkTheme ? Colors.white : Colors.black;
  }

  static Color getTextButtonPrimaryColor() {
    return Get.find<ThemeController>().darkTheme ? Colors.white : Colors.black;
  }

  static Color getBackgroundPrimary() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xff323232)
        : Color.fromARGB(255, 237, 237, 237);
  }

  static Color getBackgroundAppBar() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xff008000)
        : Color(0xffE5F1FA);
  }

  static Color getBackgroundGrey() {
    return Get.find<ThemeController>().darkTheme
        ? Colors.black26
        : Colors.grey.shade200;
  }

  static Color getBorder() {
    return Get.find<ThemeController>().darkTheme ? Colors.grey : Colors.black26;
  }

  static Color getWeekendDay() {
    return Get.find<ThemeController>().darkTheme
        ? Colors.grey.shade500
        : Colors.black38;
  }

  static Color getGreyColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFEBF1F1)
        : Color(0xFFBEC3C7);
  }

  static Color getBlackColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFFFFFFF)
        : Color(0xFF000000);
  }

  static Color getWhiteColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF000000)
        : Color(0xFFFFFFFF);
  }
}
