import 'package:flutter/material.dart';


@immutable
abstract class ThemesEvent {}

class UpdateThemeEvent extends ThemesEvent {
  final ThemeData themeData;

  UpdateThemeEvent(this.themeData);
}

class ToggleTheme extends ThemesEvent {}


