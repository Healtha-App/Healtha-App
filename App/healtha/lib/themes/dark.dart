import 'package:flutter/material.dart';
import 'package:healtha/variables.dart';


ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black12,
  ),

  colorScheme: ColorScheme.dark(

    onSurface: Colors.black,
    surface: Colors.black45,
    primary: AppConfig.myPurple,
    onPrimary: Colors.white,
    secondary: Colors.black12,
    onSecondary: AppConfig.myPurple,
    background: Colors.black,
    // error: Colors.red,
    // onBackground: Colors.white,
    // onError: Colors.white,
  ),
);

