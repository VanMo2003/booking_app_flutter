import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dimensions.dart';

class StyleUtils {
  static TextStyle titleLarge = GoogleFonts.roboto(
    fontSize: DimensionUtils.FONT_SIZE_TITLE_LARGE,
    fontWeight: FontWeight.bold,
  );
  static TextStyle titleItem = GoogleFonts.roboto(
    color: Colors.black,
    fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
    fontWeight: FontWeight.bold,
  );
  static TextStyle link = GoogleFonts.roboto(
    fontSize: DimensionUtils.FONT_SIZE_SMALL,
    decoration: TextDecoration.underline,
    decorationColor: Color(0xFF657786).withOpacity(0.7),
    color: Color(0xFF657786).withOpacity(0.7),
  );
  static TextStyle addressItem = GoogleFonts.roboto(
    fontSize: DimensionUtils.FONT_SIZE_EXTRA_SMALL,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF657786),
  );
  static TextStyle priceItem = GoogleFonts.roboto(
    fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
    color: const Color(0xFF1e98d0),
    fontWeight: FontWeight.w800,
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
    color: Colors.white,
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
