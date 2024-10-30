import 'package:flutter/material.dart';

ThemeData dark() => ThemeData(
      primaryColor: Color(0xff008000),
      scaffoldBackgroundColor: Color(0xff323232),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xff8EAF20),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      hintColor: Color(0xffBEC3C7),
      cardColor: Colors.black,
      canvasColor: Colors.white,
      primaryColorLight: Colors.white,
      dividerColor: Color(0xff8EAF20),
    );
