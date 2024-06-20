import 'package:flutter/material.dart';
import 'package:healtha/variables.dart';


ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black12,
  ),

  colorScheme: ColorScheme.dark(

    surface: Colors.black45,
    primary: AppConfig.myPurple,
    secondary: Colors.black12,
  ),
);

