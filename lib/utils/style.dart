import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dimensions.dart';

class StyleUtils {
  static TextStyle titleLarge = GoogleFonts.roboto(
    fontSize: DimensionUtils.FONT_SIZE_TITLE_LARGE,
    fontWeight: FontWeight.bold,
  );
  static TextStyle button = GoogleFonts.roboto(
    fontWeight: FontWeight.bold,
    fontSize: DimensionUtils.FONT_SIZE_LARGE,
  );

  static TextStyle buttonLink = GoogleFonts.roboto(
    fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
    color: Colors.blueAccent,
  );

  static TextStyle styleDefault = GoogleFonts.roboto(
    fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
  );
  static TextStyle styleTitleDefault = GoogleFonts.roboto(
    fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
  );

  static DefaultTextStyle defaultTextStyle(
      {required String text, TextStyle? style}) {
    return DefaultTextStyle(
      style: style ??
          styleDefault.copyWith(
            color: Theme.of(Get.context!).primaryColorLight,
          ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
