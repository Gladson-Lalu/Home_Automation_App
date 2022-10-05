import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  final SharedPreferences _prefs;
  ThemeModeCubit(this._prefs)
      : super(const ThemeModeInitial(
          ThemeMode.light,
        )) {
    _prefs.getString('themeMode') ==
            ThemeMode.dark.toString()
        ? emit(const ThemeModeChanged(ThemeMode.dark))
        : emit(const ThemeModeChanged(ThemeMode.light));
  }

  void toggleThemeMode() {
    if (state.themeMode == ThemeMode.light) {
      emit(const ThemeModeChanged(ThemeMode.dark));
      _saveThemeMode(ThemeMode.dark);
    } else {
      emit(const ThemeModeChanged(ThemeMode.light));
      _saveThemeMode(ThemeMode.light);
    }
  }

  void _saveThemeMode(ThemeMode themeMode) {
    _prefs.setString('themeMode', themeMode.toString());
  }
}
