import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black),
  ),

  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.white,
    secondary: Color(0xff7c77d1),
  ),
);