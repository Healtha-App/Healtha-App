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
    onSurface: Color(0xff7c77d1),
    surface: Colors.white,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Color(0xff7c77d1),
    onSecondary: Colors.black,
    background: Colors.white,

  ),
);