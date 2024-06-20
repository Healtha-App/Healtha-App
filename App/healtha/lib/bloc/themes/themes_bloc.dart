import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:healtha/bloc/themes/themes_event.dart';
import 'package:meta/meta.dart';

part 'themes_state.dart';

class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  ThemesBloc() : super(ThemesInitial());

  @override
  Stream<ThemesState> mapEventToState(
      ThemesEvent event,
      ) async* {
    if (event is ToggleTheme) {
      yield* _mapToggleThemeToState();
    }
  }

  Stream<ThemesState> _mapToggleThemeToState() async* {
    yield state is ThemeLight ? ThemeDark() : ThemeLight();
  }
}
