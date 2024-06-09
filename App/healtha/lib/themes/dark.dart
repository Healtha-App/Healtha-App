import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
    ),
    colorScheme: ColorScheme.dark(
      background: Colors.black,
      primary: Colors.grey.shade900,
      secondary: Color(0xff7c77d1),
    ));